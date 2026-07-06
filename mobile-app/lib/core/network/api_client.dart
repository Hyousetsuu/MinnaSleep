import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        )) {
    // Interceptors for Auth tokens, Logging, etc.
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // e.g. options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // Handle global errors, token refresh
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
