import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repositories/auth_repository.dart';
import 'auth_provider.dart';
import '../../../../core/services/session_manager.dart';

class RegisterNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;
  final AuthNotifier _authNotifier;
  final SessionManager _sessionManager;

  RegisterNotifier(this._authRepository, this._authNotifier, this._sessionManager) 
    : super(const AsyncValue.data(null));

  Future<void> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.register(
        fullName: fullName, 
        username: username, 
        email: email, 
        password: password
      );
      // Automatically "login" after registration
      _sessionManager.setSession('new-user-123', 'fake-jwt-token');
      // Tell auth state that we need to complete profile
      _authNotifier.setProfileIncomplete('new-user-123');
      
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, AsyncValue<void>>((ref) {
  return RegisterNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(authProvider.notifier),
    ref.watch(sessionManagerProvider),
  );
});
