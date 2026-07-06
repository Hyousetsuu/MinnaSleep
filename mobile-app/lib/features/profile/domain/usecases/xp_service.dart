import '../entities/xp_entity.dart';
import '../../../../core/services/logger_service.dart';

class XpService {
  // Domain Event Listeners usually call this service.
  
  static XpEntity grantXp(XpEntity currentXp, XpGainReason reason) {
    int amount = 0;
    switch (reason) {
      case XpGainReason.sleepRecorded:
        amount = 20;
        break;
      case XpGainReason.sevenDayStreak:
        amount = 100;
        break;
      case XpGainReason.completeProfile:
        amount = 50;
        break;
      case XpGainReason.shareReport:
        amount = 10;
        break;
    }

    final newTotal = currentXp.currentXp + amount;
    LoggerService.i('XP Granted: +$amount for ${reason.name}. Total: $newTotal');
    
    // Check if level up occurred (logic can emit a LevelUpEvent)
    final newXpEntity = XpEntity(currentXp: newTotal);
    if (newXpEntity.level > currentXp.level) {
      LoggerService.i('Level Up! Now Level ${newXpEntity.level}');
      // TODO: Emit LevelUpEvent
    }

    return newXpEntity;
  }
}

enum XpGainReason {
  sleepRecorded,
  sevenDayStreak,
  completeProfile,
  shareReport,
}
