import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
// Note: In real app, you would inject the repository via GetIt or Riverpod provider
// final settingsRepositoryProvider = Provider<SettingsRepository>((ref) => GetIt.I<SettingsRepository>());

final settingsProvider = StateNotifierProvider<SettingsNotifier, AsyncValue<SettingsEntity>>((ref) {
  return SettingsNotifier(); // We would pass repository here
});

class SettingsNotifier extends StateNotifier<AsyncValue<SettingsEntity>> {
  SettingsNotifier() : super(const AsyncValue.loading()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    // Simulated load
    await Future.delayed(const Duration(milliseconds: 500));
    state = const AsyncValue.data(SettingsEntity(userId: 'usr_123'));
  }

  Future<void> updateTheme(String theme) async {
    if (state is AsyncData) {
      final current = state.value!;
      state = AsyncValue.data(SettingsEntity(
        userId: current.userId,
        theme: theme,
        language: current.language,
        defaultSleepGoalMinutes: current.defaultSleepGoalMinutes,
        notifySleepReminder: current.notifySleepReminder,
        notifyWeeklyReport: current.notifyWeeklyReport,
        notifyAiInsight: current.notifyAiInsight,
        notifyCommunity: current.notifyCommunity,
        notifyPromotion: current.notifyPromotion,
        notifySystem: current.notifySystem,
        privacyLevel: current.privacyLevel,
      ));
      // await repository.updateTheme(current.userId, theme);
    }
  }

  Future<void> updateLanguage(String language) async {
    // Similar logic to update state locally and via repo
  }

  Future<void> updateSleepGoal(int minutes) async {
    // Similar logic
  }
}
