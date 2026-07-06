import 'dart:io';
import '../../../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email != 'test@example.com' || password != 'password123') {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'test@example.com') {
      throw Exception('Email already exists');
    }
    if (username == 'admin') {
      throw Exception('Username taken');
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> refreshSession() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email.isEmpty) throw Exception('Email is required');
  }

  @override
  Future<void> verifyEmail(String token) async {
    await Future.delayed(const Duration(seconds: 2));
    if (token != '123456') throw Exception('Invalid token');
  }

  @override
  Future<void> deleteAccount() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<String> uploadAvatar(File image) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'https://example.com/avatar.png'; // Mock URL
  }
}
