import { rateLimit } from 'express-rate-limit';

export const RateLimitPolicy = {
  login: {
    ip: rateLimit({
      windowMs: 60 * 1000,
      limit: 30, // 30 req / min per IP
      keyGenerator: (req) => req.ip || 'unknown',
      message: { success: false, error: { code: 'RATE001', message: 'Too many login attempts from this IP' } }
    }),
    email: rateLimit({
      windowMs: 60 * 1000,
      limit: 10, // 10 req / min per Email
      keyGenerator: (req) => req.body.email || 'unknown',
      message: { success: false, error: { code: 'RATE002', message: 'Too many login attempts for this email' } }
    }),
    device: rateLimit({
      windowMs: 60 * 1000,
      limit: 5, // 5 req / min per Device
      keyGenerator: (req) => req.body.deviceId || 'unknown',
      message: { success: false, error: { code: 'RATE003', message: 'Too many login attempts from this device' } }
    }),
  },
  refresh: {
    device: rateLimit({
      windowMs: 60 * 1000,
      limit: 15,
      keyGenerator: (req) => req.body.sessionId || 'unknown', // Using sessionId as proxy for device for refresh
      message: { success: false, error: { code: 'RATE004', message: 'Too many refresh attempts' } }
    })
  },
  sync: {
    device: rateLimit({
      windowMs: 60 * 1000,
      limit: 60,
      keyGenerator: (req) => req.headers['x-device-id'] as string || 'unknown',
      message: { success: false, error: { code: 'RATE005', message: 'Too many sync attempts' } }
    })
  },
  ai: {
    user: rateLimit({
      windowMs: 60 * 1000,
      limit: 10,
      keyGenerator: (req) => (req as any).user?.sub || 'unknown',
      message: { success: false, error: { code: 'AI001', message: 'AI Quota exceeded or too many requests' } }
    })
  }
};
