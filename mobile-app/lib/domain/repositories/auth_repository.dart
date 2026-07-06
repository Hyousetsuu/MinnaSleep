import 'dart:io';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<void> refreshSession();
  Future<void> forgotPassword(String email);
  Future<void> verifyEmail(String token);
  Future<void> deleteAccount();
  Future<String> uploadAvatar(File image);
}
