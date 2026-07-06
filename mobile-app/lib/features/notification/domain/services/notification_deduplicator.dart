import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class NotificationDeduplicator {
  final NotificationRepository _repository;

  NotificationDeduplicator(this._repository);

  // Checks if a similar notification was generated within the last 5 minutes.
  // Useful to prevent spam (e.g. multiple "Sync Failed" events).
  Future<bool> isDuplicate(NotificationEntity entity) async {
    final result = await _repository.getNotifications(entity.userId, limit: 50);
    
    if (result.isError) return false; // Failsafe, allow if we can't check
    
    final recentNotifs = result.value!;
    final now = DateTime.now();
    final fiveMinutesAgo = now.subtract(const Duration(minutes: 5));

    for (var n in recentNotifs) {
      if (n.createdAt.isAfter(fiveMinutesAgo) && n.type == entity.type) {
        // Simple heuristic: if type and title are identical within 5 mins, it's a duplicate.
        // Can be expanded to check specific payloads if needed.
        if (n.title == entity.title) {
          return true;
        }
      }
    }
    
    return false;
  }
}
