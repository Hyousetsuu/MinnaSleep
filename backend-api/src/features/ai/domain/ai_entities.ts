export interface AIInsightEntity {
  id: string;
  userId: string;
  date: string;
  summary: string;
  sleepScore: number;
  factors: string[];
  createdAt: Date;
}

export interface AIRecommendationEntity {
  id: string;
  userId: string;
  title: string;
  description: string;
  actionableSteps: string[];
  priority: 'HIGH' | 'MEDIUM' | 'LOW';
  createdAt: Date;
}

export interface AIUsageEntity {
  userId: string;
  dailyUsed: number;
  monthlyUsed: number;
  lifetimeUsed: number;
  quotaDaily: number;
  quotaMonthly: number;
  resetAt: Date;
}
