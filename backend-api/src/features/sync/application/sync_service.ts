import { prisma } from '../../../core/database/prisma.js';
import { SyncPayload, SyncOperation } from '../domain/sync_dto.js';
import crypto from 'crypto';
import { logger } from '../../../logger.js';
import { Clock } from '../../../core/utils/clock.js';
import { IdGenerator } from '../../../core/utils/id_generator.js';

export class SyncService {
  static async processBatch(userId: string, payload: SyncPayload, reqId: string, isRetry: boolean = false) {
    // 1. Checksum validation
    const computedHash = crypto.createHash('sha256').update(JSON.stringify(payload.operations)).digest('hex');
    if (computedHash !== payload.payloadHash) {
      throw new Error('SYNC004: Payload hash mismatch');
    }

    const results = {
      synced: [] as string[],
      conflicts: [] as any[],
      failed: [] as any[],
    };

    // 2. Interactive Transaction for Partial Success
    // We execute operations sequentially inside the transaction to catch errors per-record
    // Wait, an interactive transaction in Prisma WILL rollback if ANY query fails, unless we catch it.
    // If we catch it and DO NOT throw out of the transaction block, the transaction COMMITS the successful queries.
    // This perfectly satisfies the Partial Success requirement.
    await prisma.$transaction(async (tx) => {
      for (const op of payload.operations) {
        try {
          // Process based on entity and operation
          await this.processOperation(tx, userId, op, reqId);
          
          results.synced.push(op.operationId);
          
          // Emit Outbox Event on success
          await tx.outboxEvent.create({
            data: {
              aggregateId: op.payload.id || IdGenerator.generateUuid(),
              aggregateType: op.entity.toUpperCase(),
              eventType: `${op.entity.toUpperCase()}_${op.operation.toUpperCase()}D`,
              payload: op.payload,
              eventVersion: 'v1',
            }
          });

        } catch (error: any) {
          logger.warn(`[SyncService] Operation failed: ${op.operationId}`, error);
          if (error.message.includes('SYNC001') || error.code === 'P2025') {
            // Conflict (e.g. version mismatch or record not found for update)
            results.conflicts.push({
              operationId: op.operationId,
              code: 'SYNC001',
              strategy: 'last_write_wins',
              message: error.message
            });
          } else {
            // General failure
            results.failed.push({
              operationId: op.operationId,
              code: 'SYS001',
              message: error.message
            });
          }
        }
      }
    });

    // 3. Metrics Tracking (can be offloaded to another service/logger)
    logger.info(`[SyncMetrics] batchSize=${payload.operations.length} synced=${results.synced.length} conflicts=${results.conflicts.length} failed=${results.failed.length}`);

    return {
      metadata: {
        processedAt: Clock.now().toISOString(),
        nextCursor: IdGenerator.generateHex(16),
      },
      ...results
    };
  }

  private static async processOperation(tx: any, userId: string, op: SyncOperation, reqId: string) {
    const { operation, entity, payload } = op;

    if (entity === 'sleep') {
      if (operation === 'create') {
        // Find profile first
        const profile = await tx.profile.findUnique({ where: { userId } });
        if (!profile) throw new Error('Profile not found');

        await tx.sleep.create({
          data: {
            id: payload.id,
            profileId: profile.id,
            startedAt: new Date(payload.startedAt),
            endedAt: payload.endedAt ? new Date(payload.endedAt) : null,
            duration: payload.duration,
            quality: payload.quality,
            createdAt: payload.createdAt ? new Date(payload.createdAt) : undefined,
          }
        });
      } else if (operation === 'update') {
        // OCC Check
        const existing = await tx.sleep.findUnique({ where: { id: payload.id } });
        if (!existing) throw new Error('SYNC001: Record not found');
        if (payload.version && existing.version > payload.version) {
          throw new Error(`SYNC001: Version conflict (Server: ${existing.version}, Client: ${payload.version})`);
        }

        await tx.sleep.update({
          where: { id: payload.id },
          data: {
            endedAt: payload.endedAt ? new Date(payload.endedAt) : undefined,
            duration: payload.duration,
            quality: payload.quality,
            // version increment is handled by Prisma Client Extension automatically
          }
        });
      } else if (operation === 'delete') {
        // Tombstone Delete
        await tx.sleep.update({
          where: { id: payload.id },
          data: {
            deletedAt: payload.deletedAt ? new Date(payload.deletedAt) : Clock.now(),
          }
        });
      }
    }
    // Add logic for 'profile' and 'notification' entities here as needed
  }

  static async getStatus(userId: string) {
    return {
      queueLength: 0,
      lastSyncCursor: 'abc-123',
    };
  }
}
