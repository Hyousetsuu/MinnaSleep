import { Request, Response } from 'express';
import { ResponseEnvelope } from '../../../core/api/response_envelope.js';
import { AIService } from '../application/ai_service.js';
import { GeminiProvider } from '../data/gemini_provider.js';
import { PromptBuilder } from '../application/prompt_builder.js';
import { AIQuotaService } from '../application/ai_quota_service.js';
import { IdGenerator } from '../../../core/utils/id_generator.js';

// Instantiate dependencies
const geminiProvider = new GeminiProvider();
const aiService = new AIService(geminiProvider);

export class AIController {
  static async getDailyInsight(req: Request, res: Response) {
    const reqId = req.headers['x-request-id'] as string || IdGenerator.generateUuid();
    const userId = (req as any).user.sub;

    try {
      // 1. Quota Check
      await AIQuotaService.checkAndDecrementQuota(userId);

      // 2. Build Context (Mocked for now, normally fetched from Sleep Repo)
      const mockSleep = { durationMinutes: 380, qualityScore: 75, bedTime: '23:00', wakeTime: '05:20' };
      const prompt = PromptBuilder.buildInsightPrompt(mockSleep);

      // 3. Generate Insight with Cache & Metrics
      const insight = await aiService.getInsight(prompt, {
        userId,
        requestId: reqId,
        promptVersion: 1, // Phase 3: Prompt Versioning
      });

      // 4. Return Standard Envelope
      const wrappedResponse = {
        schemaVersion: 1,
        promptVersion: 1,
        provider: geminiProvider.getProviderName(),
        data: insight,
      };

      return res.status(200).json(ResponseEnvelope.success(wrappedResponse, reqId));
    } catch (e: any) {
      const status = e.status || 500;
      return res.status(status).json(ResponseEnvelope.error(e.code || 'SYS001', e.message, reqId));
    }
  }
}
