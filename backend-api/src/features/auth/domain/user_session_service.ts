import { prisma } from '../../../core/database/prisma.js';
import { UserSession } from '@prisma/client';
import { logger } from '../../../logger.js';

export class UserSessionService {
  /**
   * Creates a new session in the database.
   */
  static async createSession(data: {
    userId: string;
    refreshTokenHash: string;
    deviceId: string;
    deviceName?: string;
    deviceModel?: string;
    os?: string;
    browser?: string;
    platform?: string;
    ipAddress?: string;
    userAgent?: string;
    expiresAt: Date;
  }): Promise<UserSession> {
    return prisma.userSession.create({
      data,
    });
  }

  /**
   * Finds an active session by ID.
   */
  static async findSession(sessionId: string): Promise<UserSession | null> {
    return prisma.userSession.findUnique({
      where: { id: sessionId },
    });
  }

  /**
   * Revokes a session and replaces it with a new refresh token (Rotation).
   * Implements lineage tracking via parentTokenId.
   */
  static async rotateSession(
    sessionId: string,
    oldRefreshTokenHash: string,
    newRefreshTokenHash: string,
    newExpiresAt: Date,
    ipAddress?: string
  ): Promise<UserSession> {
    return prisma.userSession.update({
      where: { id: sessionId },
      data: {
        refreshTokenHash: newRefreshTokenHash,
        parentTokenId: oldRefreshTokenHash,
        rotatedFrom: oldRefreshTokenHash,
        expiresAt: newExpiresAt,
        lastUsedAt: new Date(),
        ipAddress,
      },
    });
  }

  /**
   * Detects Reuse. If a revoked token is used, revokes ALL sessions for this user (or family)
   * to protect the account from session hijacking.
   */
  static async handleTokenReuseDetection(userId: string, stolenTokenHash: string): Promise<void> {
    logger.warn(`[SECURITY] Refresh Token Reuse Detected for user ${userId}. Revoking all sessions.`);
    await prisma.userSession.updateMany({
      where: { userId },
      data: {
        revokedAt: new Date(),
        revokedReason: 'TOKEN_REUSE_DETECTED_HIJACK_PREVENTION',
      },
    });
  }

  /**
   * Revokes a specific session immediately.
   */
  static async revokeSession(sessionId: string, reason: string = 'USER_LOGOUT'): Promise<void> {
    await prisma.userSession.update({
      where: { id: sessionId },
      data: {
        revokedAt: new Date(),
        revokedReason: reason,
      },
    });
  }

  /**
   * Revokes all active sessions for a user (except optionally the current one).
   */
  static async revokeAllSessions(userId: string, exceptSessionId?: string): Promise<void> {
    await prisma.userSession.updateMany({
      where: {
        userId,
        revokedAt: null,
        ...(exceptSessionId ? { id: { not: exceptSessionId } } : {}),
      },
      data: {
        revokedAt: new Date(),
        revokedReason: 'USER_LOGOUT_ALL',
      },
    });
  }

  /**
   * Get all active sessions for a user.
   */
  static async getActiveSessions(userId: string): Promise<UserSession[]> {
    return prisma.userSession.findMany({
      where: {
        userId,
        revokedAt: null,
        expiresAt: { gt: new Date() },
      },
      orderBy: { lastUsedAt: 'desc' },
    });
  }
}
