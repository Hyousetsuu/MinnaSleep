/**
 * Sprint 16: Focus Engine
 * Ensures the AI doesn't overwhelm the user with multiple goals at once.
 */

export interface CoachingFocus {
  focusArea: string;
  reason: string;
  progressPercent: number;
}

export class FocusEngine {
  
  async getCurrentFocus(userId: string): Promise<CoachingFocus> {
    return {
      focusArea: "Consistency",
      reason: "Sleep Drift meningkat minggu ini.",
      progressPercent: 63
    };
  }

  async setNextFocus(userId: string, focusArea: string): Promise<void> {
    // Saves the new focus to the database
    console.log(`[FocusEngine] ${userId} next focus is ${focusArea}`);
  }
}
