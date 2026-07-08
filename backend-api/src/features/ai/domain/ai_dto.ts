import { z } from 'zod';

export const AIInsightSchema = z.object({
  summary: z.string().min(10).max(1000),
  sleepScore: z.number().min(0).max(100),
  factors: z.array(z.string()).max(10),
});

export const AIRecommendationSchema = z.object({
  title: z.string().min(5).max(100),
  description: z.string().min(10).max(1000),
  actionableSteps: z.array(z.string()).max(5),
  priority: z.enum(['HIGH', 'MEDIUM', 'LOW']),
});

export const AIPayloadWrapperSchema = z.object({
  schemaVersion: z.number(),
  promptVersion: z.number(),
  provider: z.string(),
  data: z.union([AIInsightSchema, AIRecommendationSchema]),
});

export type AIInsightDTO = z.infer<typeof AIInsightSchema>;
export type AIRecommendationDTO = z.infer<typeof AIRecommendationSchema>;
