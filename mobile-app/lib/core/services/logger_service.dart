import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error, critical }

class LoggerService {
  static void log(String message, {LogLevel level = LogLevel.info, Object? error, StackTrace? stackTrace}) {
    // Only log in debug mode or if it's a critical error
    if (!kDebugMode && level != LogLevel.critical && level != LogLevel.error) return;

    final String prefix = _getPrefix(level);
    developer.log(
      '$prefix $message',
      time: DateTime.now(),
      level: level.index,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void d(String message) => log(message, level: LogLevel.debug);
  static void i(String message) => log(message, level: LogLevel.info);
  static void w(String message) => log(message, level: LogLevel.warning);
  static void e(String message, {Object? error, StackTrace? stackTrace}) => 
      log(message, level: LogLevel.error, error: error, stackTrace: stackTrace);
  static void c(String message, {Object? error, StackTrace? stackTrace}) => 
      log(message, level: LogLevel.critical, error: error, stackTrace: stackTrace);

  static String _getPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug: return '🐞 [DEBUG]';
      case LogLevel.info: return 'ℹ️ [INFO]';
      case LogLevel.warning: return '⚠️ [WARNING]';
      case LogLevel.error: return '❌ [ERROR]';
      case LogLevel.critical: return '🔥 [CRITICAL]';
    }
  }
}
