import '../../../../core/error/failures.dart';
import '../../domain/entities/settings_entity.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsEntity?> getSettings(String userId);
  Future<void> saveSettings(SettingsEntity settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  // Mocked drift database or shared preferences
  SettingsEntity? _cachedSettings;

  @override
  Future<SettingsEntity?> getSettings(String userId) async {
    // Return cached or read from SQLite
    return _cachedSettings ?? SettingsEntity(userId: userId);
  }

  @override
  Future<void> saveSettings(SettingsEntity settings) async {
    _cachedSettings = settings;
    // TODO: Write to Drift DB
  }
}
