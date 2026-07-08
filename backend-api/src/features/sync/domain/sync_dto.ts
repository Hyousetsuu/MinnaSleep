import { z } from 'zod';

export const SyncMetadataSchema = z.object({
  deviceId: z.string(),
  appVersion: z.string(),
  schemaVersion: z.string(),
  timezone: z.string(),
  locale: z.string(),
  platform: z.string(),
});

export const SyncOperationSchema = z.object({
  operationId: z.string(), // Per-record Idempotency
  operation: z.enum(['create', 'update', 'delete']),
  entity: z.enum(['sleep', 'profile', 'notification']),
  payload: z.record(z.any()), // The actual data
});

export const SyncPayloadSchema = z.object({
  metadata: SyncMetadataSchema,
  payloadHash: z.string(), // SHA256 of operations array
  operations: z.array(SyncOperationSchema),
});

export type SyncPayload = z.infer<typeof SyncPayloadSchema>;
export type SyncOperation = z.infer<typeof SyncOperationSchema>;
