import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';
import '../../domain/entities/notification_id_generator.dart';

class SyncNotificationFactory {
  static NotificationEntity createFailed(String userId, String reason, Map<String, dynamic> metadata) {
    return NotificationEntity(
      id: NotificationIdGenerator.generate(),
      userId: userId,
      title: 'Sync Failed',
      body: 'We could not sync your data: $reason',
      type: NotificationType.syncFailed,
      priority: NotificationPriority.high,
      status: NotificationStatus.generated,
      channel: NotificationChannel.local,
      action: NotificationAction.none,
      metadata: metadata,
      createdAt: DateTime.now(),
    );
  }
}
