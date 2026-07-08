import { EventEmitter } from 'events';
import { prisma } from '../database/prisma.js';
import { logger } from '../../logger.js';

export enum SecurityEvent {
  LOGIN_SUCCESS = 'LOGIN_SUCCESS',
  LOGIN_FAILED = 'LOGIN_FAILED',
  LOGOUT = 'LOGOUT',
  REFRESH_TOKEN = 'REFRESH_TOKEN',
  PASSWORD_CHANGED = 'PASSWORD_CHANGED',
  ACCOUNT_LOCKED = 'ACCOUNT_LOCKED',
}

export enum BusinessEvent {
  PROFILE_UPDATED = 'PROFILE_UPDATED',
  SLEEP_HISTORY_VIEWED = 'SLEEP_HISTORY_VIEWED',
  NOTIFICATION_READ = 'NOTIFICATION_READ',
  AI_INSIGHT_GENERATED = 'AI_INSIGHT_GENERATED',
}

export interface AuditLogPayload {
  actorUserId?: string;
  actorType?: string; // e.g. "USER", "SYSTEM", "ADMIN"
  action: SecurityEvent | BusinessEvent | string;
  resource?: string;
  resourceId?: string;
  requestId?: string;
  
  ipAddress?: string;
  userAgent?: string;
  deviceId?: string;
  country?: string;
  city?: string;
  
  metadata?: Record<string, any>;
  before?: Record<string, any>;
  after?: Record<string, any>;
}

const auditEmitter = new EventEmitter();

auditEmitter.on('audit:async', (payload: AuditLogPayload) => {
  // Use setImmediate to defer execution without starving the event loop
  // (Unlike process.nextTick which has highest priority)
  setImmediate(async () => {
    try {
      await prisma.auditLog.create({
        data: {
          actorUserId: payload.actorUserId,
          actorType: payload.actorType,
          action: payload.action,
          resource: payload.resource,
          resourceId: payload.resourceId,
          requestId: payload.requestId,
          ipAddress: payload.ipAddress,
          userAgent: payload.userAgent,
          deviceId: payload.deviceId,
          country: payload.country,
          city: payload.city,
          metadata: payload.metadata || {},
          before: payload.before || {},
          after: payload.after || {},
        },
      });
      logger.debug(`[Audit Async] ${payload.action} recorded.`);
    } catch (error) {
      logger.error(`[Audit Async] Failed to record audit log for ${payload.action}`, error);
    }
  });
});

export class AuditService {
  /**
   * Persists the audit log synchronously. 
   * MUST be used for Security Events (e.g. Logins, Password Changes).
   */
  static async logSync(payload: AuditLogPayload): Promise<void> {
    try {
      await prisma.auditLog.create({
        data: {
          actorUserId: payload.actorUserId,
          actorType: payload.actorType,
          action: payload.action,
          resource: payload.resource,
          resourceId: payload.resourceId,
          requestId: payload.requestId,
          ipAddress: payload.ipAddress,
          userAgent: payload.userAgent,
          deviceId: payload.deviceId,
          country: payload.country,
          city: payload.city,
          metadata: payload.metadata || {},
          before: payload.before || {},
          after: payload.after || {},
        },
      });
      logger.info(`[Audit Sync] ${payload.action} recorded.`);
    } catch (error) {
      logger.error(`[Audit Sync] Failed to record audit log for ${payload.action}`, error);
      throw error; 
    }
  }

  /**
   * Persists the audit log asynchronously (non-blocking).
   * MUST be used for Business/Operational Events.
   */
  static logAsync(payload: AuditLogPayload): void {
    auditEmitter.emit('audit:async', payload);
  }
}
