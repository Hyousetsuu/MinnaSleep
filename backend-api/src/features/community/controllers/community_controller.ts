import { FeedService } from '../feed/feed_service';
import { InteractionService, InteractionType } from '../feed/interaction_service';
import { LeaderboardService, LeaderboardCategory } from '../gamification/leaderboard_service';
import { ChallengeEngine } from '../gamification/challenge_engine';

/**
 * Sprint 15: Community Controller
 * Handles the "Strava for Sleep" social endpoints.
 */

export class CommunityController {
  constructor(
    private feedService: FeedService,
    private interactionService: InteractionService,
    private leaderboardService: LeaderboardService,
    private challengeEngine: ChallengeEngine
  ) {}

  /**
   * GET /community/feed
   */
  async getTimelineFeed(req: any, res: any) {
    try {
      const { userId } = req.query;
      const feed = await this.feedService.getTimeline(userId);
      return res.status(200).json({ success: true, data: feed });
    } catch (e: any) {
      return res.status(500).json({ success: false, error: e.message });
    }
  }

  /**
   * POST /community/events/:eventId/kudos
   */
  async giveKudos(req: any, res: any) {
    try {
      const { eventId } = req.params;
      const { userId } = req.body;
      
      await this.interactionService.addInteraction(eventId, userId, InteractionType.KUDOS);
      return res.status(200).json({ success: true, message: 'Kudos given!' });
    } catch (e: any) {
      return res.status(500).json({ success: false, error: e.message });
    }
  }

  /**
   * GET /community/leaderboard
   */
  async getLeaderboard(req: any, res: any) {
    try {
      const { userId, category } = req.query;
      const cat = category as LeaderboardCategory || LeaderboardCategory.RECOVERY_SCORE;
      
      const leaderboard = await this.leaderboardService.getFriendsLeaderboard(userId, cat);
      return res.status(200).json({ success: true, data: leaderboard });
    } catch (e: any) {
      return res.status(500).json({ success: false, error: e.message });
    }
  }

  /**
   * GET /community/challenges
   */
  async getChallenges(req: any, res: any) {
    const challenges = this.challengeEngine.getActiveChallenges();
    return res.status(200).json({ success: true, data: challenges });
  }
}
