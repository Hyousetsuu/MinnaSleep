/// Base class for all unified health records in Minna Sleep.
/// No vendor-specific details (Apple/Garmin) should exist here.
export abstract class HealthRecord {
  final String externalRecordId;
  final String provider; // e.g., 'apple_health', 'google_health_connect'
  final DateTime startTime;
  final DateTime endTime;

  const HealthRecord({
    required this.externalRecordId,
    required this.provider,
    required this.startTime,
    required this.endTime,
  });
}

export class SleepRecord extends HealthRecord {
  final String sleepStage; // 'awake', 'light', 'deep', 'rem'
  
  const SleepRecord({
    required String externalRecordId,
    required String provider,
    required DateTime startTime,
    required DateTime endTime,
    required this.sleepStage,
  }) : super(
          externalRecordId: externalRecordId,
          provider: provider,
          startTime: startTime,
          endTime: endTime,
        );
}

export class HeartRateRecord extends HealthRecord {
  final double beatsPerMinute;

  const HeartRateRecord({
    required String externalRecordId,
    required String provider,
    required DateTime startTime,
    required DateTime endTime,
    required this.beatsPerMinute,
  }) : super(
          externalRecordId: externalRecordId,
          provider: provider,
          startTime: startTime,
          endTime: endTime,
        );
}

export class HeartRateVariabilityRecord extends HealthRecord {
  final double rmssd; // Root mean square of successive differences

  const HeartRateVariabilityRecord({
    required String externalRecordId,
    required String provider,
    required DateTime startTime,
    required DateTime endTime,
    required this.rmssd,
  }) : super(
          externalRecordId: externalRecordId,
          provider: provider,
          startTime: startTime,
          endTime: endTime,
        );
}
