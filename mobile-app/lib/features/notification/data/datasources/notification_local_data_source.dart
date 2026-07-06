import '../models/notification_dto.dart';

abstract class NotificationLocalDataSource {
  Future<void> insertNotification(NotificationDto dto);
  Future<List<NotificationDto>> getNotifications(String userId, int limit, int offset);
  Future<void> updateStatus(String notificationId, String newStatus);
  Future<void> markAllAsRead(String userId);
  Future<List<NotificationDto>> getUnsyncedNotifications(String userId);
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  // Mocked drift database wrapper
  final List<NotificationDto> _db = [];

  @override
  Future<void> insertNotification(NotificationDto dto) async {
    _db.add(dto);
  }

  @override
  Future<List<NotificationDto>> getNotifications(String userId, int limit, int offset) async {
    final userNotifs = _db.where((n) => n.userId == userId).toList();
    userNotifs.sort((a, b) => DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
    final end = (offset + limit < userNotifs.length) ? offset + limit : userNotifs.length;
    if (offset >= userNotifs.length) return [];
    return userNotifs.sublist(offset, end);
  }

  @override
  Future<void> updateStatus(String notificationId, String newStatus) async {
    final index = _db.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      final old = _db[index];
      _db[index] = NotificationDto(
        id: old.id,
        userId: old.userId,
        title: old.title,
        body: old.body,
        type: old.type,
        priority: old.priority,
        status: newStatus,
        payload: old.payload,
        createdAt: old.createdAt,
      );
    }
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    for (int i = 0; i < _db.length; i++) {
      if (_db[i].userId == userId && _db[i].status != 'read') {
        _db[i] = NotificationDto(
          id: _db[i].id,
          userId: _db[i].userId,
          title: _db[i].title,
          body: _db[i].body,
          type: _db[i].type,
          priority: _db[i].priority,
          status: 'read',
          payload: _db[i].payload,
          createdAt: _db[i].createdAt,
        );
      }
    }
  }

  @override
  Future<List<NotificationDto>> getUnsyncedNotifications(String userId) async {
    return _db.where((n) => n.userId == userId && n.status == 'persisted').toList();
  }
}
