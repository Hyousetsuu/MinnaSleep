/**
 * Sprint 15: Streak Engine
 * Tracks daily consistency chains.
 */

export class StreakEngine {
  
  /**
   * Processes a new sleep session to determine if the streak continues or breaks.
   */
  async updateStreak(userId: string, isTargetMet: boolean, date: string): Promise<number> {
    const currentStreak = await this._getCurrentStreak(userId);

    let newStreak = currentStreak;

    if (isTargetMet) {
      newStreak += 1;
    } else {
      // Streak broken
      newStreak = 0;
    }

    await this._saveStreak(userId, newStreak, date);
    
    if (newStreak > 0) {
      // Trigger Domain Event: StreakUpdated
      console.log(`[StreakEngine] DomainEvent: StreakUpdated -> ${userId} is on a ${newStreak}-day streak!`);
    }

    return newStreak;
  }

  private async _getCurrentStreak(userId: string): Promise<number> {
    return 6; // Mock existing streak
  }

  private async _saveStreak(userId: string, streak: number, date: string): Promise<void> {
    // UPDATE streaks SET count = streak WHERE ...
  }
}
