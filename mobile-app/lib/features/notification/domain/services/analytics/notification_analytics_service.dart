import '../../../../../core/services/app_metrics_service.dart';

class NotificationAnalyticsService {
  // Logs domain-specific notification metrics
  
  static void logNotificationOpened(String notificationId, Duration timeToRead) {
    AppMetricsService.logEvent('Notification_Opened', {
      'id': notificationId,
      'read_time_seconds': timeToRead.inSeconds,
    });
  }
  
  static void logNotificationDismissed(String notificationId) {
    AppMetricsService.logEvent('Notification_Dismissed', {
      'id': notificationId,
    });
  }

  static void logNotificationActionClicked(String notificationId, String actionName) {
    AppMetricsService.logEvent('Notification_Action_Clicked', {
      'id': notificationId,
      'action': actionName,
    });
  }
}
