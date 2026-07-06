import 'version_checker.dart';
import '../constants/app_constants.dart';
import '../error/result.dart';
import '../services/logger_service.dart';

class UpdateService {
  Future<Result<UpdateStatus>> checkUpdate() async {
    try {
      // Mock fetching from backend
      // GET /version
      const latestVersion = '0.2.0';
      const minRequiredVersion = '0.1.0';

      final needsForceUpdate = VersionChecker.isUpdateRequired(AppConstants.appVersion, minRequiredVersion);
      final updateAvailable = VersionChecker.compare(AppConstants.appVersion, latestVersion) < 0;

      if (needsForceUpdate) {
        return const Success(UpdateStatus.forceUpdate);
      } else if (updateAvailable) {
        return const Success(UpdateStatus.optionalUpdate);
      }
      
      return const Success(UpdateStatus.upToDate);
    } catch (e) {
      LoggerService.e('Failed to check for updates: $e');
      return const Success(UpdateStatus.unknown);
    }
  }
}

enum UpdateStatus {
  upToDate,
  optionalUpdate,
  forceUpdate,
  unknown
}
