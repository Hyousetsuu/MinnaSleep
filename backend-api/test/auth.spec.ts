import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import request from 'supertest';
import { app } from '../src/app.js';
import { prisma } from '../src/core/database/prisma.js';

describe('Auth API Contract Tests', () => {
  let userEmail = `test_${Date.now()}@test.com`;
  let userPassword = 'Password123';
  let sessionId = '';
  let refreshToken = '';
  let accessToken = '';

  beforeAll(async () => {
    // Clean up existing user if needed
    await prisma.user.deleteMany({ where: { email: userEmail } });
  });

  afterAll(async () => {
    await prisma.user.deleteMany({ where: { email: userEmail } });
    await prisma.$disconnect();
  });

  it('should register a new user successfully (201)', async () => {
    const res = await request(app)
      .post('/api/v1/auth/register')
      .send({ email: userEmail, password: userPassword });
    
    expect(res.status).toBe(201);
    expect(res.body.success).toBe(true);
    expect(res.body.data.userId).toBeDefined();
  });

  it('should fail validation with weak password (400)', async () => {
    const res = await request(app)
      .post('/api/v1/auth/register')
      .send({ email: 'weak@test.com', password: 'weak' });
    
    expect(res.status).toBe(400);
    expect(res.body.success).toBe(false);
    expect(res.body.error.code).toBe('VAL001');
  });

  it('should login successfully and return envelope (200)', async () => {
    const res = await request(app)
      .post('/api/v1/auth/login')
      .send({ email: userEmail, password: userPassword, deviceId: 'test_device' });
    
    expect(res.status).toBe(200);
    expect(res.body.success).toBe(true);
    expect(res.body.data.accessToken).toBeDefined();
    expect(res.body.data.refreshToken).toBeDefined();
    expect(res.body.requestId).toBeDefined();

    accessToken = res.body.data.accessToken;
    refreshToken = res.body.data.refreshToken;
    
    // Extract session ID from JWT token (mock decode just for test logic)
    const jwtParts = accessToken.split('.');
    const payload = JSON.parse(Buffer.from(jwtParts[1], 'base64').toString());
    sessionId = payload.sid;
  });

  it('should lockout account after 5 failed attempts (429 AUTH005)', async () => {
    const bruteForceEmail = `lockout_${Date.now()}@test.com`;
    await request(app).post('/api/v1/auth/register').send({ email: bruteForceEmail, password: userPassword });

    for (let i = 0; i < 4; i++) {
      const res = await request(app).post('/api/v1/auth/login').send({ email: bruteForceEmail, password: 'wrong', deviceId: 'd1' });
      expect(res.status).toBe(401);
      expect(res.body.error.code).toBe('AUTH002');
    }

    // 5th attempt locks it
    const res5 = await request(app).post('/api/v1/auth/login').send({ email: bruteForceEmail, password: 'wrong', deviceId: 'd1' });
    expect(res5.status).toBe(429);
    expect(res5.body.error.code).toBe('AUTH005');

    // Even correct password fails now
    const res6 = await request(app).post('/api/v1/auth/login').send({ email: bruteForceEmail, password: userPassword, deviceId: 'd1' });
    expect(res6.status).toBe(429);
  });

  it('should refresh token and rotate (200)', async () => {
    const res = await request(app)
      .post('/api/v1/auth/refresh')
      .send({ sessionId, refreshToken });
    
    expect(res.status).toBe(200);
    expect(res.body.data.accessToken).toBeDefined();
    expect(res.body.data.refreshToken).not.toBe(refreshToken); // Rotated!
    
    accessToken = res.body.data.accessToken;
  });

  it('should deny access to protected route without token (401)', async () => {
    const res = await request(app).get('/api/v1/auth/sessions');
    expect(res.status).toBe(401);
    expect(res.body.error.code).toBe('AUTH004');
  });

  it('should fetch active sessions with valid token (200)', async () => {
    const res = await request(app)
      .get('/api/v1/auth/sessions')
      .set('Authorization', `Bearer ${accessToken}`);
    
    expect(res.status).toBe(200);
    expect(Array.isArray(res.body.data)).toBe(true);
    expect(res.body.data.length).toBeGreaterThan(0);
  });

  it('should logout and revoke session (200)', async () => {
    const res = await request(app)
      .post('/api/v1/auth/logout')
      .set('Authorization', `Bearer ${accessToken}`);
    
    expect(res.status).toBe(200);
  });

  it('should deny access after logout (401)', async () => {
    const res = await request(app)
      .get('/api/v1/auth/sessions')
      .set('Authorization', `Bearer ${accessToken}`);
    
    expect(res.status).toBe(401);
  });
});
