import 'package:flutter/material.dart';
import 'logger_service.dart';

class AppLifecycleService with WidgetsBindingObserver {
  AppLifecycleService._privateConstructor();
  static final AppLifecycleService instance = AppLifecycleService._privateConstructor();

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        LoggerService.i('App Resumed - Foreground');
        // Resume background sync, refresh data if needed
        break;
      case AppLifecycleState.inactive:
        LoggerService.i('App Inactive');
        break;
      case AppLifecycleState.paused:
        LoggerService.i('App Paused - Background');
        // Save state, rely on background worker for sleep tracking
        break;
      case AppLifecycleState.detached:
        LoggerService.i('App Detached - Killed');
        // Clean up resources if possible
        break;
      case AppLifecycleState.hidden:
        LoggerService.i('App Hidden');
        break;
    }
  }
}
