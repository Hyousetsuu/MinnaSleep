import 'failures.dart';

abstract class Result<T> {
  const Result();

  // Pattern matching equivalent for Dart
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
    required R Function() loading,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is Error<T>) {
      return failure((this as Error<T>).failure);
    } else if (this is Loading<T>) {
      return loading();
    }
    throw Exception('Unhandled Result state');
  }

  // Convenience getters
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Error<T>;
  bool get isLoading => this is Loading<T>;

  T? get dataOrNull => isSuccess ? (this as Success<T>).data : null;
  Failure? get failureOrNull => isFailure ? (this as Error<T>).failure : null;
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}

class Loading<T> extends Result<T> {
  const Loading();
}
