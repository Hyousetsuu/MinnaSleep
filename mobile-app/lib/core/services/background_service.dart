import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'sleep_detector.dart';
import 'notification_service.dart';

class SleepBackgroundService {
  final FlutterBackgroundService _service = FlutterBackgroundService();
  
  Future<void> initialize() async {
    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: 'sleep_tracking_channel',
        initialNotificationTitle: 'Minna Sleep',
        initialNotificationContent: 'Monitoring your sleep...',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
      ),
    );
  }

  Future<void> startService() async {
    await _service.startService();
  }

  void stopService() {
    _service.invoke('stopService');
  }
}

// Entry point for background execution
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // In the background isolate
  
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Example: Periodically check sleep confidence
  Timer.periodic(const Duration(minutes: 5), (timer) async {
    // 1. Fetch sensor data (Motion, Screen, etc.)
    // 2. Calculate SleepConfidence
    // 3. If confidence > 80% and status is awake -> Trigger auto detect sleep
    // 4. Update Drift Database with new datapoints
    
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Minna Sleep is Active",
        content: "Tracking in progress... ${DateTime.now().toIso8601String()}",
      );
    }
  });
}
