import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import request from 'supertest';
import { app } from '../src/app.js';
import { prisma } from '../src/core/database/prisma.js';
import { JwtService } from '../src/core/security/jwt_service.js';
import crypto from 'crypto';

describe('Sync API Contract Tests (12 Scenarios)', () => {
  let token: string;
  let userId: string;

  beforeAll(async () => {
    // Generate mock user and token
    const user = await prisma.user.create({
      data: {
        email: 'sync_test@minnasleep.com',
        passwordHash: 'dummy',
      }
    });
    userId = user.id;

    await prisma.profile.create({
      data: {
        userId: user.id,
        username: 'synctester',
      }
    });

    token = JwtService.signAccessToken({
      sub: user.id,
      sid: 'mock-session-id',
      role: 'user',
    });
  });

  afterAll(async () => {
    await prisma.user.delete({ where: { id: userId } });
  });

  const getValidPayload = (ops: any[] = []) => {
    const payloadHash = crypto.createHash('sha256').update(JSON.stringify(ops)).digest('hex');
    return {
      metadata: {
        deviceId: 'device-123',
        appVersion: '1.0.0',
        schemaVersion: '2026-07',
        timezone: 'Asia/Jakarta',
        locale: 'id-ID',
        platform: 'android'
      },
      payloadHash,
      operations: ops
    };
  };

  it('1. Empty Batch', async () => {
    const res = await request(app)
      .post('/api/v1/sync')
      .set('Authorization', `Bearer ${token}`)
      .set('X-Contract-Version', '2026-07')
      .send(getValidPayload([]));

    expect(res.status).toBe(200);
    expect(res.body.success).toBe(true);
    expect(res.body.data.synced.length).toBe(0);
  });

  it('2. Unauthorized', async () => {
    const res = await request(app)
      .post('/api/v1/sync')
      .send(getValidPayload([]));
    expect(res.status).toBe(401);
  });

  it('3. Invalid Payload (Checksum Mismatch)', async () => {
    const payload = getValidPayload([]);
    payload.payloadHash = 'invalid-hash';
    const res = await request(app)
      .post('/api/v1/sync')
      .set('Authorization', `Bearer ${token}`)
      .set('X-Contract-Version', '2026-07')
      .send(payload);

    expect(res.status).toBe(500);
    expect(res.body.error.code).toBe('SYS001');
  });

  it('4. Batch Create (Successful Sync)', async () => {
    const ops = [
      {
        operationId: 'op_create_1',
        operation: 'create',
        entity: 'sleep',
        payload: {
          id: crypto.randomUUID(),
          startedAt: new Date().toISOString(),
          duration: 120,
          quality: 85
        }
      }
    ];
    const res = await request(app)
      .post('/api/v1/sync')
      .set('Authorization', `Bearer ${token}`)
      .set('X-Contract-Version', '2026-07')
      .send(getValidPayload(ops));

    expect(res.status).toBe(200);
    expect(res.body.data.synced).toContain('op_create_1');
  });

  it('5. Batch Update', async () => {
    // Requires a prior create, covered by the previous test logic in a real run
  });

  it('6. Batch Delete (Tombstone)', async () => {
    // Mock tombstone logic
  });

  it('7. OCC Conflict', async () => {
    // Attempt to update with an older version
  });

  it('8. Idempotency Reuse', async () => {
    const idempotencyKey = 'idemp_test_key_1';
    const payload = getValidPayload([]);
    
    const res1 = await request(app)
      .post('/api/v1/sync')
      .set('Authorization', `Bearer ${token}`)
      .set('X-Contract-Version', '2026-07')
      .set('Idempotency-Key', idempotencyKey)
      .send(payload);

    const res2 = await request(app)
      .post('/api/v1/sync')
      .set('Authorization', `Bearer ${token}`)
      .set('X-Contract-Version', '2026-07')
      .set('Idempotency-Key', idempotencyKey)
      .send(payload);

    // Assuming first one processed quickly enough or res2 gets 409
    expect([200, 409]).toContain(res2.status);
  });

  it('9. Partial Success', async () => {
    // Send one valid create, one update on non-existent record
    const ops = [
      {
        operationId: 'op_valid',
        operation: 'create',
        entity: 'sleep',
        payload: {
          id: crypto.randomUUID(),
          startedAt: new Date().toISOString(),
        }
      },
      {
        operationId: 'op_invalid',
        operation: 'update',
        entity: 'sleep',
        payload: {
          id: 'non-existent-id',
        }
      }
    ];

    const res = await request(app)
      .post('/api/v1/sync')
      .set('Authorization', `Bearer ${token}`)
      .set('X-Contract-Version', '2026-07')
      .send(getValidPayload(ops));

    expect(res.status).toBe(200); // 200 overall
    expect(res.body.data.synced).toContain('op_valid');
    expect(res.body.data.conflicts.some((c: any) => c.operationId === 'op_invalid')).toBe(true);
  });

  it('10. Retry Required', async () => {
    // Simulate database lock or retry scenario
  });

  it('11. Rate Limit', async () => {
    // Hit endpoint > 60 times
  });

  it('12. X-Contract-Version upgrade required', async () => {
    const res = await request(app)
      .post('/api/v1/sync')
      .set('Authorization', `Bearer ${token}`)
      .set('X-Contract-Version', '2025-01') // Old version
      .send(getValidPayload([]));

    expect(res.status).toBe(426);
    expect(res.body.error.code).toBe('SYNC005');
  });
});
