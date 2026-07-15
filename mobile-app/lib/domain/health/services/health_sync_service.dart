import '../entities/health_record.dart';
import '../repositories/health_repository.dart';

/// Service responsible for syncing unified health records from the device
/// to the local Drift database, handling conflict resolution, and pushing
/// to the backend Express API via Outbox/Sync Queue.
abstract class HealthSyncService {
  
  /// Imports records from the wearable provider in chunks to prevent UI freezing (Phase 6)
  Future<void> importProviderDataInChunks({
    required DateTime start,
    required DateTime end,
    required HealthRepository providerAdapter,
  });

  /// Deduplicates records based on (provider + externalRecordId + startTime) (Phase 4)
  Future<List<HealthRecord>> resolveConflicts(List<HealthRecord> newRecords);

  /// Pushes the local unified records to the Express backend
  Future<void> syncToBackend();
}
