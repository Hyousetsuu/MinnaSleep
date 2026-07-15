import { CoachingEngine } from '../engine/coaching_engine';
import { FocusEngine } from '../focus/focus_engine';
import { GoalTracker } from '../goals/goal_tracker';
import { CoachSession } from '../session/coach_session';
import { CoachingTimelineService } from '../timeline/coaching_timeline_service';

/**
 * Sprint 16: Coach Controller
 * The Hero Feature endpoints for the AI Sleep Coach.
 */

export class CoachController {
  constructor(
    private coachingEngine: CoachingEngine,
    private focusEngine: FocusEngine,
    private goalTracker: GoalTracker,
    private coachSession: CoachSession,
    private timelineService: CoachingTimelineService
  ) {}

  /**
   * GET /ai/coach/morning-brief
   */
  async getMorningBrief(req: any, res: any) {
    const { userId } = req.query;
    const brief = await this.coachingEngine.generateMorningBrief(userId);
    return res.status(200).json({ success: true, data: brief });
  }

  /**
   * GET /ai/coach/focus
   */
  async getFocus(req: any, res: any) {
    const { userId } = req.query;
    const focus = await this.focusEngine.getCurrentFocus(userId);
    return res.status(200).json({ success: true, data: focus });
  }

  /**
   * POST /ai/coach/session
   */
  async askCoach(req: any, res: any) {
    const { sessionId, userId, message } = req.body;
    
    // Save user message to memory
    await this.coachSession.appendMessage(sessionId, { role: 'user', content: message, timestamp: new Date().toISOString() });
    
    // In production, context is fetched and passed to Gateway.
    // For now, return mock
    const aiResponse = { role: 'coach', content: 'Mari kita lihat beberapa minggu terakhir. Sepertinya...' };
    
    // Save AI response to memory
    await this.coachSession.appendMessage(sessionId, { ...aiResponse, timestamp: new Date().toISOString() });

    return res.status(200).json({ success: true, data: aiResponse });
  }
}
