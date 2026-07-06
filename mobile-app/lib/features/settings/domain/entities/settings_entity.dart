class SettingsEntity {
  final String userId;
  final AppearanceSettings appearance;
  final NotificationSettings notifications;
  final PrivacySettings privacy;
  final SleepConfigSettings sleepConfig;

  const SettingsEntity({
    required this.userId,
    this.appearance = const AppearanceSettings(),
    this.notifications = const NotificationSettings(),
    this.privacy = const PrivacySettings(),
    this.sleepConfig = const SleepConfigSettings(),
  });
}

class AppearanceSettings {
  final String theme; // 'light', 'dark', 'system'
  final String language; // 'en', 'id'
  const AppearanceSettings({this.theme = 'system', this.language = 'en'});
}

class NotificationSettings {
  final bool sleepReminder;
  final bool weeklyReport;
  final bool aiInsight;
  final bool community;
  final bool system;
  const NotificationSettings({
    this.sleepReminder = true,
    this.weeklyReport = true,
    this.aiInsight = true,
    this.community = true,
    this.system = true,
  });
}

class PrivacySettings {
  final String privacyLevel; // 'public', 'friends', 'private'
  const PrivacySettings({this.privacyLevel = 'public'});
}

class SleepConfigSettings {
  final int defaultSleepGoalMinutes;
  const SleepConfigSettings({this.defaultSleepGoalMinutes = 480});
}

