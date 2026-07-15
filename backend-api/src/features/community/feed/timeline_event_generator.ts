import { PersonalityFormatter, PersonalityTone } from './personality_formatter';
import { PrivacyGuard } from '../network/privacy_guard';

/**
 * Sprint 15: Timeline Event Generator
 * Background worker that listens to Domain Events (Kafka/EventBus)
 * and automatically generates rich Timeline Events.
 */

export interface DomainEvent {
  type: 'SleepCompleted' | 'StreakUpdated' | 'ChallengeCompleted';
  userId: string;
  userName: string;
  payload: any;
}

export class TimelineEventGenerator {
  constructor(private privacyGuard: PrivacyGuard) {}

  /**
   * Called by Kafka consumer when a domain event arrives.
   */
  async processEvent(event: DomainEvent, preferredTone: PersonalityTone = PersonalityTone.FUNNY) {
    let timelineMessage = '';

    // E.g., check if user allows sharing raw sleep duration
    const isRawShared = true; // this.privacyGuard.isSharingRawDataAllowed(...)

    switch (event.type) {
      case 'SleepCompleted':
        if (isRawShared && event.payload.hours) {
          timelineMessage = PersonalityFormatter.formatSleepDuration(event.userName, event.payload.hours, preferredTone);
        } else {
          timelineMessage = `🌙 ${event.userName} baru saja bangun tidur.`;
        }
        break;

      case 'StreakUpdated':
        timelineMessage = PersonalityFormatter.formatStreak(event.userName, event.payload.days, preferredTone);
        break;

      case 'ChallengeCompleted':
        timelineMessage = `⭐ ${event.userName} menyelesaikan tantangan: ${event.payload.challengeName}.`;
        break;
    }

    if (timelineMessage) {
      await this._saveToTimeline(event.userId, timelineMessage);
    }
  }

  private async _saveToTimeline(userId: string, message: string) {
    console.log(`[TimelineGenerator] Generated Post: "${message}"`);
    // INSERT INTO timeline_posts ...
  }
}
