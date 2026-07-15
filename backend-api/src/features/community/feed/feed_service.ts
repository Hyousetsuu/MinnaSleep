import { SocialGraphRepository } from '../network/social_graph_repository';

/**
 * Sprint 15: Feed Service
 * Retrieves the timeline of friends, sorting them by a combination of
 * Recency, Relationship Score, Kudos, and Challenge Priority.
 */

export interface FeedPost {
  id: string;
  userId: string;
  message: string;
  timestamp: number;
  kudosCount: number;
  isChallengeCompletion: boolean;
}

export class FeedService {
  constructor(private socialGraph: SocialGraphRepository) {}

  async getTimeline(userId: string): Promise<FeedPost[]> {
    const friends = await this.socialGraph.getFriends(userId);
    
    // 1. Fetch raw posts from DB for these friends
    const rawPosts = await this._fetchPostsFromDB(friends);

    // 2. Sort intelligently (Recency + Relationship + Kudos)
    const sortedFeed = await Promise.all(rawPosts.map(async post => {
      const relationshipScore = await this.socialGraph.getRelationshipScore(userId, post.userId);
      const timeDecay = (Date.now() - post.timestamp) / 1000 / 3600; // hours ago
      
      // Algorithm: Base Score + (Relationship) + (Kudos*2) + (Challenge*50) - (TimeDecay*10)
      const feedScore = 100 + (relationshipScore * 0.5) + (post.kudosCount * 2) + (post.isChallengeCompletion ? 50 : 0) - (timeDecay * 10);
      
      return { post, feedScore };
    }));

    // Sort descending by calculated feedScore
    sortedFeed.sort((a, b) => b.feedScore - a.feedScore);

    return sortedFeed.map(sf => sf.post);
  }

  private async _fetchPostsFromDB(userIds: string[]): Promise<FeedPost[]> {
    // Mock DB fetch
    return [
      { id: '1', userId: 'user_b', message: '💤 Akira tidur lebih lama daripada update Windows.', timestamp: Date.now() - 3600000, kudosCount: 5, isChallengeCompletion: false },
      { id: '2', userId: 'user_c', message: '⭐ Ken menyelesaikan Weekly Sleep Challenge.', timestamp: Date.now() - 7200000, kudosCount: 12, isChallengeCompletion: true }
    ];
  }
}
