import 'package:dio/dio.dart';

class ProfileApi {
  final Dio _dio;

  ProfileApi(this._dio);

  Future<Response> getProfile() {
    return _dio.get('/api/profiles/me');
  }

  Future<Response> setupProfile(Map<String, dynamic> data) {
    return _dio.post('/api/profiles/setup', data: data);
  }

  Future<Response> updateProfile(Map<String, dynamic> data) {
    return _dio.put('/api/profiles/me', data: data);
  }
}
