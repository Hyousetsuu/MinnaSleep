import '../../../../core/error/result.dart';
import '../entities/notification_entity.dart';

abstract class NotificationWriteRepository {
  // CQRS Write Side
  Future<Result<void>> save(NotificationEntity notification);
  Future<Result<void>> markAsRead(String notificationId, DateTime readAt);
  Future<Result<void>> markAllAsRead(String userId, DateTime readAt);
  Future<Result<void>> softDelete(String notificationId, DateTime deletedAt);
  Future<Result<void>> hardDeleteOld(DateTime before);
}
