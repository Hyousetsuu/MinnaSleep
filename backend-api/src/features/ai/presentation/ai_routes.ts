import { Router } from 'express';
import { AIController } from './ai_controller.js';
import { authenticate } from '../../../core/security/auth_middleware.js';
import { RateLimitPolicy } from '../../../core/security/rate_limit_policy.js';

const router = Router();

// Phase 3: AI Rate Limiter attached to controllers
const middlewares = [
  authenticate,
  RateLimitPolicy.ai.user
];

router.get('/insight', middlewares, AIController.getDailyInsight);

export const aiRouter = router;
