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
      payload: dto.payload,
      createdAt: DateTime.parse(dto.createdAt),
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
      payload: entity.payload,
      createdAt: entity.createdAt.toIso8601String(),
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
}
