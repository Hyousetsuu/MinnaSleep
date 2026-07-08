import { Router } from 'express';
import { WebhookController } from './webhook_controller.js';
import { RateLimitPolicy } from '../../../core/security/rate_limit_policy.js';

const router = Router();

// Webhooks don't use 'authenticate' since they come from external providers
router.post('/webhook/stripe', RateLimitPolicy.ai.user /* fallback general rate limit */, WebhookController.handleStripeWebhook);

export const paymentRouter = router;
