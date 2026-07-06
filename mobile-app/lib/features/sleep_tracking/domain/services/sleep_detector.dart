import 'motion_service.dart';
import 'screen_service.dart';

class SleepDetector {
  final MotionService _motionService;
  final ScreenService _screenService;
  
  SleepDetector(this._motionService, this._screenService);

  /// Calculates sleep confidence score from 0.0 to 100.0
  double calculateSleepConfidence() {
    double confidence = 0.0;

    // Rule 1: Screen Off (30%)
    if (!_screenService.isScreenOn) {
      confidence += 30.0;
    }

    // Rule 2: No Motion (30%)
    if (!_motionService.isMoving) {
      confidence += 30.0;
    }

    // Rule 3: No Touch (20%) - Implied by screen off and no interaction
    if (!_screenService.isScreenOn && !_motionService.isMoving) {
      confidence += 20.0;
    }

    // Rule 4: Bedtime Window (20%)
    final now = DateTime.now();
    final hour = now.hour;
    // Assuming bedtime is roughly between 21:00 and 04:00
    if (hour >= 21 || hour <= 4) {
      confidence += 20.0;
    }

    return confidence;
  }

  bool isSleeping() {
    return calculateSleepConfidence() >= 80.0;
  }
}
