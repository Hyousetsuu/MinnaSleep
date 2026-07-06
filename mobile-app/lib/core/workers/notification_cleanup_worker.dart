import 'dart:async';
import '../services/logger_service.dart';
import '../../features/notification/domain/services/notification_cleanup_service.dart';
import '../../features/notification/domain/repositories/notification_repository.dart';

class NotificationCleanupWorker {
  final NotificationCleanupService _cleanupService;
  Timer? _timer;

  NotificationCleanupWorker(NotificationRepository repository)
      : _cleanupService = NotificationCleanupService(repository);

  void start() {
    LoggerService.i('NotificationCleanupWorker started. (Runs every 1 hour)');
    // Run immediately
    _runTask();
    
    // Schedule every hour
    _timer = Timer.periodic(const Duration(hours: 1), (timer) {
      _runTask();
    });
  }

  Future<void> _runTask() async {
    try {
      LoggerService.i('[NotificationCleanupWorker] Executing cleanup...');
      // In a real scenario, this would pass the active userId
      await _cleanupService.runCleanup('system_or_active_user_id');
      LoggerService.i('[NotificationCleanupWorker] Cleanup complete.');
    } catch (e) {
      LoggerService.e('[NotificationCleanupWorker] Cleanup failed: $e');
    }
  }

  void stop() {
    _timer?.cancel();
    LoggerService.i('NotificationCleanupWorker stopped.');
  }
}
