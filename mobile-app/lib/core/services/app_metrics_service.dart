import 'dart:async';

class AppMetricsService {
  // Metrics tracked in memory for dev panel visibility
  
  static double coldStartMs = 0;
  static double warmStartMs = 0;
  static double averageQueryTimeMs = 0;
  static double currentMemoryUsageMb = 0;
  static double currentFps = 60.0;

  static void recordColdStart(Stopwatch stopwatch) {
    stopwatch.stop();
    coldStartMs = stopwatch.elapsedMilliseconds.toDouble();
  }

  static void recordWarmStart(Stopwatch stopwatch) {
    stopwatch.stop();
    warmStartMs = stopwatch.elapsedMilliseconds.toDouble();
  }

  static void recordQueryExecution(double elapsedMs) {
    // Simple moving average
    if (averageQueryTimeMs == 0) {
      averageQueryTimeMs = elapsedMs;
    } else {
      averageQueryTimeMs = (averageQueryTimeMs * 0.9) + (elapsedMs * 0.1);
    }
  }

  // Polling methods would go here to update memory and FPS periodically
}
