import '../errors/app_exception.dart';

sealed class Result<T> {
  const Result();
  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(AppException error) = Failure<T>;
  Result<R> map<R>(R Function(T) f) => switch (this) {
    Success(:final value) => Result.success(f(value)),
    Failure(:final error) => Result.failure(error),
  };
  AppException? exceptionOrNull() => switch (this) {
    Success() => null,
    Failure(:final error) => error,
  };
  bool get isSuccess => this is Success<T>;
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
  @override
  bool operator ==(Object other) => other is Success<T> && other.value == value;
  @override
  int get hashCode => value.hashCode;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);
  final AppException error;
}
