import 'dart:async';
import '../domain/repositories/dashboard_repository.dart';
import 'models/dashboard_models.dart';

class MockDashboardRepository implements DashboardRepository {
  @override
  Future<DashboardData> getDashboardData() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Return mock data
    return DashboardData(
      overview: UserOverview(
        displayName: 'John Doe',
        avatarUrl: '',
        currentStreak: 12,
      ),
      statistics: SleepStatistics(
        sleepScore: 92,
        quality: 'Excellent!',
        motivationalText: 'You slept better than yesterday.',
        bedtime: DateTime.now().subtract(const Duration(hours: 8, minutes: 20)),
        wakeTime: DateTime.now(),
        durationMinutes: 485, // 8 hours 5 mins
        goalMinutes: 480, // 8 hours
      ),
      weeklyProgress: [
        DailyProgress(dayName: 'Mon', durationMinutes: 420, goalMinutes: 480),
        DailyProgress(dayName: 'Tue', durationMinutes: 450, goalMinutes: 480),
        DailyProgress(dayName: 'Wed', durationMinutes: 490, goalMinutes: 480),
        DailyProgress(dayName: 'Thu', durationMinutes: 380, goalMinutes: 480),
        DailyProgress(dayName: 'Fri', durationMinutes: 470, goalMinutes: 480),
        DailyProgress(dayName: 'Sat', durationMinutes: 520, goalMinutes: 480),
        DailyProgress(dayName: 'Sun', durationMinutes: 485, goalMinutes: 480),
      ],
      insight: AIInsight(
        message: 'Looks like you sleep better on weekends. Try to maintain a consistent bedtime on weekdays.',
        isAvailable: true,
      ),
      recentActivities: [
        RecentActivity(id: '1', date: DateTime.now().subtract(const Duration(days: 1)), durationMinutes: 520, sleepScore: 88, mood: '😎'),
        RecentActivity(id: '2', date: DateTime.now().subtract(const Duration(days: 2)), durationMinutes: 470, sleepScore: 85, mood: '🙂'),
        RecentActivity(id: '3', date: DateTime.now().subtract(const Duration(days: 3)), durationMinutes: 380, sleepScore: 65, mood: '😫'),
      ],
      timeline: [
        SleepTimelineEvent(time: '22:45', description: 'Fell Asleep', emoji: '😴'),
        SleepTimelineEvent(time: '03:15', description: 'Restless', emoji: '🔄'),
        SleepTimelineEvent(time: '06:42', description: 'Wake Up', emoji: '🌅'),
      ],
    );
  }
}
