import 'health_record.dart';

/// The pure domain boundary.
/// The Application layer (Use Cases) and UI never interact with 
/// AppleHealthProvider or GoogleHealthConnectProvider directly.
abstract class HealthRepository {
  /// Check if the unified health permission is granted.
  Future<bool> hasPermissions();

  /// Request required permissions from the OS via the active provider adapter.
  Future<void> requestPermissions();

  /// Fetch sleep stages within a time range.
  Future<List<SleepRecord>> getSleepRecords(DateTime start, DateTime end);

  /// Fetch heart rate samples within a time range.
  Future<List<HeartRateRecord>> getHeartRate(DateTime start, DateTime end);

  /// Fetch heart rate variability (HRV) within a time range.
  Future<List<HeartRateVariabilityRecord>> getHeartRateVariability(DateTime start, DateTime end);
}
