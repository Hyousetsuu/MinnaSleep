enum NotificationType {
  sleep,
  reminder,
  achievement,
  ai,
  premium,
  syncFailed,
  system,
  community,
}

enum NotificationPriority {
  critical,
  high,
  normal,
  low,
}

enum NotificationStatus {
  generated,
  persisted,
  displayed,
  delivered,
  read,
  archived,
  deleted,
}

enum NotificationChannel {
  local,
  push,
  inbox,
  email,
  sms,
}

enum NotificationAction {
  openSleep,
  openProfile,
  openAchievement,
  openPremium,
  openSettings,
  openCommunity,
  none,
}
