import 'package:dio/dio.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<Response> register(Map<String, dynamic> data) {
    return _dio.post('/api/auth/register', data: data);
  }

  Future<Response> login(Map<String, dynamic> data) {
    return _dio.post('/api/auth/login', data: data);
  }

  Future<Response> forgotPassword(String email) {
    return _dio.post('/api/auth/forgot-password', data: {'email': email});
  }
}
