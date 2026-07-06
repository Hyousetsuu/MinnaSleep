import 'package:flutter_test/flutter_test.dart';
import '../../../../lib/features/notification/domain/repositories/notification_read_repository.dart';
import '../../../../lib/features/notification/domain/entities/notification_query.dart';
import '../../../core/contracts/repository_contract_tester.dart';

class NotificationRepositoryContractTest extends RepositoryContractTester<NotificationReadRepository, String> {
  @override
  NotificationReadRepository createRepository() {
    // Return mocked or real injected repository for testing
    throw UnimplementedError('Provide mock repo');
  }

  @override
  Future performReadAction(NotificationReadRepository repository, String id) {
    return repository.queryNotifications(const NotificationQuery(userId: 'test_user'));
  }

  @override
  Future performWriteAction(NotificationReadRepository repository, entity) {
    // Return write action if applicable (this is read repo, so might need WriteRepo contract test separately)
    throw UnimplementedError();
  }

  @override
  void setupCacheHit(String id) {}

  @override
  void setupCacheMiss(String id) {}

  @override
  void setupLocalFailure(String id) {}

  @override
  void setupLocalSuccess(String id) {}

  @override
  void setupOfflineMode() {}

  @override
  void setupRemoteFailure(String id) {}

  @override
  void setupRemoteSuccess(String id) {}
}

void main() {
  // Execute the universal contract!
  // NotificationRepositoryContractTest().executeContractTests();
}
