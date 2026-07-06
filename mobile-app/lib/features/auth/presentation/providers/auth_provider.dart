import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../data/repositories/mock_auth_repository.dart';
import 'auth_state.dart';
import '../../../../core/services/session_manager.dart';

// Provide the repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return MockAuthRepository();
});

// Main AuthNotifier that controls the AuthState
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final SessionManager _sessionManager;

  AuthNotifier(this._authRepository, this._sessionManager) : super(const AuthState.initial());

  Future<void> checkSession() async {
    state = const AuthState.loading();
    await Future.delayed(const Duration(seconds: 2)); // Simulate init
    
    // Check if session exists in SessionManager (which could read from local storage)
    if (_sessionManager.currentUser != null) {
      // Simulate profile check
      // For testing, let's just assume profile is complete if logged in
      state = AuthState.authenticated(userId: _sessionManager.currentUser!);
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      await _authRepository.login(email, password);
      // Simulate getting a token and user id
      _sessionManager.setSession('user-123', 'fake-jwt-token');
      // Assume profile is complete for test user
      state = const AuthState.authenticated(userId: 'user-123');
    } catch (e) {
      state = AuthState.error(message: e.toString());
      // Revert back to unauthenticated so user can try again
      await Future.delayed(const Duration(seconds: 2));
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    await _authRepository.logout();
    _sessionManager.clearSession();
    state = const AuthState.unauthenticated();
  }
  
  // Transition to profile incomplete after registration
  void setProfileIncomplete(String userId) {
    state = AuthState.profileIncomplete(userId: userId);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final sessionManager = ref.watch(sessionManagerProvider);
  return AuthNotifier(authRepository, sessionManager);
});
