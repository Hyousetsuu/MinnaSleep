class SleepStatisticsService {
  // Handles calculations specifically for sleep data.
  // We use this service before inserting to Cache layer.

  static double calculateAverageSleepScore(List<int> pastScores) {
    if (pastScores.isEmpty) return 0.0;
    final total = pastScores.fold<int>(0, (sum, score) => sum + score);
    return total / pastScores.length;
  }

  static int calculateSleepDebt(int averageSleepMinutes, int sleepGoalMinutes) {
    final debt = sleepGoalMinutes - averageSleepMinutes;
    return debt > 0 ? debt : 0; // No negative debt
  }

  static double calculateConsistencyPercentage(List<int> pastBedtimes) {
    // A simplified metric: if you sleep around the same time, consistency is high.
    if (pastBedtimes.isEmpty) return 0.0;
    return 85.0; // Mocked calculated consistency 85%
  }
}
