import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';
import '../../domain/entities/notification_id_generator.dart';

class SleepNotificationFactory {
  static NotificationEntity createCompleted(String userId, int minutes, Map<String, dynamic> metadata) {
    return NotificationEntity(
      id: NotificationIdGenerator.generate(),
      userId: userId,
      title: 'Sleep Session Completed',
      body: 'You tracked $minutes minutes of sleep!',
      type: NotificationType.sleep,
      priority: NotificationPriority.critical,
      status: NotificationStatus.generated,
      channel: NotificationChannel.local,
      action: NotificationAction.openSleep,
      payload: {'minutes': minutes},
      metadata: metadata,
      createdAt: DateTime.now(),
    );
  }
}
