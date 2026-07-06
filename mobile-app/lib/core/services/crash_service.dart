import 'logger_service.dart';

class CrashService {
  static void recordError(dynamic exception, StackTrace? stack, {dynamic reason}) {
    // Currently redirects to Logger. Later integrates with Firebase Crashlytics / Sentry
    LoggerService.e('CRASH/ERROR RECORDED: $reason', error: exception, stackTrace: stack);
  }

  static void recordFlutterFatalError(dynamic details) {
    LoggerService.c('FATAL FLUTTER ERROR', error: details);
  }

  static void setUserId(String identifier) {
    LoggerService.i('CrashService: Bound to user $identifier');
  }
}
