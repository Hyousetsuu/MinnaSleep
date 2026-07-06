import '../../../../core/error/result.dart';
import '../entities/notification_entity.dart';
import '../entities/notification_enums.dart';

abstract class NotificationRepository {
  Future<Result<void>> saveNotification(NotificationEntity notification);
  Future<Result<List<NotificationEntity>>> getNotifications(String userId, {int limit = 20, int offset = 0});
  Future<Result<void>> markAsRead(String notificationId);
  Future<Result<void>> markAllAsRead(String userId);
  Future<Result<void>> archiveNotification(String notificationId);
  Future<Result<void>> syncPendingNotifications(String userId);
}
