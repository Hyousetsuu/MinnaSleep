class BadgeEntity {
  final String id;
  final String title;
  final String description;
  final String iconAsset;
  final int requirementValue;
  final BadgeType type;

  const BadgeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.iconAsset,
    required this.requirementValue,
    required this.type,
  });
}

enum BadgeType {
  streak,       // e.g., 7-day streak
  consistency,  // e.g., 5 days in a row sleeping on time
  totalSleep,   // e.g., 100 hours of total sleep
  earlyBird,    // e.g., Waking up before 6 AM 10 times
}

class UserBadgeEntity {
  final String badgeId;
  final int currentProgress;
  final DateTime? unlockedAt;

  const UserBadgeEntity({
    required this.badgeId,
    required this.currentProgress,
    this.unlockedAt,
  });

  bool isUnlocked(BadgeEntity badge) {
    return currentProgress >= badge.requirementValue;
  }
}
