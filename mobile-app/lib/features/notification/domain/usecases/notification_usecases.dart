import '../../../../core/error/result.dart';
import '../../presentation/models/notification_read_model.dart';
import '../../presentation/mappers/notification_read_model_mapper.dart';
import '../repositories/notification_read_repository.dart';
import '../repositories/notification_write_repository.dart';
import '../entities/notification_query.dart';

class GetNotificationsUseCase {
  final NotificationReadRepository _readRepository;

  GetNotificationsUseCase(this._readRepository);

  Future<Result<List<NotificationReadModel>>> execute(NotificationQuery query) async {
    final result = await _readRepository.queryNotifications(query);
    if (result.isError) {
      return Error(result.error!);
    }

    // Domain transforms Entity -> ReadModel
    final models = result.value!.map((entity) => NotificationReadModelMapper.fromEntity(entity)).toList();
    return Success(models);
  }
}

class MarkNotificationReadUseCase {
  final NotificationWriteRepository _writeRepository;

  MarkNotificationReadUseCase(this._writeRepository);

  Future<Result<void>> execute(String notificationId) async {
    return await _writeRepository.markAsRead(notificationId, DateTime.now());
  }
}

class MarkAllReadUseCase {
  final NotificationWriteRepository _writeRepository;

  MarkAllReadUseCase(this._writeRepository);

  Future<Result<void>> execute(String userId) async {
    return await _writeRepository.markAllAsRead(userId, DateTime.now());
  }
}

class SoftDeleteNotificationUseCase {
  final NotificationWriteRepository _writeRepository;

  SoftDeleteNotificationUseCase(this._writeRepository);

  Future<Result<void>> execute(String notificationId) async {
    return await _writeRepository.softDelete(notificationId, DateTime.now());
  }
}
