class NotificationDto {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String type;
  final String priority;
  final String status;
  final String channel;
  final String action;
  final Map<String, dynamic>? payload;
  final Map<String, dynamic>? metadata;
  final String createdAt;
  final String? expiresAt;
  final String? readAt;
  final String? deletedAt;

  const NotificationDto({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.priority,
    required this.status,
    required this.channel,
    required this.action,
    this.payload,
    this.metadata,
    required this.createdAt,
    this.expiresAt,
    this.readAt,
    this.deletedAt,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      channel: json['channel'] as String? ?? 'inbox',
      action: json['action'] as String? ?? 'none',
      payload: json['payload'] as Map<String, dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['created_at'] as String,
      expiresAt: json['expires_at'] as String?,
      readAt: json['read_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'body': body,
      'type': type,
      'priority': priority,
      'status': status,
      'channel': channel,
      'action': action,
      'payload': payload,
      'metadata': metadata,
      'created_at': createdAt,
      'expires_at': expiresAt,
      'read_at': readAt,
      'deleted_at': deletedAt,
    };
  }
}
