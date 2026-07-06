import 'package:get_it/get_it.dart';
import '../config/app_config.dart';
// import '../services/notification_service.dart';
// import '../services/background_service.dart';
// import '../services/sleep_detector.dart';

final GetIt locator = GetIt.instance;

Future<void> setupDependencies(AppConfig config) async {
  // Config
  locator.registerSingleton<AppConfig>(config);

  // Core Services
  // locator.registerLazySingleton(() => LocalNotificationService());
  // locator.registerLazySingleton(() => SleepBackgroundService());
  // locator.registerLazySingleton(() => MotionService());
  // locator.registerLazySingleton(() => ScreenService());
  // locator.registerLazySingleton(() => SleepDetector(locator(), locator()));

  // Local Database
  // locator.registerSingleton(() => AppDatabase());
  
  // Repositories
  // locator.registerLazySingleton<DashboardRepository>(() => MockDashboardRepository());
}
