import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthNotifier _authNotifier;

  LoginNotifier(this._authNotifier) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authNotifier.login(email, password);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>((ref) {
  return LoginNotifier(ref.watch(authProvider.notifier));
});
