import 'dart:convert';

class User {
  final String id;
  final String email;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.createdAt,
  });
}

class Profile {
  final String id;
  final String userId;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final String? bio;
  final String role; // free, premium, admin
  final int sleepGoal; // in minutes
  final String bedtimeGoal;
  final String wakeupGoal;
  final String timezone;
  final int currentStreak;
  final int longestStreak;
  final int level;
  final int xp;
  final String privacy;

  Profile({
    required this.id,
    required this.userId,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    this.bio,
    this.role = 'free',
    this.sleepGoal = 480,
    this.bedtimeGoal = '23:00',
    this.wakeupGoal = '07:00',
    this.timezone = 'Asia/Jakarta',
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.level = 1,
    this.xp = 0,
    this.privacy = 'public',
  });
}

class SleepSession {
  final String id;
  final String userId;
  final DateTime bedtime;
  final DateTime wakeTime;
  final int durationMinutes;
  final int? sleepScore;
  final String? mood;
  final int? energyLevel;
  final int? stressLevel;
  final String? notes;
  final List<String> tags;
  final String source;

  SleepSession({
    required this.id,
    required this.userId,
    required this.bedtime,
    required this.wakeTime,
    required this.durationMinutes,
    this.sleepScore,
    this.mood,
    this.energyLevel,
    this.stressLevel,
    this.notes,
    this.tags = const [],
    this.source = 'manual',
  });
}

class SleepSummary {
  final int todayScore;
  final int todayDurationMinutes;
  final String aiInsight;
  final List<double> weeklyProgress; // List of daily scores or durations

  SleepSummary({
    required this.todayScore,
    required this.todayDurationMinutes,
    required this.aiInsight,
    required this.weeklyProgress,
  });
}
