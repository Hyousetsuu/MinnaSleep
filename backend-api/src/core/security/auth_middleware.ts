import { Request, Response, NextFunction } from 'express';
import { JwtService, JwtPayload } from './jwt_service.js';
import { UserSessionService } from '../../features/auth/domain/user_session_service.js';
import { ResponseEnvelope } from '../api/response_envelope.js';
import { logger } from '../../logger.js';

// Extend Express Request to include user payload
declare global {
  namespace Express {
    interface Request {
      user?: JwtPayload;
    }
  }
}

export const authenticate = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const reqId = req.headers['x-request-id'] as string;
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json(ResponseEnvelope.error('AUTH004', 'Missing or invalid authorization header', reqId));
    }

    const token = authHeader.split(' ')[1];
    const payload = JwtService.verifyAccessToken(token);

    // Verify session is still active
    const session = await UserSessionService.findSession(payload.sid);
    if (!session || session.revokedAt) {
      logger.warn(`[AuthMiddleware] Revoked session used: ${payload.sid}`);
      return res.status(401).json(ResponseEnvelope.error('AUTH004', 'Session revoked or invalid', reqId));
    }

    // Attach to request
    req.user = payload;
    next();
  } catch (error) {
    const reqId = req.headers['x-request-id'] as string || 'unknown';
    return res.status(401).json(ResponseEnvelope.error('AUTH002', 'Access token expired or invalid', reqId));
  }
};

export const optionalAuthenticate = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const authHeader = req.headers.authorization;
    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.split(' ')[1];
      const payload = JwtService.verifyAccessToken(token);
      
      const session = await UserSessionService.findSession(payload.sid);
      if (session && !session.revokedAt) {
        req.user = payload;
      }
    }
  } catch (error) {
    // Ignore errors for optional auth
  }
  next();
};

export const requireRole = (role: string) => {
  return (req: Request, res: Response, next: NextFunction) => {
    const reqId = req.headers['x-request-id'] as string;
    
    if (!req.user) {
      return res.status(401).json(ResponseEnvelope.error('AUTH004', 'Not authenticated', reqId));
    }

    if (req.user.role !== role) {
      return res.status(403).json(ResponseEnvelope.error('AUTH006', 'Forbidden: Insufficient role', reqId));
    }

    next();
  };
};
