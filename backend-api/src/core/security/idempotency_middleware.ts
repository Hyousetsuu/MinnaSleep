import { Request, Response, NextFunction } from 'express';
import { prisma } from '../database/prisma.js';
import crypto from 'crypto';
import { ResponseEnvelope } from '../api/response_envelope.js';
import { logger } from '../../logger.js';

/**
 * Idempotency Middleware (Stripe-Style)
 * Intercepts requests with Idempotency-Key header.
 * If a matching key exists and has a saved response, returns it immediately.
 * Otherwise, wraps res.send to save the response upon completion.
 */
export const idempotencyMiddleware = async (req: Request, res: Response, next: NextFunction) => {
  const idempotencyKey = req.headers['idempotency-key'] as string;
  const reqId = req.headers['x-request-id'] as string;
  const userId = (req as any).user?.sub; // Assuming authenticate middleware ran first

  if (!idempotencyKey) {
    // If no key provided, just continue normally
    return next();
  }

  try {
    const existingKey = await prisma.idempotencyKey.findUnique({
      where: { key: idempotencyKey },
    });

    if (existingKey) {
      if (existingKey.responseStatus && existingKey.responseBody) {
        logger.info(`[Idempotency] Returning cached response for key: ${idempotencyKey}`);
        return res.status(existingKey.responseStatus).json(existingKey.responseBody);
      }
      
      // If it exists but no response yet, it might be currently processing (Concurrent Request)
      return res.status(409).json(
        ResponseEnvelope.error('SYNC003', 'Concurrent request with same idempotency key is processing', reqId)
      );
    }

    // Compute request hash (SHA256 of payload)
    const requestHash = crypto.createHash('sha256').update(JSON.stringify(req.body)).digest('hex');

    // Create the idempotency record marking it as started
    await prisma.idempotencyKey.create({
      data: {
        key: idempotencyKey,
        userId: userId || null,
        endpoint: req.originalUrl,
        requestHash,
        expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000), // Expires in 24 hours
      },
    });

    // Intercept response to save it
    const originalJson = res.json;
    res.json = function (body: any) {
      // Restore original function to prevent double call issues
      res.json = originalJson;
      
      const responseStatus = res.statusCode;
      
      // Save asynchronously so we don't block the response
      setImmediate(async () => {
        try {
          await prisma.idempotencyKey.update({
            where: { key: idempotencyKey },
            data: {
              responseStatus,
              responseBody: body,
            },
          });
        } catch (err) {
          logger.error(`[Idempotency] Failed to save response for key: ${idempotencyKey}`, err);
        }
      });

      return originalJson.call(this, body);
    };

    next();
  } catch (err) {
    logger.error(`[Idempotency] Middleware error`, err);
    return res.status(500).json(ResponseEnvelope.error('SYS001', 'Internal error processing idempotency', reqId));
  }
};
