import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';
import '../../domain/entities/notification_id_generator.dart';

class PremiumNotificationFactory {
  static NotificationEntity createExpired(String userId, Map<String, dynamic> metadata) {
    return NotificationEntity(
      id: NotificationIdGenerator.generate(),
      userId: userId,
      title: 'Premium Expired',
      body: 'Your premium subscription has ended. Renew to keep your perks!',
      type: NotificationType.premium,
      priority: NotificationPriority.normal,
      status: NotificationStatus.generated,
      channel: NotificationChannel.inbox,
      action: NotificationAction.openPremium,
      metadata: metadata,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(days: 3)), // 3 days expiry for promo
    );
  }
}
