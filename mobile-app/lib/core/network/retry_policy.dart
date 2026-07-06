import 'dart:async';
import '../services/logger_service.dart';

class RetryPolicy {
  // Configured as per Masterplan: 3s, 10s, 30s, 60s, 180s
  static const List<Duration> backoffIntervals = [
    Duration(seconds: 3),
    Duration(seconds: 10),
    Duration(seconds: 30),
    Duration(seconds: 60),
    Duration(seconds: 180),
  ];

  static Future<T> execute<T>(Future<T> Function() operation) async {
    int attempts = 0;
    
    while (attempts < backoffIntervals.length) {
      try {
        return await operation();
      } catch (e) {
        LoggerService.w('RetryPolicy: Operation failed. Attempt ${attempts + 1} of ${backoffIntervals.length}. Error: $e');
        if (attempts == backoffIntervals.length - 1) {
          rethrow; // Final attempt failed
        }
        await Future.delayed(backoffIntervals[attempts]);
        attempts++;
      }
    }
    
    throw Exception('RetryPolicy exhausted without returning.');
  }
}
