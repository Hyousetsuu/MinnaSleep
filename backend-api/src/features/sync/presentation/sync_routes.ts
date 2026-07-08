import { Router } from 'express';
import { SyncController } from './sync_controller.js';
import { authenticate } from '../../../core/security/auth_middleware.js';
import { RateLimitPolicy } from '../../../core/security/rate_limit_policy.js';
import { idempotencyMiddleware } from '../../../core/security/idempotency_middleware.js';

const router = Router();

// Middleware sequence:
// 1. Authenticate (must know user for rate limiting & idempotency)
// 2. Rate Limit (protect resources)
// 3. Idempotency (prevent double processing)
// 4. Contract Version Check (ensure compatibility) - Added inline or via another middleware
const contractVersionCheck = (req: any, res: any, next: any) => {
  const clientVersion = req.headers['x-contract-version'];
  if (clientVersion && clientVersion < '2026-07') {
    return res.status(426).json({
      success: false,
      error: { code: 'SYNC005', message: 'Upgrade Required' },
      requestId: req.headers['x-request-id']
    });
  }
  next();
};

const middlewares = [
  authenticate,
  RateLimitPolicy.sync.device,
  contractVersionCheck,
  idempotencyMiddleware
];

router.post('/', middlewares, SyncController.sync);
router.get('/status', middlewares, SyncController.getStatus);
router.post('/retry', middlewares, SyncController.retry);

export const syncRouter = router;
