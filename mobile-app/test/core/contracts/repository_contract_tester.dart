import 'package:flutter_test/flutter_test.dart';

/// A Contract Tester that all Repositories in Minna Sleep must pass.
/// Enforces Cache, Local DB, Remote DB, and Offline behavior consistency.
abstract class RepositoryContractTester<T, IdType> {
  // Test dependencies to be provided by the specific repository test
  T createRepository();
  void setupCacheHit(IdType id);
  void setupCacheMiss(IdType id);
  void setupLocalSuccess(IdType id);
  void setupLocalFailure(IdType id);
  void setupRemoteSuccess(IdType id);
  void setupRemoteFailure(IdType id);
  void setupOfflineMode();

  // The actual action to test (e.g. repo.getById(id))
  Future<dynamic> performReadAction(T repository, IdType id);
  Future<dynamic> performWriteAction(T repository, dynamic entity);

  void executeContractTests() {
    group('Repository Contract Tests', () {
      late T repository;

      setUp(() {
        repository = createRepository();
      });

      test('Given cache hit, When reading, Then returns from cache and ignores Local/Remote', () async {
        // ... Generic test logic ...
      });

      test('Given cache miss, When reading, Then reads from Local DB', () async {
        // ... Generic test logic ...
      });

      test('Given offline mode, When writing, Then saves to Local and adds to Sync Queue', () async {
        // ... Generic test logic ...
      });

      test('Given local failure, When reading, Then returns Failure.database()', () async {
        // ... Generic test logic ...
      });

      // Add all 12 contract cases here...
    });
  }
}
