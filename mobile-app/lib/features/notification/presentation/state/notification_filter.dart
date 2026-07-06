import '../../domain/entities/notification_enums.dart';

class NotificationFilter {
  final NotificationType? category;
  final NotificationPriority? priority;
  final NotificationStatus? status;
  final DateTime? startDate;
  final DateTime? endDate;

  const NotificationFilter({
    this.category,
    this.priority,
    this.status,
    this.startDate,
    this.endDate,
  });

  bool get hasActiveFilters => category != null || priority != null || status != null || startDate != null;
}
