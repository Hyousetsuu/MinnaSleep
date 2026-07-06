class NotificationCursor {
  final String? lastId;
  final DateTime? lastCreatedAt;
  final int limit;

  const NotificationCursor({
    this.lastId,
    this.lastCreatedAt,
    this.limit = 20,
  });

  bool get isFirstPage => lastId == null && lastCreatedAt == null;
}
