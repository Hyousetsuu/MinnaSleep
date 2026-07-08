import { Request, Response } from 'express';
import { ResponseEnvelope } from '../../../core/api/response_envelope.js';
import { SyncService } from '../application/sync_service.js';
import { SyncPayloadSchema } from '../domain/sync_dto.js';

export class SyncController {
  static async sync(req: Request, res: Response) {
    const reqId = req.headers['x-request-id'] as string;
    try {
      const payload = SyncPayloadSchema.parse(req.body);
      const userId = (req as any).user.sub;

      const result = await SyncService.processBatch(userId, payload, reqId);
      
      // Return 200 even for partial successes
      return res.status(200).json(ResponseEnvelope.success(result, reqId));
    } catch (e: any) {
      if (e.name === 'ZodError') {
        return res.status(400).json(ResponseEnvelope.error('VAL001', 'Validation failed: ' + e.message, reqId));
      }
      return res.status(500).json(ResponseEnvelope.error('SYS001', 'Sync processing failed', reqId));
    }
  }

  static async getStatus(req: Request, res: Response) {
    const reqId = req.headers['x-request-id'] as string;
    const userId = (req as any).user.sub;
    try {
      // In a real app, this would query a Redis queue or Outbox status
      const status = await SyncService.getStatus(userId);
      return res.status(200).json(ResponseEnvelope.success(status, reqId));
    } catch (e: any) {
      return res.status(500).json(ResponseEnvelope.error('SYS001', 'Failed to fetch status', reqId));
    }
  }

  static async retry(req: Request, res: Response) {
    const reqId = req.headers['x-request-id'] as string;
    const userId = (req as any).user.sub;
    try {
      const payload = SyncPayloadSchema.parse(req.body); // Send only failed operations
      const result = await SyncService.processBatch(userId, payload, reqId, true); // true = isRetry
      
      return res.status(200).json(ResponseEnvelope.success(result, reqId));
    } catch (e: any) {
      return res.status(500).json(ResponseEnvelope.error('SYS001', 'Retry failed', reqId));
    }
  }
}
