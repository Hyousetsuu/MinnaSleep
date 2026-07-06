import 'package:flutter/foundation.dart';

class UserOverview {
  final String displayName;
  final String avatarUrl;
  final int currentStreak;
  final bool isPremium;

  UserOverview({
    required this.displayName,
    required this.avatarUrl,
    required this.currentStreak,
    this.isPremium = false,
  });
}

class SleepStatistics {
  final int sleepScore;
  final String quality; // "Excellent!", "Good", "Fair", "Poor"
  final String motivationalText;
  final DateTime bedtime;
  final DateTime wakeTime;
  final int durationMinutes;
  final int goalMinutes;

  SleepStatistics({
    required this.sleepScore,
    required this.quality,
    required this.motivationalText,
    required this.bedtime,
    required this.wakeTime,
    required this.durationMinutes,
    required this.goalMinutes,
  });
}

class DailyProgress {
  final String dayName; // "Mon", "Tue"
  final int durationMinutes;
  final int goalMinutes;
  
  DailyProgress({
    required this.dayName,
    required this.durationMinutes,
    required this.goalMinutes,
  });
}

class AIInsight {
  final String message;
  final bool isAvailable; // false if AI feature flag is off or premium only

  AIInsight({
    required this.message,
    this.isAvailable = true,
  });
}

class RecentActivity {
  final String id;
  final DateTime date;
  final int durationMinutes;
  final int sleepScore;
  final String mood; // emoji

  RecentActivity({
    required this.id,
    required this.date,
    required this.durationMinutes,
    required this.sleepScore,
    required this.mood,
  });
}

// Special model for Sleep Timeline
class SleepTimelineEvent {
  final String time; // e.g. "22:45"
  final String description; // e.g. "Fell Asleep"
  final String emoji; // e.g. "😴"

  SleepTimelineEvent({
    required this.time,
    required this.description,
    required this.emoji,
  });
}

class DashboardData {
  final UserOverview overview;
  final SleepStatistics statistics;
  final List<DailyProgress> weeklyProgress;
  final AIInsight insight;
  final List<RecentActivity> recentActivities;
  final List<SleepTimelineEvent> timeline;

  DashboardData({
    required this.overview,
    required this.statistics,
    required this.weeklyProgress,
    required this.insight,
    required this.recentActivities,
    required this.timeline,
  });
}
