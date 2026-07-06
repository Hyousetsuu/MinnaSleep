class SleepConstants {
  static const int defaultSleepGoalMinutes = 480; // 8 hours
  static const int minimumSleepDuration = 30; // 30 minutes to count as a session
  static const int maximumSleepDuration = 1080; // 18 hours max

  // Accelerometer thresholds
  static const double motionThresholdLight = 1.2;
  static const double motionThresholdHeavy = 2.5;

  // AI & Scoring
  static const int excellentScoreMin = 90;
  static const int goodScoreMin = 75;
  static const int fairScoreMin = 60;
}
