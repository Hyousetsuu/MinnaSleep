import '../../../../core/error/result.dart';
import '../entities/notification_preference_entity.dart';

abstract class NotificationPreferenceRepository {
  Future<Result<NotificationPreferenceEntity>> getPreferences(String userId);
  Future<Result<void>> updatePreferences(NotificationPreferenceEntity prefs);
}
