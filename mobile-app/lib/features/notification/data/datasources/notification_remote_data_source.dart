import '../models/notification_dto.dart';

abstract class NotificationRemoteDataSource {
  Future<void> syncNotifications(List<NotificationDto> notifications);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  @override
  Future<void> syncNotifications(List<NotificationDto> notifications) async {
    // API Call to POST /notifications/sync
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
