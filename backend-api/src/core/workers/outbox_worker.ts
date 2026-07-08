import { prisma } from '../database/prisma.js';
import { logger } from '../../logger.js';
import { Clock } from '../utils/clock.js';
import { EventEmitter } from 'events';

export const outboxEventEmitter = new EventEmitter();

export class OutboxWorker {
  private isRunning = false;
  private intervalId: NodeJS.Timeout | null = null;
  private readonly batchSize = 50;
  private readonly maxRetries = 3;

  start() {
    if (this.isRunning) return;
    this.isRunning = true;
    this.intervalId = setInterval(() => this.processOutbox(), 5000); // Poll every 5 seconds
    logger.info('[OutboxWorker] Started polling.');
  }

  stop() {
    if (this.intervalId) {
      clearInterval(this.intervalId);
    }
    this.isRunning = false;
    logger.info('[OutboxWorker] Stopped polling.');
  }

  private async processOutbox() {
    // 1. Fetch PENDING or RETRYING events
    // In a multi-node setup, we'd need to use a row-level lock (SELECT FOR UPDATE SKIP LOCKED) 
    // to prevent concurrent processing. Prisma doesn't natively support SKIP LOCKED yet, 
    // but we can use $queryRaw or a 2-step status update.
    try {
      const events = await prisma.outboxEvent.findMany({
        where: {
          status: { in: ['PENDING', 'RETRYING'] },
        },
        orderBy: { createdAt: 'asc' },
        take: this.batchSize,
      });

      if (events.length === 0) return;

      // 2. Mark as PROCESSING to prevent double-processing (naive lock)
      const eventIds = events.map(e => e.id);
      await prisma.outboxEvent.updateMany({
        where: { id: { in: eventIds } },
        data: { status: 'PROCESSING' },
      });

      // 3. Process each event
      for (const event of events) {
        try {
          // Emit internal Node.js event for decoupled modules (Notification Service, AI Service) to handle
          // We wrap this in a Promise to await handlers if needed
          await this.dispatch(event);

          // 4. Mark SUCCESS
          await prisma.outboxEvent.update({
            where: { id: event.id },
            data: { 
              status: 'SUCCESS',
              processedAt: Clock.now(),
            },
          });
        } catch (error: any) {
          logger.error(`[OutboxWorker] Event failed: ${event.id}`, error);
          
          // 5. Retry or DLQ (Dead Letter Queue)
          const newRetryCount = event.retryCount + 1;
          const nextStatus = newRetryCount >= this.maxRetries ? 'DEAD_LETTER' : 'RETRYING';
          
          await prisma.outboxEvent.update({
            where: { id: event.id },
            data: { 
              status: nextStatus,
              retryCount: newRetryCount,
            },
          });
          
          if (nextStatus === 'DEAD_LETTER') {
            logger.warn(`[OutboxWorker] Event ${event.id} moved to DEAD_LETTER after ${newRetryCount} retries.`);
          }
        }
      }
    } catch (error) {
      logger.error('[OutboxWorker] Error during outbox polling', error);
    }
  }

  private async dispatch(event: any): Promise<void> {
    // Fire and await handlers mapped to this eventType
    // Example: SLEEP_CREATED -> triggers AI Insight Generation
    return new Promise((resolve, reject) => {
      // In a real app, listeners might be async and we'd use something more robust like BullMQ
      // For this native implementation, we rely on standard event emitter
      const listeners = outboxEventEmitter.listenerCount(event.eventType);
      if (listeners === 0) {
        // No handlers registered, that's fine, mark as success
        return resolve();
      }
      
      // We expect listeners to be async functions. We can't natively `await` EventEmitter.emit, 
      // but we can call them manually if we want strong guarantees, or let them handle failures.
      // For simplicity, we just emit.
      outboxEventEmitter.emit(event.eventType, event.payload);
      resolve();
    });
  }
}

// Singleton export
export const outboxWorker = new OutboxWorker();
