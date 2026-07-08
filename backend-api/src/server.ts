import { app } from './app.js';
import { env } from './env.js';
import { logger } from './logger.js';

const PORT = env.PORT;

const server = app.listen(PORT, () => {
  logger.info(`🚀 Minna Sleep Backend API running at http://localhost:${PORT}`);
  logger.info(`🛡️  Environment: ${env.NODE_ENV}`);
});

// Graceful Shutdown
process.on('SIGTERM', () => {
  logger.info('SIGTERM received. Shutting down gracefully...');
  server.close(() => {
    logger.info('Process terminated.');
    process.exit(0);
  });
});
