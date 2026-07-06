class NotificationDto {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String type;
  final String priority;
  final String status;
  final Map<String, dynamic>? payload;
  final String createdAt;

  const NotificationDto({
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

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
      createdAt: json['created_at'] as String,
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
      'payload': payload,
      'created_at': createdAt,
    };
  }
}
