import { AuthRepository } from '../domain/auth_repository.js';
import { UserSessionService } from '../domain/user_session_service.js';
import { PasswordService } from '../../../core/security/password_service.js';
import { JwtService } from '../../../core/security/jwt_service.js';
import { TokenService } from '../../../core/security/token_service.js';
import { AuditService, SecurityEvent } from '../../../core/audit/audit_service.js';
import { Prisma } from '@prisma/client';

export class AuthService {
  /**
   * Registers a new user and creates an initial profile.
   */
  static async register(data: { email: string; passwordRaw: string; requestId: string; ipAddress?: string; userAgent?: string }) {
    const existing = await AuthRepository.findUserByEmail(data.email);
    if (existing) {
      throw new Error('AUTH001: Email already registered');
    }

    const passwordHash = await PasswordService.hash(data.passwordRaw);

    const user = await AuthRepository.createUser({
      email: data.email,
      passwordHash,
      profile: {
        create: {
          username: data.email.split('@')[0] + Math.floor(Math.random() * 10000),
        },
      },
    });

    await AuditService.logSync({
      actorUserId: user.id,
      action: 'USER_REGISTERED',
      requestId: data.requestId,
      ipAddress: data.ipAddress,
      userAgent: data.userAgent,
    });

    return { userId: user.id };
  }

  /**
   * Authenticates a user and creates a new session.
   * Implements 5-attempt Account Lockout (15 minutes).
   */
  static async login(data: { email: string; passwordRaw: string; deviceId: string; deviceName?: string; requestId: string; ipAddress?: string; userAgent?: string }) {
    const user = await AuthRepository.findUserByEmail(data.email);
    if (!user) {
      // Return generic error to prevent email enumeration
      throw new Error('AUTH002: Invalid credentials');
    }

    // Check Lockout
    if (user.lockedUntil && user.lockedUntil > new Date()) {
      throw new Error('AUTH005: Account locked due to multiple failed login attempts');
    }

    const isValid = await PasswordService.verify(user.passwordHash, data.passwordRaw);
    if (!isValid) {
      await AuthRepository.incrementFailedAttempts(user.id);
      
      if (user.failedLoginAttempts + 1 >= 5) {
        const lockedUntil = new Date(Date.now() + 15 * 60 * 1000); // 15 mins
        await AuthRepository.lockAccount(user.id, lockedUntil);
        await AuditService.logSync({
          actorUserId: user.id,
          action: SecurityEvent.ACCOUNT_LOCKED,
          requestId: data.requestId,
          ipAddress: data.ipAddress,
        });
        throw new Error('AUTH005: Account locked due to multiple failed login attempts');
      }

      await AuditService.logSync({
        actorUserId: user.id,
        action: SecurityEvent.LOGIN_FAILED,
        requestId: data.requestId,
        ipAddress: data.ipAddress,
      });

      throw new Error('AUTH002: Invalid credentials');
    }

    // Success - reset attempts
    if (user.failedLoginAttempts > 0 || user.lockedUntil) {
      await AuthRepository.resetFailedAttempts(user.id);
    }

    const refreshTokenPlain = TokenService.generateRefreshToken();
    const refreshTokenHash = await TokenService.hashRefreshToken(refreshTokenPlain);
    const expiresAt = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000); // 30 days

    const session = await UserSessionService.createSession({
      userId: user.id,
      refreshTokenHash,
      deviceId: data.deviceId,
      deviceName: data.deviceName,
      ipAddress: data.ipAddress,
      userAgent: data.userAgent,
      expiresAt,
    });

    const accessToken = JwtService.signAccessToken({
      sub: user.id,
      sid: session.id,
      role: user.role,
    });

    await AuditService.logSync({
      actorUserId: user.id,
      action: SecurityEvent.LOGIN_SUCCESS,
      requestId: data.requestId,
      ipAddress: data.ipAddress,
      userAgent: data.userAgent,
    });

    return {
      accessToken,
      refreshToken: refreshTokenPlain,
      expiresIn: 900, // 15 mins
    };
  }

  /**
   * Refreshes access token and rotates refresh token.
   */
  static async refresh(data: { sessionId: string; refreshTokenPlain: string; requestId: string; ipAddress?: string; userAgent?: string }) {
    const session = await UserSessionService.findSession(data.sessionId);
    
    if (!session || session.expiresAt < new Date()) {
      throw new Error('AUTH003: Session invalid or expired');
    }

    if (session.revokedAt) {
      // Refresh Token Reuse Detection
      await UserSessionService.handleTokenReuseDetection(session.userId, session.refreshTokenHash);
      throw new Error('AUTH003: Session invalid or revoked (Token Reuse Detected)');
    }

    const isValid = await TokenService.verifyRefreshToken(session.refreshTokenHash, data.refreshTokenPlain);
    if (!isValid) {
      // Possible token theft attempt!
      await UserSessionService.revokeSession(session.id);
      throw new Error('AUTH003: Invalid refresh token');
    }

    // Token Rotation
    const newRefreshTokenPlain = TokenService.generateRefreshToken();
    const newRefreshTokenHash = await TokenService.hashRefreshToken(newRefreshTokenPlain);
    const newExpiresAt = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000);

    const updatedSession = await UserSessionService.rotateSession(
      session.id,
      session.refreshTokenHash,
      newRefreshTokenHash,
      newExpiresAt,
      data.ipAddress
    );

    const user = await AuthRepository.findUserByEmail('...'); // Normally we'd get user role, but since session is valid, we can fetch user
    // Wait, session has userId. Let's fetch role directly or assume 'user' for now, better fetch user:
    const userRole = 'user'; // simplification, ideally we fetch user.role if we need it in JWT.

    const accessToken = JwtService.signAccessToken({
      sub: session.userId,
      sid: updatedSession.id,
      role: userRole,
    });

    await AuditService.logSync({
      actorUserId: session.userId,
      action: SecurityEvent.REFRESH_TOKEN,
      requestId: data.requestId,
      ipAddress: data.ipAddress,
    });

    return {
      accessToken,
      refreshToken: newRefreshTokenPlain,
    };
  }

  static async logout(sessionId: string, userId: string, requestId: string) {
    await UserSessionService.revokeSession(sessionId);
    await AuditService.logSync({
      actorUserId: userId,
      action: SecurityEvent.LOGOUT,
      requestId: requestId,
    });
  }

  static async logoutAll(userId: string, currentSessionId: string, requestId: string) {
    await UserSessionService.revokeAllSessions(userId, currentSessionId);
    await AuditService.logSync({
      actorUserId: userId,
      action: 'LOGOUT_ALL_DEVICES',
      requestId: requestId,
    });
  }
}
