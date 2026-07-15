import { NotificationPreferencesManager } from './notification_preferences';

/**
 * Sprint 15.5: Notification Service
 * Background Worker (BullMQ/EventBus driven) that triggers cross-device Push Notifications.
 */

export interface NotificationEvent {
  type: 'FRIEND_KUDOS' | 'STREAK_OVERTAKEN' | 'CHALLENGE_ENDING' | 'ACHIEVEMENT_UNLOCKED';
  targetUserId: string;
  payload: any;
}

export class NotificationService {
  constructor(private prefsManager: NotificationPreferencesManager) {}

  /**
   * Entrypoint for the Background Queue Processor (BullMQ worker).
   */
  async processEvent(event: NotificationEvent): Promise<void> {
    const { targetUserId, type, payload } = event;

    let isAllowed = false;
    let title = '';
    let body = '';

    switch (type) {
      case 'FRIEND_KUDOS':
        isAllowed = await this.prefsManager.isAllowed(targetUserId, 'kudos');
        title = '🎉 You received Kudos!';
        body = `${payload.senderName} cheered for your sleep activity.`;
        break;
      
      case 'CHALLENGE_ENDING':
        isAllowed = await this.prefsManager.isAllowed(targetUserId, 'challengeReminder');
        title = '⏳ Challenge Ending Soon!';
        body = `${payload.challengeName} ends in 2 hours. Go to sleep!`;
        break;

      case 'STREAK_OVERTAKEN':
        isAllowed = await this.prefsManager.isAllowed(targetUserId, 'friendActivity');
        title = 'Uh oh! Streak Overtaken!';
        body = `${payload.friendName} just surpassed your sleep streak!`;
        break;
    }

    if (isAllowed) {
      await this._sendPush(targetUserId, title, body);
    } else {
      console.log(`[NotificationService] Suppressed ${type} for ${targetUserId} due to preferences.`);
    }
  }

  private async _sendPush(userId: string, title: string, body: string): Promise<void> {
    // Calling FCM / APNs Provider
    console.log(`[Push Sent] To: ${userId} | Title: "${title}" | Body: "${body}"`);
  }
}
