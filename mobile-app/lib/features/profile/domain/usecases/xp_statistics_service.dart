import '../entities/xp_entity.dart';

class XpStatisticsService {
  // Handles calculations specifically for XP data (e.g. projecting level ups, leaderboards)

  static int calculateTotalXpGainedThisWeek(List<int> weeklyXpEvents) {
    return weeklyXpEvents.fold(0, (sum, event) => sum + event);
  }

  static int estimateDaysToNextLevel(XpEntity currentXp, int averageDailyXpGained) {
    if (averageDailyXpGained <= 0) return 999;
    return (currentXp.xpRemaining / averageDailyXpGained).ceil();
  }
}
