import 'logger_service.dart';

enum DevPermissionLevel { basic, advanced, internal }

abstract class DeveloperTools {
  Future<void> generateDummySleepData(); // Basic
  Future<void> resetDatabase(); // Advanced
  Future<void> triggerFakeSyncConflict(); // Internal
  Future<void> clearQueue(); // Internal
  Future<void> injectCrash(); // Internal
  void simulatePremium(bool isActive); // Basic
  Future<void> exportLogs(); // Basic
}

class DeveloperToolsImpl implements DeveloperTools {
  final DevPermissionLevel currentLevel;

  DeveloperToolsImpl({this.currentLevel = DevPermissionLevel.basic});

  void _auditLog(String action, String status) {
    // Simulated insertion to Drift Database for Audit Logs
    LoggerService.i('AUDIT LOG [$status]: $action');
  }

  void _requireLevel(DevPermissionLevel requiredLevel) {
    if (currentLevel.index < requiredLevel.index) {
      throw Exception('Insufficient Developer Permissions. Required: $requiredLevel');
    }
  }

  @override
  Future<void> generateDummySleepData() async {
    _requireLevel(DevPermissionLevel.basic);
    _auditLog('Generate Dummy Sleep Data', 'Success');
  }

  @override
  Future<void> resetDatabase() async {
    _requireLevel(DevPermissionLevel.advanced);
    _auditLog('Reset Database', 'Completed');
  }

  @override
  Future<void> triggerFakeSyncConflict() async {
    _requireLevel(DevPermissionLevel.internal);
    _auditLog('Inject Fake Sync Conflict', 'Success');
  }

  @override
  Future<void> clearQueue() async {
    _requireLevel(DevPermissionLevel.internal);
    _auditLog('Clear Sync Queue', 'Completed');
  }

  @override
  Future<void> injectCrash() async {
    _requireLevel(DevPermissionLevel.internal);
    _auditLog('Inject Crash', 'Executed');
    throw Exception('Simulated Internal Crash');
  }

  @override
  void simulatePremium(bool isActive) {
    _requireLevel(DevPermissionLevel.basic);
    _auditLog('Simulate Premium ($isActive)', 'Success');
  }

  @override
  Future<void> exportLogs() async {
    _requireLevel(DevPermissionLevel.basic);
    _auditLog('Export System Logs to CSV', 'Success');
  }
}
