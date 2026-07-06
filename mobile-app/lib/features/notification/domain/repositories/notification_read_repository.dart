import '../../../../core/error/result.dart';
import '../entities/notification_entity.dart';
import '../entities/notification_group.dart';
import '../entities/notification_query.dart';

abstract class NotificationReadRepository {
  // CQRS Read Side
  Future<Result<List<NotificationEntity>>> queryNotifications(NotificationQuery query);
  Future<Result<List<NotificationGroup>>> getGroupedNotifications(NotificationQuery query);
  Future<Result<int>> getUnreadCount(String userId);
}
