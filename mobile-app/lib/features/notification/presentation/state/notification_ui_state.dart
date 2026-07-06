import '../models/notification_read_model.dart';
import '../../domain/entities/notification_group.dart';
import '../../domain/entities/notification_cursor.dart';
import 'notification_filter.dart';

enum NotificationUiStatus { loading, loaded, error, empty }

class NotificationUiState {
  final NotificationUiStatus status;
  final List<NotificationGroup> groupedNotifications; // ReadModel groups
  final NotificationFilter currentFilter;
  final NotificationCursor cursor;
  final bool hasMore;
  final String? errorMessage;

  const NotificationUiState({
    this.status = NotificationUiStatus.loading,
    this.groupedNotifications = const [],
    this.currentFilter = const NotificationFilter(),
    this.cursor = const NotificationCursor(),
    this.hasMore = true,
    this.errorMessage,
  });

  NotificationUiState copyWith({
    NotificationUiStatus? status,
    List<NotificationGroup>? groupedNotifications,
    NotificationFilter? currentFilter,
    NotificationCursor? cursor,
    bool? hasMore,
    String? errorMessage,
  }) {
    return NotificationUiState(
      status: status ?? this.status,
      groupedNotifications: groupedNotifications ?? this.groupedNotifications,
      currentFilter: currentFilter ?? this.currentFilter,
      cursor: cursor ?? this.cursor,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
