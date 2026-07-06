import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/notification_entity.dart';
import '../entities/notification_enums.dart';

class NotificationValidator {
  static Result<void> validate(NotificationEntity entity) {
    if (entity.title.trim().isEmpty) {
      return Error(ValidationFailure(message: 'Title cannot be empty'));
    }
    
    if (entity.body.trim().isEmpty) {
      return Error(ValidationFailure(message: 'Body cannot be empty'));
    }
    
    if (entity.expiresAt != null && entity.expiresAt!.isBefore(entity.createdAt)) {
      return Error(ValidationFailure(message: 'Expiration date must be after creation date'));
    }

    // Action matching rules (e.g. premium notification must have openPremium action)
    if (entity.type == NotificationType.premium && entity.action != NotificationAction.openPremium) {
       return Error(ValidationFailure(message: 'Premium notification must have openPremium action'));
    }

    if (entity.type == NotificationType.sleep && !entity.payload!.containsKey('minutes')) {
       return Error(ValidationFailure(message: 'Sleep notification must contain minutes payload'));
    }

    return const Success(null);
  }
}
