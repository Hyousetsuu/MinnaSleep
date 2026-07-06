import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';

class NotificationReadModel {
  // A UI-friendly representation of NotificationEntity
  // Isolates UI concerns (like formatting and colors) from the Domain Layer
  
  final String id;
  final String title;
  final String body;
  final bool isUnread;
  final String relativeTime;
  final String iconAsset;
  final String badgeColorHex;
  final NotificationAction action;

  NotificationReadModel({
    required this.id,
    required this.title,
    required this.body,
    required this.isUnread,
    required this.relativeTime,
    required this.iconAsset,
    required this.badgeColorHex,
    required this.action,
  });

  factory NotificationReadModel.fromEntity(NotificationEntity entity) {
    return NotificationReadModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      isUnread: entity.status == NotificationStatus.delivered || entity.status == NotificationStatus.persisted,
      relativeTime: _formatRelativeTime(entity.createdAt),
      iconAsset: _getIconForType(entity.type),
      badgeColorHex: _getColorForType(entity.type),
      action: entity.action,
    );
  }

  static String _formatRelativeTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${time.day}/${time.month}/${time.year}';
  }

  static String _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.sleep: return 'assets/icons/ic_sleep.png';
      case NotificationType.achievement: return 'assets/icons/ic_badge.png';
      case NotificationType.premium: return 'assets/icons/ic_star.png';
      case NotificationType.syncFailed: return 'assets/icons/ic_sync_error.png';
      case NotificationType.ai: return 'assets/icons/ic_magic.png';
      default: return 'assets/icons/ic_bell.png';
    }
  }

  static String _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.sleep: return '#4A90E2'; // Blue
      case NotificationType.achievement: return '#F5A623'; // Orange
      case NotificationType.syncFailed: return '#D0021B'; // Red
      case NotificationType.premium: return '#BD10E0'; // Purple
      default: return '#9B9B9B'; // Gray
    }
  }
}
