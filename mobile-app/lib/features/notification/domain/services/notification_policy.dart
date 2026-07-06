import '../entities/notification_enums.dart';

class NotificationPolicyConfig {
  final NotificationPriority priority;
  final NotificationChannel channel;
  final Duration? expiration;

  const NotificationPolicyConfig({
    required this.priority,
    required this.channel,
    this.expiration,
  });
}

class NotificationPolicy {
  // Centralizes all business rules regarding priority, channels, and expirations based on type.

  static NotificationPolicyConfig getConfig(NotificationType type) {
    switch (type) {
      case NotificationType.sleep:
        return const NotificationPolicyConfig(
          priority: NotificationPriority.critical,
          channel: NotificationChannel.local,
          expiration: null, // Keep forever
        );
      case NotificationType.reminder:
        return const NotificationPolicyConfig(
          priority: NotificationPriority.high,
          channel: NotificationChannel.push, // Or local depending on OS setup
          expiration: Duration(hours: 24),
        );
      case NotificationType.achievement:
        return const NotificationPolicyConfig(
          priority: NotificationPriority.normal,
          channel: NotificationChannel.inbox,
          expiration: null, // Keep forever
        );
      case NotificationType.premium:
        return const NotificationPolicyConfig(
          priority: NotificationPriority.normal,
          channel: NotificationChannel.inbox,
          expiration: Duration(days: 3), // Promotion expires in 3 days
        );
      case NotificationType.ai:
        return const NotificationPolicyConfig(
          priority: NotificationPriority.low,
          channel: NotificationChannel.inbox,
          expiration: Duration(days: 7), // AI insight expires in 7 days
        );
      case NotificationType.syncFailed:
        return const NotificationPolicyConfig(
          priority: NotificationPriority.high,
          channel: NotificationChannel.local,
          expiration: Duration(hours: 12),
        );
      case NotificationType.community:
        return const NotificationPolicyConfig(
          priority: NotificationPriority.low,
          channel: NotificationChannel.inbox,
          expiration: Duration(days: 30),
        );
      case NotificationType.system:
        return const NotificationPolicyConfig(
          priority: NotificationPriority.critical,
          channel: NotificationChannel.local,
          expiration: null,
        );
    }
  }
}
