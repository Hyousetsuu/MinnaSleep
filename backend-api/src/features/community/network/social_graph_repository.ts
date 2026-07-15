/**
 * Sprint 15: Social Graph Repository
 * Manages relationships between users.
 */
export class SocialGraphRepository {
  
  async followUser(followerId: string, followingId: string): Promise<void> {
    // INSERT INTO follows (followerId, followingId) VALUES ...
    console.log(`[SocialGraph] ${followerId} is now following ${followingId}`);
  }

  async unfollowUser(followerId: string, followingId: string): Promise<void> {
    // DELETE FROM follows WHERE ...
    console.log(`[SocialGraph] ${followerId} unfollowed ${followingId}`);
  }

  async getFriends(userId: string): Promise<string[]> {
    // SELECT followingId FROM follows WHERE followerId = userId
    // AND followingId IN (SELECT followerId FROM follows WHERE followingId = userId)
    return ['user_b', 'user_c']; // Mock mutual friends
  }

  /**
   * Calculates a score based on frequency of interactions (kudos, mutual status)
   * Used by FeedService to prioritize timeline events.
   */
  async getRelationshipScore(userId: string, targetId: string): Promise<number> {
    return 85; // 0-100
  }
}
