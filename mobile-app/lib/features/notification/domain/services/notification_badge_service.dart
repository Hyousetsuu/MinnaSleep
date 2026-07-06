import '../repositories/notification_read_repository.dart';
import '../entities/notification_query.dart';
import '../entities/notification_enums.dart';

class NotificationBadgeCounts {
  final int totalUnread;
  final int criticalCount;
  final int achievementCount;
  final int syncFailedCount;

  const NotificationBadgeCounts({
    this.totalUnread = 0,
    this.criticalCount = 0,
    this.achievementCount = 0,
    this.syncFailedCount = 0,
  });
}

class NotificationBadgeService {
  final NotificationReadRepository _readRepository;

  NotificationBadgeService(this._readRepository);

  Future<NotificationBadgeCounts> getBadgeCounts(String userId) async {
    // In a real optimized system, this would be a single DB aggregate query.
    // For this example, we mock the retrieval.
    
    final unreadResult = await _readRepository.getUnreadCount(userId);
    final totalUnread = unreadResult.value ?? 0;
    
    // Additional domain-specific logic to calculate specific badge counts
    // e.g. await _readRepository.queryNotifications(NotificationQuery(status: unread, type: sleep))
    // This allows Dashboard to simply read `badgeService.getBadgeCounts(userId)`
    
    return NotificationBadgeCounts(
      totalUnread: totalUnread,
      criticalCount: 0, // Mock aggregate result
      achievementCount: 0, // Mock aggregate result
      syncFailedCount: 0, // Mock aggregate result
    );
  }
}
