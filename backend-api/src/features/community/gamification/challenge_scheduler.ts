/**
 * Sprint 15.5: Challenge Scheduler
 * Automates the generation of Weekly Challenges via a Cron job.
 */

export class ChallengeScheduler {
  
  /**
   * Called by a Cron Job every Monday at 00:00 UTC.
   */
  async generateWeeklyChallenge(): Promise<void> {
    const templates = [
      { name: 'Consistency Week', desc: 'Hit sleep targets 5 days this week' },
      { name: 'Weekend Discipline', desc: 'Maintain wake time through Sat/Sun' },
      { name: 'Sleep Before 23:00', desc: 'Lights out early for 4 days' }
    ];

    // Pick a random template to keep it fresh
    const selected = templates[Math.floor(Math.random() * templates.length)];

    console.log(`[ChallengeScheduler] Automatically generated Weekly Challenge: ${selected.name}`);

    // Publish Domain Event: Weekly Challenge Started (to trigger Feed & Notifications)
    await this._publishEvent('WeeklyChallengeStarted', selected);
  }

  private async _publishEvent(type: string, payload: any): Promise<void> {
    // BullMQ / Kafka publish
  }
}
