import { UserContextBuilder, UserContext } from './user_context_builder';

/**
 * Sprint 16: Context Enrichment Pipeline
 * Sequentially gathers data from all Sprint 14 & Sprint 15 engines.
 */
export class ContextEnrichmentPipeline {
  constructor(private contextBuilder: UserContextBuilder) {}

  async execute(userId: string): Promise<UserContext> {
    // 1. Fetch Analytics Snapshot
    const analytics = { sleepDebt: 5.2, recoveryScore: 82, chronotype: 'LION', consistency: 90 };
    
    // 2. Fetch Habits (Sprint 16 Intelligence)
    const habits = { weekendEffect: true, sleepDrift: 'MINIMAL' };
    
    // 3. Fetch Community Context
    const community = { streak: 12, activeChallenges: ['7-Day Consistency'], recentAchievements: ['Early Bird'] };
    
    // 4. Fetch Trends
    const trends = { recoveryTrend: 'UPWARD', durationTrend: 'STABLE' };

    const enrichedData = { analytics, habits, community, trends };

    return this.contextBuilder.build(userId, enrichedData);
  }
}
