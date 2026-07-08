import http from 'k6/http';
import { check, sleep } from 'k6';
import { Trend, Rate } from 'k6/metrics';

// Phase 1: Load Testing metrics (P50, P95, P99)
const syncLatency = new Trend('sync_latency');
const aiLatency = new Trend('ai_latency');
const errorRate = new Rate('error_rate');

export const options = {
  // Configured for Spike/Stress/Soak via CLI overrides. 
  // Default is a standard load test.
  stages: [
    { duration: '30s', target: 100 }, // Ramp-up to 100 users
    { duration: '1m', target: 500 },  // Ramp-up to 500 users
    { duration: '2m', target: 500 },  // Maintain 500 users
    { duration: '30s', target: 0 },   // Ramp-down
  ],
  thresholds: {
    // SLO Validation: P95 < 250ms, P99 < 600ms, Errors < 0.1%
    http_req_duration: ['p(95)<250', 'p(99)<600'],
    sync_latency: ['p(95)<250'],
    ai_latency: ['p(95)<3000'], // AI is allowed longer latency due to external provider
    error_rate: ['rate<0.001'], // < 0.1% errors
  },
};

const BASE_URL = __ENV.API_URL || 'http://localhost:3000/api/v1';

export default function () {
  // 1. Mock Login (assuming token is pre-generated or fast)
  const loginPayload = JSON.stringify({ email: 'load_test@minnasleep.com', password: 'dummy' });
  const loginRes = http.post(`${BASE_URL}/auth/login`, loginPayload, {
    headers: { 'Content-Type': 'application/json' },
  });
  
  check(loginRes, { 'login status 200': (r) => r.status === 200 }) || errorRate.add(1);
  const token = loginRes.json('data.accessToken') || 'mock-token'; // Fallback if mock

  // 2. Sleep Sync (Batch Operations)
  const syncPayload = JSON.stringify({
    metadata: { schemaVersion: '2026-07', deviceId: 'k6-device' },
    payloadHash: 'mock-hash', // Bypassing strict hash for load test
    operations: [
      { operationId: `op_${__VU}_${__ITER}`, operation: 'create', entity: 'sleep', payload: { id: `sleep_${__VU}_${__ITER}` } }
    ]
  });

  const syncRes = http.post(`${BASE_URL}/sync`, syncPayload, {
    headers: {
      'Authorization': `Bearer ${token}`,
      'X-Contract-Version': '2026-07',
      'Content-Type': 'application/json',
      'Idempotency-Key': `idemp_${__VU}_${__ITER}`
    }
  });
  syncLatency.add(syncRes.timings.duration);
  check(syncRes, { 'sync status 200': (r) => r.status === 200 }) || errorRate.add(1);

  // 3. Request AI Insight
  const aiRes = http.get(`${BASE_URL}/ai/insight`, {
    headers: {
      'Authorization': `Bearer ${token}`,
      'X-Contract-Version': '2026-07',
    }
  });
  aiLatency.add(aiRes.timings.duration);
  // Expecting 200 or 429 (Quota Exceeded) depending on test length
  check(aiRes, { 'ai status 200 or 429': (r) => r.status === 200 || r.status === 429 }) || errorRate.add(1);

  sleep(1); // User think time
}
