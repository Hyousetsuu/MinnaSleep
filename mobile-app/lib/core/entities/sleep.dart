class SleepSessionEntity {
  final String id;
  final String? userId;
  final DateTime bedtime;
  final DateTime? wakeTime;
  final int? durationMinutes;
  final int? sleepScore;
  final String? mood;
  final String? notes;
  final String status; // active, completed, deleted
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version; // for conflict resolution

  SleepSessionEntity({
    required this.id,
    this.userId,
    required this.bedtime,
    this.wakeTime,
    this.durationMinutes,
    this.sleepScore,
    this.mood,
    this.notes,
    this.status = 'completed',
    this.isSynced = false,
    required this.createdAt,
    required this.updatedAt,
    this.version = 1,
  });
}
