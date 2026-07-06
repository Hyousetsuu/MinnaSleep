class NotificationPreferenceEntity {
  final String userId;
  final bool sleepEnabled;
  final bool achievementsEnabled;
  final bool aiInsightsEnabled;
  final bool promotionsEnabled;
  final DateTime updatedAt;

  const NotificationPreferenceEntity({
    required this.userId,
    this.sleepEnabled = true,
    this.achievementsEnabled = true,
    this.aiInsightsEnabled = true,
    this.promotionsEnabled = false,
    required this.updatedAt,
  });
}
