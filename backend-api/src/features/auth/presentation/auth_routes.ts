import { Router } from 'express';
import { AuthController } from './auth_controller.js';
import { RateLimitPolicy } from '../../../core/security/rate_limit_policy.js';

const router = Router();

router.post('/register', AuthController.register);
router.post('/login', RateLimitPolicy.login.ip, RateLimitPolicy.login.email, RateLimitPolicy.login.device, AuthController.login);
router.post('/refresh', RateLimitPolicy.refresh.device, AuthController.refresh);

router.post('/logout', authenticate, AuthController.logout);
router.get('/sessions', authenticate, AuthController.getSessions);

export const authRouter = router;
