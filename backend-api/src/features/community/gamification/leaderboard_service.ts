import { SocialGraphRepository } from '../network/social_graph_repository';

/**
 * Sprint 15: Leaderboard Service
 * Constructs multi-category leaderboards to keep gamification fair.
 */

export enum LeaderboardCategory {
  LONGEST_STREAK = 'LONGEST_STREAK',
  SLEEP_CONSISTENCY = 'SLEEP_CONSISTENCY',
  CHALLENGE_POINTS = 'CHALLENGE_POINTS',
  RECOVERY_SCORE = 'RECOVERY_SCORE' // Requires wearable data
}

export interface LeaderboardEntry {
  userId: string;
  rank: number;
  score: number;
}

export class LeaderboardService {
  constructor(private socialGraph: SocialGraphRepository) {}

  async getFriendsLeaderboard(userId: string, category: LeaderboardCategory): Promise<LeaderboardEntry[]> {
    const friends = await this.socialGraph.getFriends(userId);
    const cohort = [...friends, userId]; // Include self

    // Fetch scores for cohort based on category from DB/Redis
    const rawScores = await this._fetchScores(cohort, category);

    // Sort descending
    rawScores.sort((a, b) => b.score - a.score);

    // Assign ranks
    return rawScores.map((entry, index) => ({
      ...entry,
      rank: index + 1
    }));
  }

  private async _fetchScores(userIds: string[], category: LeaderboardCategory) {
    // Mock data
    return userIds.map(id => ({
      userId: id,
      score: Math.floor(Math.random() * 100)
    }));
  }
}
