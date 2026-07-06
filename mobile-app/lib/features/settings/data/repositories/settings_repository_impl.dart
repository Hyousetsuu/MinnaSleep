import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl(this._localDataSource);

  @override
  Future<Result<SettingsEntity>> getSettings(String userId) async {
    try {
      final settings = await _localDataSource.getSettings(userId);
      if (settings != null) return Success(settings);
      
      // Default fallback
      final defaultSettings = SettingsEntity(userId: userId);
      await _localDataSource.saveSettings(defaultSettings);
      return Success(defaultSettings);
    } catch (e) {
      return Error(DatabaseFailure(message: 'Failed to fetch settings: $e'));
    }
  }

  @override
  Future<Result<void>> updateTheme(String userId, String theme) async {
    return _updateSetting(userId, (s) => SettingsEntity(
      userId: userId,
      theme: theme,
      language: s.language,
      defaultSleepGoalMinutes: s.defaultSleepGoalMinutes,
      notifySleepReminder: s.notifySleepReminder,
      notifyWeeklyReport: s.notifyWeeklyReport,
      notifyAiInsight: s.notifyAiInsight,
      notifyCommunity: s.notifyCommunity,
      notifyPromotion: s.notifyPromotion,
      notifySystem: s.notifySystem,
      privacyLevel: s.privacyLevel,
    ));
  }

  @override
  Future<Result<void>> updateLanguage(String userId, String language) async {
    return _updateSetting(userId, (s) => SettingsEntity(
      userId: userId,
      theme: s.theme,
      language: language,
      defaultSleepGoalMinutes: s.defaultSleepGoalMinutes,
      notifySleepReminder: s.notifySleepReminder,
      notifyWeeklyReport: s.notifyWeeklyReport,
      notifyAiInsight: s.notifyAiInsight,
      notifyCommunity: s.notifyCommunity,
      notifyPromotion: s.notifyPromotion,
      notifySystem: s.notifySystem,
      privacyLevel: s.privacyLevel,
    ));
  }

  @override
  Future<Result<void>> updateNotifications(String userId, Map<String, bool> notifications) async {
    return _updateSetting(userId, (s) => SettingsEntity(
      userId: userId,
      theme: s.theme,
      language: s.language,
      defaultSleepGoalMinutes: s.defaultSleepGoalMinutes,
      notifySleepReminder: notifications['sleepReminder'] ?? s.notifySleepReminder,
      notifyWeeklyReport: notifications['weeklyReport'] ?? s.notifyWeeklyReport,
      notifyAiInsight: notifications['aiInsight'] ?? s.notifyAiInsight,
      notifyCommunity: notifications['community'] ?? s.notifyCommunity,
      notifyPromotion: notifications['promotion'] ?? s.notifyPromotion,
      notifySystem: notifications['system'] ?? s.notifySystem,
      privacyLevel: s.privacyLevel,
    ));
  }

  @override
  Future<Result<void>> updateSleepGoal(String userId, int minutes) async {
    return _updateSetting(userId, (s) => SettingsEntity(
      userId: userId,
      theme: s.theme,
      language: s.language,
      defaultSleepGoalMinutes: minutes,
      notifySleepReminder: s.notifySleepReminder,
      notifyWeeklyReport: s.notifyWeeklyReport,
      notifyAiInsight: s.notifyAiInsight,
      notifyCommunity: s.notifyCommunity,
      notifyPromotion: s.notifyPromotion,
      notifySystem: s.notifySystem,
      privacyLevel: s.privacyLevel,
    ));
  }

  @override
  Future<Result<void>> updatePrivacy(String userId, String privacyLevel) async {
    return _updateSetting(userId, (s) => SettingsEntity(
      userId: userId,
      theme: s.theme,
      language: s.language,
      defaultSleepGoalMinutes: s.defaultSleepGoalMinutes,
      notifySleepReminder: s.notifySleepReminder,
      notifyWeeklyReport: s.notifyWeeklyReport,
      notifyAiInsight: s.notifyAiInsight,
      notifyCommunity: s.notifyCommunity,
      notifyPromotion: s.notifyPromotion,
      notifySystem: s.notifySystem,
      privacyLevel: privacyLevel,
    ));
  }

  Future<Result<void>> _updateSetting(String userId, SettingsEntity Function(SettingsEntity) updater) async {
    try {
      final current = await _localDataSource.getSettings(userId);
      final newSettings = updater(current ?? SettingsEntity(userId: userId));
      await _localDataSource.saveSettings(newSettings);
      return const Success(null);
    } catch (e) {
      return Error(DatabaseFailure(message: 'Failed to update settings: $e'));
    }
  }
}
