import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';
import '../../domain/entities/notification_id_generator.dart';

class AchievementNotificationFactory {
  static NotificationEntity createBadgeUnlocked(String userId, String badgeName, Map<String, dynamic> metadata) {
    return NotificationEntity(
      id: NotificationIdGenerator.generate(),
      userId: userId,
      title: 'Badge Unlocked! 🏅',
      body: 'Congratulations, you earned the $badgeName badge.',
      type: NotificationType.achievement,
      priority: NotificationPriority.normal,
      status: NotificationStatus.generated,
      channel: NotificationChannel.inbox,
      action: NotificationAction.openAchievement,
      metadata: metadata,
      createdAt: DateTime.now(),
    );
  }
}
