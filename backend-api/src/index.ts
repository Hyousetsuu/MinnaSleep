import { app } from './app.js';
import { prisma } from './core/database/prisma.js';
import { logger } from './logger.js';
import http from 'http';

const port = process.env.PORT || 3000;
const server = http.createServer(app);

server.listen(port, () => {
  logger.info(`🚀 [Enterprise] Server running on port ${port}`);
});

// Phase 2: Graceful Shutdown Hook (SIGTERM intercepts)
const gracefulShutdown = async (signal: string) => {
  logger.info(`[Server] Received ${signal}. Shutting down gracefully...`);
  
  // 1. Stop accepting new requests (Bulkhead/Load Balancer will route elsewhere)
  server.close(async (err) => {
    if (err) {
      logger.error('[Server] Error during close', err);
      process.exit(1);
    }
    
    // 2. Disconnect Prisma and Database connections
    logger.info('[Server] Disconnecting Prisma Database Pool...');
    await prisma.$disconnect();
    
    // 3. Gracefully stop background workers (Mocked wait for queue to finish)
    logger.info('[Server] Waiting for pending Outbox jobs to finish...');
    await new Promise(resolve => setTimeout(resolve, 2000));
    
    logger.info('[Server] Graceful shutdown complete. Exiting.');
    process.exit(0);
  });

  // Force close after 10 seconds if connections are hanging
  setTimeout(() => {
    logger.error('[Server] CRITICAL: Forcing shutdown after 10s timeout.');
    process.exit(1);
  }, 10000).unref();
};

process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
process.on('SIGINT', () => gracefulShutdown('SIGINT'));
