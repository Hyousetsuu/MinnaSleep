/// Base class for all unified health records in Minna Sleep.
/// No vendor-specific details (Apple/Garmin) should exist here.
export abstract class HealthRecord {
  final String externalRecordId;
  final String provider; // e.g., 'apple_health', 'google_health_connect'
  final DateTime startTime;
  final DateTime endTime;

  // Phase 11.5: Health Data Quality Engine
  final double qualityScore; // 0.0 to 1.0 (e.g. 1.0 = clean, 0.5 = gap/overlap)
  final double confidence; // Confidence interval provided by device
  final String sourceReliability; // e.g., 'medical_grade', 'consumer_grade', 'manual_entry'
  final bool normalized; // True if timezone shifts or anomalies were automatically corrected

  const HealthRecord({
    required this.externalRecordId,
    required this.provider,
    required this.startTime,
    required this.endTime,
    this.qualityScore = 1.0,
    this.confidence = 1.0,
    this.sourceReliability = 'consumer_grade',
    this.normalized = false,
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
