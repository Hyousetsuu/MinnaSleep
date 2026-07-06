import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_local_data_source.dart';
import '../datasources/notification_remote_data_source.dart';
import '../datasources/notification_memory_cache.dart';
import '../models/notification_mapper.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDataSource _local;
  final NotificationRemoteDataSource _remote;
  final NotificationMemoryCache _cache;

  NotificationRepositoryImpl(this._local, this._remote, this._cache);

  @override
  Future<Result<void>> saveNotification(NotificationEntity notification) async {
    try {
      final dto = NotificationMapper.toDto(notification.copyWith(status: NotificationStatus.persisted));
      await _local.insertNotification(dto);
      
      // Update Cache
      _cache.setLatestNotification(dto);
      // Invalidate unread count so next request fetches fresh Drift data
      // or we can increment it if we keep track. Let's just invalidate for safety.
      _cache.invalidate();

      return const Success(null);
    } catch (e) {
      return Error(DatabaseFailure(message: 'Failed to insert notification: $e'));
    }
  }

  @override
  Future<Result<List<NotificationEntity>>> getNotifications(String userId, {int limit = 20, int offset = 0}) async {
    try {
      final dtos = await _local.getNotifications(userId, limit, offset);
      final entities = dtos.map(NotificationMapper.fromDto).toList();
      return Success(entities);
    } catch (e) {
      return Error(DatabaseFailure(message: 'Failed to get notifications: $e'));
    }
  }

  @override
  Future<Result<void>> markAsRead(String notificationId) async {
    try {
      await _local.updateStatus(notificationId, NotificationStatus.read.name);
      _cache.invalidate();
      return const Success(null);
    } catch (e) {
      return Error(DatabaseFailure(message: 'Failed to mark as read: $e'));
    }
  }

  @override
  Future<Result<void>> markAllAsRead(String userId) async {
    try {
      await _local.markAllAsRead(userId);
      _cache.invalidate();
      return const Success(null);
    } catch (e) {
      return Error(DatabaseFailure(message: 'Failed to mark all as read: $e'));
    }
  }

  @override
  Future<Result<void>> archiveNotification(String notificationId) async {
    try {
      await _local.updateStatus(notificationId, NotificationStatus.archived.name);
      _cache.invalidate();
      return const Success(null);
    } catch (e) {
      return Error(DatabaseFailure(message: 'Failed to archive: $e'));
    }
  }

  @override
  Future<Result<void>> syncPendingNotifications(String userId) async {
    try {
      final pending = await _local.getUnsyncedNotifications(userId);
      if (pending.isEmpty) return const Success(null);
      
      await _remote.syncNotifications(pending);
      
      for (final notif in pending) {
        await _local.updateStatus(notif.id, NotificationStatus.delivered.name);
      }
      return const Success(null);
    } catch (e) {
      return Error(NetworkFailure(message: 'Failed to sync notifications: $e'));
    }
  }
}
