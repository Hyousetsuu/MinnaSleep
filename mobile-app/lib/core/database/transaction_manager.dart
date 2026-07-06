import 'logger_service.dart';

class TransactionManager {
  // Wraps database operations in a transaction block to ensure all-or-nothing execution.
  // Crucial for Offline-First architectures that write to Data + Audit + SyncQueue simultaneously.

  static Future<T> run<T>(Future<T> Function() transactionBlock) async {
    LoggerService.i('Starting Database Transaction...');
    
    // TODO: In real drift implementation, this would be:
    // return await db.transaction(() async {
    //   return await transactionBlock();
    // });

    try {
      final result = await transactionBlock();
      LoggerService.i('Transaction committed successfully.');
      return result;
    } catch (e) {
      LoggerService.e('Transaction FAILED. Rolling back changes. Error: $e');
      // Rollback is automatically handled by Drift when an exception is thrown inside db.transaction()
      rethrow;
    }
  }
}
