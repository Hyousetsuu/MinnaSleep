import '../../../../core/error/result.dart';
import '../entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<Result<SettingsEntity>> getSettings(String userId);
  Future<Result<void>> updateTheme(String userId, String theme);
  Future<Result<void>> updateLanguage(String userId, String language);
  Future<Result<void>> updateNotifications(String userId, Map<String, bool> notifications);
  Future<Result<void>> updateSleepGoal(String userId, int minutes);
  Future<Result<void>> updatePrivacy(String userId, String privacyLevel);
}
