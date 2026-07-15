/**
 * Sprint 16: User Context Builder
 * Assembles a unified context object for the AI from various analytics engines.
 */

export interface UserContext {
  sleepDebt7d: number;
  recoveryScore: number;
  chronotype: string;
  consistencyScore: number;
  trends: any;
  habits: any;
  streak: number;
  activeChallenges: any[];
  recentAchievements: any[];
  wearableAvailability: boolean;
}

export class UserContextBuilder {
  
  async build(userId: string, enrichedData: any): Promise<UserContext> {
    return {
      sleepDebt7d: enrichedData.analytics.sleepDebt || 0,
      recoveryScore: enrichedData.analytics.recoveryScore || 0,
      chronotype: enrichedData.analytics.chronotype || 'LION',
      consistencyScore: enrichedData.analytics.consistency || 85,
      trends: enrichedData.trends,
      habits: enrichedData.habits,
      streak: enrichedData.community.streak || 0,
      activeChallenges: enrichedData.community.activeChallenges || [],
      recentAchievements: enrichedData.community.recentAchievements || [],
      wearableAvailability: true
    };
  }
}
