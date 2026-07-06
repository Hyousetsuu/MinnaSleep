import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';
import '../models/notification_read_model.dart';

class NotificationReadModelMapper {
  static NotificationReadModel fromEntity(NotificationEntity entity) {
    final now = DateTime.now();
    final createdAt = entity.createdAt;
    
    final isToday = createdAt.year == now.year && createdAt.month == now.month && createdAt.day == now.day;
    final isYesterday = createdAt.year == now.year && createdAt.month == now.month && createdAt.day == now.subtract(const Duration(days: 1)).day;
    final isUnread = entity.readAt == null;

    return NotificationReadModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.body,
      isUnread: isUnread,
      showDot: isUnread && entity.priority == NotificationPriority.critical,
      formattedTime: '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}',
      relativeTime: _formatRelativeTime(createdAt, now),
      isToday: isToday,
      isYesterday: isYesterday,
      isPinned: entity.priority == NotificationPriority.critical,
      iconAsset: _getIconForType(entity.type),
      badgeColorHex: _getColorForType(entity.type),
      action: entity.action,
    );
  }

  static String _formatRelativeTime(DateTime time, DateTime now) {
    final diff = now.difference(time);
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
