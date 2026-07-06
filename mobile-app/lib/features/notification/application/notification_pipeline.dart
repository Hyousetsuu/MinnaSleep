import '../../../../core/database/transaction_manager.dart';
import '../../../../core/events/domain_events.dart';
import '../../../../core/services/app_metrics_service.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_enums.dart';
import '../../domain/services/notification_deduplicator.dart';
import '../../domain/services/notification_policy.dart';
import '../../domain/services/notification_scheduler.dart';
import '../../domain/services/notification_validator.dart';
import '../../data/repositories/notification_repository_impl.dart';

class NotificationPipeline {
  final NotificationRepositoryImpl _repository;
  final NotificationDeduplicator _deduplicator;
  // Note: EventBus or Riverpod Event Dispatcher would be injected here

  NotificationPipeline(this._repository, this._deduplicator);

  /// Executes the 3-Stage Pipeline for incoming Domain Events
  Future<void> execute(NotificationEntity generatedEntity) async {
    final stopwatch = Stopwatch()..start();

    // ==========================================
    // STAGE A: Creation (Policy, Validator)
    // ==========================================
    
    // Apply Policy logic (override entity with policy constraints if needed)
    final policy = NotificationPolicy.getConfig(generatedEntity.type);
    final entityToProcess = generatedEntity.copyWith(
      status: NotificationStatus.generated,
      // We could ideally map Policy channel/expiration here if entity constructor was mutable,
      // but assuming Factory already obeyed Policy, we just validate.
    );

    // Validate
    final validationResult = NotificationValidator.validate(entityToProcess);
    if (validationResult.isError) {
      LoggerService.e('Stage A Failed: ${validationResult.error!.message}');
      return;
    }

    // ==========================================
    // STAGE B: Persistence (Deduplicator, DB)
    // ==========================================
    
    final isDup = await _deduplicator.isDuplicate(entityToProcess);
    if (isDup) {
      LoggerService.w('Stage B Halted: Duplicate notification detected');
      return;
    }

    try {
      // Transaction Manager wrapping Data Source and Audit
      await TransactionManager.run(() async {
        await _repository.saveNotification(entityToProcess);
      });
      stopwatch.stop();
      
      // Track Metrics
      AppMetricsService.logEvent('Notification_Persist_Time', {'ms': stopwatch.elapsedMilliseconds});

    } catch (e) {
      LoggerService.e('Stage B Failed: $e');
      return;
    }

    // ==========================================
    // STAGE C: Distribution (Scheduler, OS, Cloud)
    // ==========================================
    
    // 1. Scheduler
    if (entityToProcess.type == NotificationType.reminder) {
      // Example: Schedule 2 hours from now
      await NotificationScheduler.schedule(entityToProcess, DateTime.now().add(const Duration(hours: 2)));
    }

    // 2. Local OS Channel Check
    if (policy.channel == NotificationChannel.local || policy.channel == NotificationChannel.push) {
      LoggerService.i('Triggering Local OS Notification display');
    }

    // 3. Dispatch After-Persist Event
    LoggerService.i('Dispatching NotificationPersistedEvent');
    // EventDispatcher.dispatch(NotificationPersistedEvent(entityToProcess.id));
  }
}
