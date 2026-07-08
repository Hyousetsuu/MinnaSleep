import { AIProvider, AIRequestOptions } from '../domain/ai_provider.js';
import { prisma } from '../../../core/database/prisma.js';
import crypto from 'crypto';
import { logger } from '../../../logger.js';
import { ErrorFactory } from '../../../core/api/error_factory.js';
import { AIInsightDTO, AIRecommendationDTO } from '../domain/ai_dto.js';

export class AIService {
  constructor(private provider: AIProvider) {}

  /**
   * Generates insight with Caching and Usage tracking.
   */
  async getInsight(prompt: string, options: AIRequestOptions): Promise<AIInsightDTO> {
    const promptHash = crypto.createHash('sha256').update(prompt + 'insight' + options.promptVersion).digest('hex');
    
    // 1. Check Cache
    const cached = await prisma.aICache.findUnique({ where: { hash: promptHash } });
    if (cached && cached.expiresAt > new Date()) {
      logger.info(`[AIService] Cache hit for insight (hash: ${promptHash})`);
      // Emit metrics: cache_hit
      return cached.response as unknown as AIInsightDTO;
    }

    // 2. Call Provider
    logger.info(`[AIService] Cache miss for insight. Calling ${this.provider.getProviderName()}`);
    const start = Date.now();
    const result = await this.provider.generateInsight(prompt, options);
    const latency = Date.now() - start;

    // 3. Save to Cache (TTL 24 hours)
    await prisma.aICache.upsert({
      where: { hash: promptHash },
      update: {
        response: result as any,
        expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000),
      },
      create: {
        hash: promptHash,
        provider: this.provider.getProviderName(),
        response: result as any,
        expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000),
      }
    });

    // Emit metrics: latency, provider, cache_miss
    logger.info(`[AIService] Generation complete. Latency: ${latency}ms`);
    
    return result;
  }

  /**
   * Handles heavy background requests by enqueuing them to Outbox.
   */
  async enqueueHeavyJob(userId: string, jobType: string, payload: any): Promise<string> {
    const jobId = crypto.randomUUID();
    
    await prisma.outboxEvent.create({
      data: {
        aggregateId: userId,
        aggregateType: 'USER',
        eventType: jobType, // e.g. 'AI_WEEKLY_REPORT_REQUIRED'
        payload: {
          jobId,
          ...payload
        },
      }
    });

    return jobId;
  }
}
