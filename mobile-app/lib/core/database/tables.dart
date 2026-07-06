import 'package:drift/drift.dart';

// Sleep Sessions Table
class SleepSessions extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get userId => text().nullable()(); // Can be null if guest, but mostly uuid
  DateTimeColumn get bedtime => dateTime()();
  DateTimeColumn get wakeTime => dateTime().nullable()(); // null if still sleeping
  IntColumn get durationMinutes => integer().nullable()();
  IntColumn get sleepScore => integer().nullable()();
  TextColumn get mood => text().nullable()(); // emoji string
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('completed'))(); // 'active', 'completed', 'deleted'
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Settings Table
class Settings extends Table {
  TextColumn get id => text()(); // typically 'default'
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get sleepGoalMinutes => integer().withDefault(const Constant(480))(); // 8 hours
  TextColumn get bedtimeGoal => text().withDefault(const Constant('22:00'))();
  TextColumn get wakeupGoal => text().withDefault(const Constant('06:00'))();
  TextColumn get theme => text().withDefault(const Constant('dark'))(); // Neo brutalism default is dark
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Sync Queue Table
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()(); // 'sleep_session', 'settings', 'profile'
  TextColumn get entityId => text()(); // UUID of the entity
  TextColumn get operation => text()(); // 'INSERT', 'UPDATE', 'DELETE'
  TextColumn get payload => text()(); // JSON string representation
  TextColumn get status => text().withDefault(const Constant('pending'))(); // 'pending', 'processing', 'failed'
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Optional: Sensor Data Log (If we want to record motion/light data for AI analysis later)
class SensorLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text().references(SleepSessions, #id)();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  TextColumn get eventType => text()(); // 'screen_off', 'motion', 'light'
  RealColumn get value => real().nullable()();
}
