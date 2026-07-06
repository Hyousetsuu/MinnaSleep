import 'package:uuid/uuid.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';

class NotificationFactory {
  static const Uuid _uuid = Uuid();

  static NotificationEntity sleepCompleted(String userId, int minutes) {
    return NotificationEntity(
      id: _uuid.v4(),
      userId: userId,
      title: 'Sleep Session Completed',
      body: 'You tracked $minutes minutes of sleep!',
      type: NotificationType.sleep,
      priority: NotificationPriority.critical,
      status: NotificationStatus.generated,
      createdAt: DateTime.now(),
      payload: {'minutes': minutes},
    );
  }

  static NotificationEntity badgeUnlocked(String userId, String badgeName) {
    return NotificationEntity(
      id: _uuid.v4(),
      userId: userId,
      title: 'Badge Unlocked! 🏅',
      body: 'Congratulations, you earned the $badgeName badge.',
      type: NotificationType.achievement,
      priority: NotificationPriority.normal,
      status: NotificationStatus.generated,
      createdAt: DateTime.now(),
    );
  }

  static NotificationEntity syncFailed(String userId, String reason) {
    return NotificationEntity(
      id: _uuid.v4(),
      userId: userId,
      title: 'Sync Failed',
      body: 'We could not sync your data: $reason',
      type: NotificationType.syncFailed,
      priority: NotificationPriority.high,
      status: NotificationStatus.generated,
      createdAt: DateTime.now(),
    );
  }

  static NotificationEntity premiumExpired(String userId) {
    return NotificationEntity(
      id: _uuid.v4(),
      userId: userId,
      title: 'Premium Expired',
      body: 'Your premium subscription has ended. Renew to keep your perks!',
      type: NotificationType.premium,
      priority: NotificationPriority.normal,
      status: NotificationStatus.generated,
      createdAt: DateTime.now(),
    );
  }
}
