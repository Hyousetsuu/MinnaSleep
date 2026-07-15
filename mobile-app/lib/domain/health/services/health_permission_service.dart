import '../entities/health_record.dart';

/// The pure Domain Abstraction for Health Permissions.
/// The UI asks for permissions, and the infrastructure layer (Apple/Google) 
/// handles the OS-specific dialogue.
abstract class HealthPermissionService {
  /// Check if the user has granted permission for a specific record type
  Future<bool> hasPermission(Type recordType);

  /// Request permissions for a list of record types
  Future<void> requestPermissions(List<Type> recordTypes);

  /// Revoke permissions (if supported by the platform/provider)
  Future<void> revokePermissions();
}
