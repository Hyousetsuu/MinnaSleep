import 'notification_enums.dart';

class NotificationEntity {
  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationPriority priority;
  final NotificationStatus status;
  final Map<String, dynamic>? payload;
  final DateTime createdAt;

  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.priority,
    required this.status,
    this.payload,
    required this.createdAt,
  });

  NotificationEntity copyWith({
    NotificationStatus? status,
  }) {
    return NotificationEntity(
      id: id,
      userId: userId,
      title: title,
      body: body,
      type: type,
      priority: priority,
      status: status ?? this.status,
      payload: payload,
      createdAt: createdAt,
    );
  }
}
