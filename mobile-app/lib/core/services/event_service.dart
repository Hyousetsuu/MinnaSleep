import 'logger_service.dart';

class EventService {
  static void logEvent(String eventName, {Map<String, dynamic>? parameters}) {
    // Logs analytics events. Later connects to PostHog, Firebase Analytics, Mixpanel, etc.
    LoggerService.i('EVENT: $eventName | Data: $parameters');
  }

  static void login(String userId, String method) {
    logEvent('user_login', parameters: {'method': method, 'user_id': userId});
  }

  static void sleepStarted() {
    logEvent('sleep_started');
  }

  static void sleepFinished(int durationMinutes, int score) {
    logEvent('sleep_finished', parameters: {'duration': durationMinutes, 'score': score});
  }

  static void upgradePremium(String planId) {
    logEvent('upgrade_premium', parameters: {'plan_id': planId});
  }
}
