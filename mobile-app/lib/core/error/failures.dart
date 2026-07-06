import 'package:flutter/foundation.dart';

abstract class Failure {
  final String code;
  final String message;
  final StackTrace? stackTrace;
  final bool retryable;
  final Map<String, dynamic>? metadata;

  const Failure({
    required this.code,
    required this.message,
    this.stackTrace,
    this.retryable = false,
    this.metadata,
  });

  @override
  String toString() {
    return 'Failure(code: $code, message: $message, retryable: $retryable)';
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    String code = 'NET_001',
    String message = 'Network connection failed.',
    StackTrace? stackTrace,
    bool retryable = true,
    Map<String, dynamic>? metadata,
  }) : super(
          code: code,
          message: message,
          stackTrace: stackTrace,
          retryable: retryable,
          metadata: metadata,
        );
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    String code = 'DB_001',
    String message = 'Local database error occurred.',
    StackTrace? stackTrace,
    bool retryable = false,
    Map<String, dynamic>? metadata,
  }) : super(
          code: code,
          message: message,
          stackTrace: stackTrace,
          retryable: retryable,
          metadata: metadata,
        );
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    String code = 'VAL_001',
    String message = 'Data validation failed.',
    StackTrace? stackTrace,
    bool retryable = false,
    Map<String, dynamic>? metadata,
  }) : super(
          code: code,
          message: message,
          stackTrace: stackTrace,
          retryable: retryable,
          metadata: metadata,
        );
}

class PermissionFailure extends Failure {
  const PermissionFailure({
    String code = 'PERM_001',
    String message = 'Required permissions are missing.',
    StackTrace? stackTrace,
    bool retryable = false,
    Map<String, dynamic>? metadata,
  }) : super(
          code: code,
          message: message,
          stackTrace: stackTrace,
          retryable: retryable,
          metadata: metadata,
        );
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    String code = 'UNK_001',
    String message = 'An unexpected error occurred.',
    StackTrace? stackTrace,
    bool retryable = false,
    Map<String, dynamic>? metadata,
  }) : super(
          code: code,
          message: message,
          stackTrace: stackTrace,
          retryable: retryable,
          metadata: metadata,
        );
}
