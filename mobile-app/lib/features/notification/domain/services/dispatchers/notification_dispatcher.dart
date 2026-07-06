import '../entities/notification_entity.dart';

abstract class NotificationDispatcher {
  Future<void> dispatch(NotificationEntity notification);
}

class LocalNotificationDispatcher implements NotificationDispatcher {
  @override
  Future<void> dispatch(NotificationEntity notification) async {
    // Call flutter_local_notifications to show a heads-up banner
  }
}

class PushNotificationDispatcher implements NotificationDispatcher {
  @override
  Future<void> dispatch(NotificationEntity notification) async {
    // Send to backend/FCM for push notification
  }
}

class InboxOnlyDispatcher implements NotificationDispatcher {
  @override
  Future<void> dispatch(NotificationEntity notification) async {
    // Do nothing on OS side, it just rests in the DB for the Inbox UI to read
  }
}

class NotificationDispatcherFactory {
  static NotificationDispatcher getDispatcher(NotificationChannel channel) {
    switch (channel) {
      case NotificationChannel.local:
        return LocalNotificationDispatcher();
      case NotificationChannel.push:
        return PushNotificationDispatcher();
      case NotificationChannel.inbox:
        return InboxOnlyDispatcher();
      case NotificationChannel.email:
      case NotificationChannel.sms:
        // Normally handled by backend, so client just treats it as Push/Sync
        return PushNotificationDispatcher();
    }
  }
}
