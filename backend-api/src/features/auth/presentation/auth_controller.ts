import { Request, Response } from 'express';
import { z } from 'zod';
import { AuthService } from '../application/auth_service.js';
import { ResponseEnvelope } from '../../../core/api/response_envelope.js';
import { UserSessionService } from '../domain/user_session_service.js';

// Schemas
const RegisterSchema = z.object({
  email: z.string().email(),
  password: z.string().min(12).regex(/[A-Z]/).regex(/[a-z]/).regex(/[0-9]/, "Password must contain at least 1 uppercase, 1 lowercase, and 1 number"),
});

const LoginSchema = z.object({
  email: z.string().email(),
  password: z.string(),
  deviceId: z.string().min(1),
  deviceName: z.string().optional(),
});

const RefreshSchema = z.object({
  sessionId: z.string().uuid(),
  refreshToken: z.string().min(1),
});

// Controller
export class AuthController {
  
  static async register(req: Request, res: Response) {
    try {
      const parsed = RegisterSchema.parse(req.body);
      const reqId = req.headers['x-request-id'] as string;
      
      const result = await AuthService.register({
        email: parsed.email,
        passwordRaw: parsed.password,
        requestId: reqId,
        ipAddress: req.ip,
        userAgent: req.headers['user-agent'],
      });

      res.status(201).json(ResponseEnvelope.success(result, reqId));
    } catch (e: any) {
      const reqId = req.headers['x-request-id'] as string || 'unknown';
      if (e instanceof z.ZodError) {
        return res.status(400).json(ResponseEnvelope.error('VAL001', 'Validation failed', reqId));
      }
      res.status(400).json(ResponseEnvelope.error('AUTH_ERR', e.message, reqId));
    }
  }

  static async login(req: Request, res: Response) {
    try {
      const parsed = LoginSchema.parse(req.body);
      const reqId = req.headers['x-request-id'] as string;
      
      const result = await AuthService.login({
        email: parsed.email,
        passwordRaw: parsed.password,
        deviceId: parsed.deviceId,
        deviceName: parsed.deviceName,
        requestId: reqId,
        ipAddress: req.ip,
        userAgent: req.headers['user-agent'],
      });

      res.status(200).json(ResponseEnvelope.success(result, reqId));
    } catch (e: any) {
      const reqId = req.headers['x-request-id'] as string || 'unknown';
      const isLockout = e.message.includes('AUTH005');
      res.status(isLockout ? 429 : 401).json(ResponseEnvelope.error(isLockout ? 'AUTH005' : 'AUTH002', e.message, reqId));
    }
  }

  static async refresh(req: Request, res: Response) {
    try {
      const parsed = RefreshSchema.parse(req.body);
      const reqId = req.headers['x-request-id'] as string;
      
      const result = await AuthService.refresh({
        sessionId: parsed.sessionId,
        refreshTokenPlain: parsed.refreshToken,
        requestId: reqId,
        ipAddress: req.ip,
        userAgent: req.headers['user-agent'],
      });

      res.status(200).json(ResponseEnvelope.success(result, reqId));
    } catch (e: any) {
      const reqId = req.headers['x-request-id'] as string || 'unknown';
      res.status(401).json(ResponseEnvelope.error('AUTH003', e.message, reqId));
    }
  }

  // Uses authenticate middleware
  static async logout(req: Request, res: Response) {
    try {
      const reqId = req.headers['x-request-id'] as string;
      const { sid, sub } = (req as any).user;
      
      await AuthService.logout(sid, sub, reqId);
      res.status(200).json(ResponseEnvelope.success({ success: true }, reqId));
    } catch (e: any) {
      res.status(500).json(ResponseEnvelope.error('SYS001', 'Logout failed', req.headers['x-request-id'] as string));
    }
  }

  // Uses authenticate middleware
  static async getSessions(req: Request, res: Response) {
    try {
      const reqId = req.headers['x-request-id'] as string;
      const { sub } = (req as any).user;
      
      const sessions = await UserSessionService.getActiveSessions(sub);
      res.status(200).json(ResponseEnvelope.success(sessions, reqId));
    } catch (e: any) {
      res.status(500).json(ResponseEnvelope.error('SYS001', 'Fetch sessions failed', req.headers['x-request-id'] as string));
    }
  }
}
