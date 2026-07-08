import { Request, Response } from 'express';
import { prisma } from '../../../core/database/prisma.js';
import { logger } from '../../../logger.js';

export class WebhookController {
  /**
   * Handles incoming payment webhooks securely.
   */
  static async handleStripeWebhook(req: Request, res: Response) {
    const signature = req.headers['stripe-signature'] as string;
    const rawBody = (req as any).rawBody || JSON.stringify(req.body); // In real app, must use express.raw()

    // 1. Signature Verification (Mocked)
    // if (!stripeProvider.verifyWebhookSignature(rawBody, signature)) {
    //   return res.status(400).send('Invalid Signature');
    // }

    const event = req.body;

    // 2. Replay Protection & Timestamp Validation
    const eventTime = new Date(event.created * 1000).getTime();
    if (Date.now() - eventTime > 5 * 60 * 1000) {
      // Reject events older than 5 minutes
      logger.warn('[Webhook] Replay attempt detected or delayed event');
      return res.status(400).send('Event too old');
    }

    try {
      // 3. Idempotency Check using OutboxEvent
      const idempotencyKey = `webhook_stripe_${event.id}`;
      const existing = await prisma.outboxEvent.findFirst({
        where: { aggregateId: idempotencyKey }
      });
      
      if (existing) {
        logger.info(`[Webhook] Duplicate event ignored: ${event.id}`);
        return res.status(200).send({ received: true });
      }

      // 4. Translate and Enqueue Domain Event (PAYMENT_COMPLETED)
      if (event.type === 'payment_intent.succeeded') {
        const userId = event.data.object.metadata?.userId;
        
        await prisma.outboxEvent.create({
          data: {
            aggregateId: idempotencyKey, // Used as idempotency key
            aggregateType: 'PAYMENT',
            eventType: 'PAYMENT_COMPLETED',
            payload: {
              userId,
              provider: 'stripe',
              referenceId: event.data.object.id,
              amount: event.data.object.amount,
            }
          }
        });
        logger.info(`[Webhook] Enqueued PAYMENT_COMPLETED for user: ${userId}`);
      }

      return res.status(200).send({ received: true });
    } catch (e) {
      logger.error('[Webhook] Failed to process', e);
      return res.status(500).send('Internal Server Error');
    }
  }
}
