import '../../domain/entities/notification_entity.dart';
import 'sleep_notification_factory.dart';
import 'achievement_notification_factory.dart';
import 'sync_notification_factory.dart';
import 'premium_notification_factory.dart';

class NotificationFactory {
  // Acts as a Façade for domain-specific notification factories

  static Map<String, dynamic> _buildMetadata() {
    return {
      'generatedBy': 'NotificationFactory',
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  static NotificationEntity sleepCompleted(String userId, int minutes) {
    return SleepNotificationFactory.createCompleted(userId, minutes, _buildMetadata());
  }

  static NotificationEntity badgeUnlocked(String userId, String badgeName) {
    return AchievementNotificationFactory.createBadgeUnlocked(userId, badgeName, _buildMetadata());
  }

  static NotificationEntity syncFailed(String userId, String reason) {
    return SyncNotificationFactory.createFailed(userId, reason, _buildMetadata());
  }

  static NotificationEntity premiumExpired(String userId) {
    return PremiumNotificationFactory.createExpired(userId, _buildMetadata());
  }
}
