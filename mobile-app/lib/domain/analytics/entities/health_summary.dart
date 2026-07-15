/// Aggregated summary of health metrics over a specific time window.
/// This prevents the AI and Dashboard from needing to parse thousands of raw records.
export class HealthSummary {
  final DateTime startDate;
  final DateTime endDate;

  // Sleep Metrics
  final Duration totalSleepDuration;
  final Duration deepSleepDuration;
  final Duration remSleepDuration;
  final Duration sleepDebt;

  // Cardiovascular Metrics
  final double averageRestingHeartRate;
  final double averageHrvRmssd; // Root mean square of successive differences

  // Respiratory Metrics
  final double averageBloodOxygenPercentage;
  final double averageRespiratoryRate;

  // Activity Metrics
  final int totalSteps;
  final double totalActiveCalories;

  const HealthSummary({
    required this.startDate,
    required this.endDate,
    required this.totalSleepDuration,
    required this.deepSleepDuration,
    required this.remSleepDuration,
    required this.sleepDebt,
    required this.averageRestingHeartRate,
    required this.averageHrvRmssd,
    required this.averageBloodOxygenPercentage,
    required this.averageRespiratoryRate,
    required this.totalSteps,
    required this.totalActiveCalories,
  });

  /// Serializes the summary into a secure JSON payload for the AI PromptBuilder
  Map<String, dynamic> toJson() {
    return {
      'period': '${startDate.toIso8601String()} to ${endDate.toIso8601String()}',
      'sleep': {
        'total_hours': totalSleepDuration.inHours,
        'deep_hours': deepSleepDuration.inHours,
        'rem_hours': remSleepDuration.inHours,
        'debt_hours': sleepDebt.inHours,
      },
      'cardio': {
        'resting_hr': averageRestingHeartRate,
        'hrv_rmssd': averageHrvRmssd,
      },
      'respiratory': {
        'spo2_percent': averageBloodOxygenPercentage,
        'respiration_rate': averageRespiratoryRate,
      },
      'activity': {
        'steps': totalSteps,
        'active_calories': totalActiveCalories,
      }
    };
  }
}
