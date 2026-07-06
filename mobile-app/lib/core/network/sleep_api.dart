import 'package:dio/dio.dart';

class SleepApi {
  final Dio _dio;

  SleepApi(this._dio);

  Future<Response> getSleepSessions({int page = 1, int limit = 20}) {
    return _dio.get('/api/sleep', queryParameters: {'page': page, 'limit': limit});
  }

  Future<Response> getDashboardStats() {
    return _dio.get('/api/sleep/stats/dashboard');
  }

  Future<Response> createSleepSession(Map<String, dynamic> data) {
    return _dio.post('/api/sleep', data: data);
  }
}
