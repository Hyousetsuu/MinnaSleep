/**
 * Sprint 16: Smart Nudge Engine
 * Determines the *best* moment to send a notification, avoiding fatigue.
 */

export class SmartNudgeEngine {
  
  async shouldSendNudge(userId: string, nudgeType: string): Promise<boolean> {
    // Logic:
    // Has the user received a nudge today?
    // Is the user overwhelmed by notifications?
    // Is this a high-priority nudge (e.g., Streak dying vs just a tip)?
    
    const nudgesSentToday = 0; // Mock DB lookup

    if (nudgesSentToday >= 1) {
      console.log(`[SmartNudge] Suppressing nudge for ${userId} to avoid fatigue.`);
      return false;
    }

    return true;
  }
}
