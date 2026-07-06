import 'notification_enums.dart';

class NotificationEntity {
  final String id;
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final NotificationPriority priority;
  final NotificationStatus status;
  final NotificationChannel channel;
  final NotificationAction action;
  final Map<String, dynamic>? payload;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final DateTime? readAt;
  final DateTime? deletedAt;

  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.priority,
    required this.status,
    this.channel = NotificationChannel.inbox,
    this.action = NotificationAction.none,
    this.payload,
    this.metadata,
    required this.createdAt,
    this.expiresAt,
    this.readAt,
    this.deletedAt,
  });

  NotificationEntity copyWith({
    NotificationStatus? status,
    DateTime? readAt,
    DateTime? deletedAt,
  }) {
    return NotificationEntity(
      id: id,
      userId: userId,
      title: title,
      body: body,
      type: type,
      priority: priority,
      status: status ?? this.status,
      channel: channel,
      action: action,
      payload: payload,
      metadata: metadata,
      createdAt: createdAt,
      expiresAt: expiresAt,
      readAt: readAt ?? this.readAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
