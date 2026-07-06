import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'sleep_tracking_channel',
      'Sleep Tracking',
      channelDescription: 'Notifications for sleep tracking',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
        
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  // Preset Notifications based on user request
  Future<void> showBedtimeReminder() async {
    await showNotification(id: 1, title: 'Bedtime Reminder 🌙', body: 'It is time to wind down and get ready for sleep.');
  }

  Future<void> showSleepStarted() async {
    await showNotification(id: 2, title: 'Sleep Session Started 😴', body: 'We are tracking your sleep. Have a good night!');
  }

  Future<void> showWakeUp() async {
    await showNotification(id: 3, title: 'Good Morning! 🌅', body: 'Time to wake up and start your day.');
  }

  Future<void> showSleepSummary(int score, String duration) async {
    await showNotification(id: 4, title: 'Sleep Summary 📊', body: 'You slept for $duration. Your score is $score.');
  }
}
