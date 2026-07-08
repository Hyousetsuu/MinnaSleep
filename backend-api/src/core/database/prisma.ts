import { PrismaClient } from '@prisma/client';
import { env } from '../../env.js';

const globalForPrisma = global as unknown as { prisma: PrismaClient };

const prismaBase = globalForPrisma.prisma || new PrismaClient({
  log: env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
});

const modelsWithVersion = [
  'User', 
  'UserSession', 
  'Profile', 
  'Sleep', 
  'Notification', 
  'AIUsage'
];

import { PrismaClient } from '@prisma/client';
import { logger } from '../../logger.js';
// import { readReplicas } from '@prisma/extension-read-replicas'; // Phase 1: Read Replica Support

// Instantiate Prisma with 'query' log event enabled
const prismaBase = new PrismaClient({
  log: [
    { emit: 'event', level: 'query' },
    { emit: 'stdout', level: 'info' },
    { emit: 'stdout', level: 'warn' },
    { emit: 'stdout', level: 'error' },
  ],
});

// Phase 1: Slow Query Logger (>100ms warning, >500ms critical)
prismaBase.$on('query', (e: any) => {
  if (e.duration >= 500) {
    logger.error(`[Prisma] CRITICAL SLOW QUERY (${e.duration}ms): ${e.query}`);
  } else if (e.duration >= 100) {
    logger.warn(`[Prisma] SLOW QUERY (${e.duration}ms): ${e.query}`);
  }
});

/**
 * Global Prisma Extension
 * Automatically increments the 'version' field for Optimistic Concurrency Control (OCC)
 * on all models that support it during update/updateMany operations.
 */
export const prisma = prismaBase
  // Phase 1: Read Replica Setup (Stubbed for URL configuration)
  // .$extends(readReplicas({ url: process.env.DATABASE_REPLICA_URL }))
  .$extends({
  query: {
    $allModels: {
      async update({ model, operation, args, query }) {
        if (modelsWithVersion.includes(model)) {
          if (args.data && typeof args.data === 'object' && !('version' in args.data)) {
            (args.data as any).version = { increment: 1 };
          }
        }
        return query(args);
      },
      async updateMany({ model, operation, args, query }) {
        if (modelsWithVersion.includes(model)) {
          if (args.data && typeof args.data === 'object' && !('version' in args.data)) {
            (args.data as any).version = { increment: 1 };
          }
        }
        return query(args);
      }
    }
  }
});

if (env.NODE_ENV !== 'production') globalForPrisma.prisma = prismaBase;
