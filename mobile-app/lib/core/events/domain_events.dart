abstract class DomainEvent {
  final DateTime timestamp;
  DomainEvent() : timestamp = DateTime.now();
}

class SleepCompletedEvent extends DomainEvent {
  final String sleepSessionId;
  final int totalMinutes;
  SleepCompletedEvent(this.sleepSessionId, this.totalMinutes);
}

class BadgeUnlockedEvent extends DomainEvent {
  final String badgeId;
  final String badgeName;
  BadgeUnlockedEvent(this.badgeId, this.badgeName);
}

class ProfileUpdatedEvent extends DomainEvent {
  final String userId;
  ProfileUpdatedEvent(this.userId);
}

class PremiumActivatedEvent extends DomainEvent {
  final String userId;
  PremiumActivatedEvent(this.userId);
}

class SyncFailedEvent extends DomainEvent {
  final String reason;
  SyncFailedEvent(this.reason);
}

// Registry or Hub for listening to these events could be implemented here or via Riverpod
