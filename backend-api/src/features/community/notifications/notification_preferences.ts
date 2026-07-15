/**
 * Sprint 15.5: Notification Preferences
 * Manages granular opt-in/opt-out settings for push notifications.
 */

export interface UserNotificationPreferences {
  kudos: boolean;
  challengeReminder: boolean;
  weeklySummary: boolean;
  friendActivity: boolean;
  marketing: boolean;
}

export class NotificationPreferencesManager {
  
  /**
   * Retrieves the user's notification preferences. Defaults all core features to true, marketing to false.
   */
  async getPreferences(userId: string): Promise<UserNotificationPreferences> {
    // SELECT * FROM user_notification_settings WHERE userId = ...
    return {
      kudos: true,
      challengeReminder: true,
      weeklySummary: true,
      friendActivity: false, // User opted out of general friend activity
      marketing: false
    };
  }

  /**
   * Checks if a specific notification type is allowed by the user.
   */
  async isAllowed(userId: string, type: keyof UserNotificationPreferences): Promise<boolean> {
    const prefs = await this.getPreferences(userId);
    return prefs[type] === true;
  }
}
