class AppException implements Exception {
  final String message;
  final String? code;
  final StackTrace? stackTrace;

  const AppException(this.message, {this.code, this.stackTrace});

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}

class NetworkException extends AppException {
  const NetworkException(String message, {String? code, StackTrace? stackTrace})
      : super(message, code: code, stackTrace: stackTrace);
}

class DatabaseException extends AppException {
  const DatabaseException(String message, {String? code, StackTrace? stackTrace})
      : super(message, code: code, stackTrace: stackTrace);
}

class AuthException extends AppException {
  const AuthException(String message, {String? code, StackTrace? stackTrace})
      : super(message, code: code, stackTrace: stackTrace);
}

class PermissionException extends AppException {
  const PermissionException(String message, {String? code, StackTrace? stackTrace})
      : super(message, code: code, stackTrace: stackTrace);
}
