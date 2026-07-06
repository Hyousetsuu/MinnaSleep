import 'package:flutter/foundation.dart';
import 'logger_service.dart';

enum WorkerPriority {
  low(20),
  medium(60),
  high(80),
  critical(100);

  final int value;
  const WorkerPriority(this.value);
}

enum WorkerStatus { idle, running, retrying, blocked, disabled }

class WorkerTask {
  final String id;
  final String name;
  final WorkerPriority priority;
  final Future<void> Function() execute;
  WorkerStatus status;

  WorkerTask({
    required this.id,
    required this.name,
    required this.priority,
    required this.execute,
    this.status = WorkerStatus.idle,
  });
}

class TaskScheduler {
  final List<WorkerTask> _queue = [];
  bool _isRunning = false;

  void schedule(WorkerTask task) {
    _queue.add(task);
    // Sort descending by priority value
    _queue.sort((a, b) => b.priority.value.compareTo(a.priority.value));
    LoggerService.i('Task Scheduled: ${task.name} (Priority: ${task.priority.name})');
    
    if (!_isRunning) {
      _processQueue();
    }
  }

  Future<void> _processQueue() async {
    if (_queue.isEmpty) {
      _isRunning = false;
      return;
    }

    _isRunning = true;
    final task = _queue.removeAt(0);

    try {
      task.status = WorkerStatus.running;
      LoggerService.i('Executing Task: ${task.name}');
      await task.execute();
      task.status = WorkerStatus.idle;
    } catch (e) {
      task.status = WorkerStatus.retrying;
      LoggerService.e('Task Failed: ${task.name}. Error: $e');
      // In a real implementation, you'd integrate the RetryPolicy here
    } finally {
      // Process next task
      _processQueue();
    }
  }

  List<WorkerTask> get runningTasks => _queue.where((t) => t.status != WorkerStatus.idle).toList();
}
