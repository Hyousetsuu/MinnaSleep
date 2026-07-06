import '../../entities/notification_enums.dart';

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

abstract class INotificationPolicy {
  NotificationPolicyConfig getConfig();
}

class SleepPolicy implements INotificationPolicy {
  @override
  NotificationPolicyConfig getConfig() => const NotificationPolicyConfig(
    priority: NotificationPriority.critical,
    channel: NotificationChannel.local,
    expiration: null,
  );
}

class AchievementPolicy implements INotificationPolicy {
  @override
  NotificationPolicyConfig getConfig() => const NotificationPolicyConfig(
    priority: NotificationPriority.normal,
    channel: NotificationChannel.inbox,
    expiration: null,
  );
}

// ... other policies

class NotificationPolicyRegistry {
  static INotificationPolicy resolve(NotificationType type) {
    switch (type) {
      case NotificationType.sleep:
        return SleepPolicy();
      case NotificationType.achievement:
        return AchievementPolicy();
      default:
        // Fallback
        return SleepPolicy();
    }
  }
}
