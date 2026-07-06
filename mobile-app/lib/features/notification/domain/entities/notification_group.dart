import 'notification_entity.dart';

class NotificationGroup {
  final String groupName; // e.g., 'Today', 'Earlier', 'Achievements'
  final List<NotificationEntity> notifications;

  const NotificationGroup({
    required this.groupName,
    required this.notifications,
  });

  bool get isEmpty => notifications.isEmpty;
  int get count => notifications.length;
}
