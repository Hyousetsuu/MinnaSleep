import 'badge_entity.dart';

class BadgeEngine {
  // Master list of all available badges in the game
  static const List<BadgeEntity> availableBadges = [
    BadgeEntity(
      id: 'streak_7',
      title: '1 Week Warrior',
      description: 'Maintained a 7-day sleep streak.',
      iconAsset: 'assets/badges/streak_7.png',
      requirementValue: 7,
      type: BadgeType.streak,
    ),
    BadgeEntity(
      id: 'early_bird_10',
      title: 'Early Bird',
      description: 'Woke up before 6 AM 10 times.',
      iconAsset: 'assets/badges/early_bird.png',
      requirementValue: 10,
      type: BadgeType.earlyBird,
    ),
  ];

  static List<UserBadgeEntity> evaluateBadges(List<BadgeEntity> allBadges, List<UserBadgeEntity> currentBadges, Map<BadgeType, int> userStats) {
    List<UserBadgeEntity> updatedBadges = List.from(currentBadges);

    for (var badge in allBadges) {
      final userStatValue = userStats[badge.type] ?? 0;
      
      // Find existing badge state
      final existingIndex = updatedBadges.indexWhere((b) => b.badgeId == badge.id);
      UserBadgeEntity badgeState;
      
      if (existingIndex >= 0) {
        badgeState = updatedBadges[existingIndex];
        if (badgeState.unlockedAt != null) continue; // Already unlocked
      } else {
        badgeState = UserBadgeEntity(badgeId: badge.id, currentProgress: 0);
        updatedBadges.add(badgeState);
      }

      // Check rule
      if (userStatValue >= badge.requirementValue) {
        // Unlock
        final index = updatedBadges.indexOf(badgeState);
        updatedBadges[index] = UserBadgeEntity(
          badgeId: badge.id,
          currentProgress: userStatValue,
          unlockedAt: DateTime.now(),
        );
        // TODO: DomainEvent BadgeUnlockedEvent
      } else {
        // Just update progress
        final index = updatedBadges.indexOf(badgeState);
        updatedBadges[index] = UserBadgeEntity(
          badgeId: badge.id,
          currentProgress: userStatValue,
          unlockedAt: null,
        );
      }
    }
    
    return updatedBadges;
  }
}
