import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';
import 'notification_dto.dart';

class NotificationMapper {
  static NotificationEntity fromDto(NotificationDto dto) {
    return NotificationEntity(
      id: dto.id,
      userId: dto.userId,
      title: dto.title,
      body: dto.body,
      type: _typeFromString(dto.type),
      priority: _priorityFromString(dto.priority),
      status: _statusFromString(dto.status),
      channel: _channelFromString(dto.channel),
      action: _actionFromString(dto.action),
      payload: dto.payload,
      metadata: dto.metadata,
      createdAt: DateTime.parse(dto.createdAt),
      expiresAt: dto.expiresAt != null ? DateTime.parse(dto.expiresAt!) : null,
      readAt: dto.readAt != null ? DateTime.parse(dto.readAt!) : null,
      deletedAt: dto.deletedAt != null ? DateTime.parse(dto.deletedAt!) : null,
    );
  }

  static NotificationDto toDto(NotificationEntity entity) {
    return NotificationDto(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      body: entity.body,
      type: entity.type.name,
      priority: entity.priority.name,
      status: entity.status.name,
      channel: entity.channel.name,
      action: entity.action.name,
      payload: entity.payload,
      metadata: entity.metadata,
      createdAt: entity.createdAt.toIso8601String(),
      expiresAt: entity.expiresAt?.toIso8601String(),
      readAt: entity.readAt?.toIso8601String(),
      deletedAt: entity.deletedAt?.toIso8601String(),
    );
  }

  static NotificationType _typeFromString(String value) {
    return NotificationType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationType.system,
    );
  }

  static NotificationPriority _priorityFromString(String value) {
    return NotificationPriority.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationPriority.normal,
    );
  }

  static NotificationStatus _statusFromString(String value) {
    return NotificationStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationStatus.generated,
    );
  }

  static NotificationChannel _channelFromString(String value) {
    return NotificationChannel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationChannel.inbox,
    );
  }

  static NotificationAction _actionFromString(String value) {
    return NotificationAction.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationAction.none,
    );
  }
}
