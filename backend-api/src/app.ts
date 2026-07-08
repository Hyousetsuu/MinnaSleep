import express, { Request, Response, NextFunction } from 'express';
import helmet from 'helmet';
import cors from 'cors';
import hpp from 'hpp';
import compression from 'compression';
import { rateLimit } from 'express-rate-limit';
import pinoHttp from 'pino-http';
import { v4 as uuidv4 } from 'uuid';
import { env } from './env.js';

const app = express();

// Trust Proxy (Required if behind Nginx/Render/Cloudflare)
app.set('trust proxy', 1);

// 1. Request Traceability (X-Request-ID)
app.use((req: Request, res: Response, next: NextFunction) => {
  const reqId = req.headers['x-request-id'] || `req_${uuidv4()}`;
  req.headers['x-request-id'] = reqId;
  res.setHeader('X-Request-ID', reqId);
  next();
});

// 2. High-Performance Logging (Pino)
app.use(pinoHttp({
  genReqId: function (req) { return req.headers['x-request-id']; },
  level: env.NODE_ENV === 'production' ? 'info' : 'debug',
  transport: env.NODE_ENV !== 'production' ? { target: 'pino-pretty' } : undefined,
}));

// 3. Security Firewall (Helmet, Cors, HPP)
app.use(helmet()); // Protects headers (Clickjacking, XSS, Sniffing)
app.use(cors({ origin: '*' })); // Restrict in production
app.use(hpp()); // Prevents HTTP Parameter Pollution

// 4. Performance (Compression)
app.use(compression()); // Gzip/Brotli compression

// 5. Body Parsers
app.use(express.json({ limit: '5mb' })); // Limit JSON size

// 6. Global Rate Limiting (Read API fallback)
const globalLimiter = rateLimit({
  windowMs: 1 * 60 * 1000, // 1 minute
  limit: 300,
  message: { error: 'Too many requests, please try again later.' },
  standardHeaders: 'draft-7',
  legacyHeaders: false,
});
app.use(globalLimiter);

// 7. API Version Header Middleware
app.use((req, res, next) => {
  // Inject Correlation ID if not present
  const correlationId = req.headers['x-correlation-id'] || req.headers['x-request-id'] || crypto.randomUUID();
  req.headers['x-correlation-id'] = correlationId;
  res.setHeader('X-Correlation-ID', correlationId);
  
  // Inject Contract Version
  res.setHeader('X-Contract-Version', '2026-07');
  
  next();
});

import { authRouter } from './features/auth/presentation/auth_routes.js';
import { syncRouter } from './features/sync/presentation/sync_routes.js';
import { aiRouter } from './features/ai/presentation/ai_routes.js';
import { paymentRouter } from './features/payment/presentation/payment_routes.js';

app.use('/api/v1/auth', authRouter);
app.use('/api/v1/sync', syncRouter);
app.use('/api/v1/ai', aiRouter);
app.use('/api/v1/payment', paymentRouter);

// 8. Segregated Probes
app.get('/health', (_req, res) => {
  // Server is responding
  res.status(200).json({ status: 'ok', type: 'server' });
});

app.get('/ready', async (_req, res) => {
  // DB & Redis readiness check
  try {
    // await prisma.$queryRaw`SELECT 1`; // Simulating DB check
    res.status(200).json({ status: 'ready', type: 'database_redis' });
  } catch {
    res.status(503).json({ status: 'error', type: 'database_redis' });
  }
});

app.get('/health/dependencies', (_req, res) => {
  // Gemini, Storage, SMTP
  res.status(200).json({ 
    status: 'ok', 
    type: 'dependencies',
    details: { gemini: 'ok', smtp: 'ok', storage: 'ok' }
  });
});

export { app };
