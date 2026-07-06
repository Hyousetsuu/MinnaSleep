import '../models/notification_dto.dart';

class NotificationMemoryCache {
  int? _unreadCount;
  DateTime? _unreadCountTimestamp;
  
  NotificationDto? _latestNotification;
  DateTime? _latestNotificationTimestamp;

  final Duration countTtl = const Duration(seconds: 10);
  final Duration latestTtl = const Duration(seconds: 5);

  int? getUnreadCount() {
    if (_unreadCount != null && _unreadCountTimestamp != null) {
      if (DateTime.now().difference(_unreadCountTimestamp!) < countTtl) {
        return _unreadCount;
      }
    }
    return null;
  }

  void setUnreadCount(int count) {
    _unreadCount = count;
    _unreadCountTimestamp = DateTime.now();
  }

  NotificationDto? getLatestNotification() {
    if (_latestNotification != null && _latestNotificationTimestamp != null) {
      if (DateTime.now().difference(_latestNotificationTimestamp!) < latestTtl) {
        return _latestNotification;
      }
    }
    return null;
  }

  void setLatestNotification(NotificationDto notification) {
    _latestNotification = notification;
    _latestNotificationTimestamp = DateTime.now();
  }

  void invalidate() {
    _unreadCount = null;
    _latestNotification = null;
  }
}
