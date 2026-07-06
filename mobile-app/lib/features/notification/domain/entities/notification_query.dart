import 'notification_enums.dart';

class NotificationQuery {
  final String userId;
  final NotificationType? type;
  final NotificationStatus? status;
  final NotificationChannel? channel;
  final String? keyword; // Used for Search Index
  final int limit;
  final int offset;

  const NotificationQuery({
    required this.userId,
    this.type,
    this.status,
    this.channel,
    this.keyword,
    this.limit = 20,
    this.offset = 0,
  });
}
