import 'failure.dart';

/// Functional result type returned by every repository method.
///
/// Forces callers to handle both outcomes explicitly — exceptions never
/// cross the repository boundary.
sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(Failure failure) = FailureResult<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  /// Value if success, otherwise null.
  T? get valueOrNull => switch (this) {
        Success<T>(:final value) => value,
        FailureResult<T>() => null,
      };

  /// Failure if failed, otherwise null.
  Failure? get failureOrNull => switch (this) {
        Success<T>() => null,
        FailureResult<T>(:final failure) => failure,
      };

  /// Exhaustive fold over both outcomes.
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) =>
      switch (this) {
        Success<T>(:final value) => success(value),
        FailureResult<T>(failure: final f) => failure(f),
      };

  /// Transforms the success value, propagating failures untouched.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
        Success<T>(:final value) => Result.success(transform(value)),
        FailureResult<T>(:final failure) => Result.failure(failure),
      };
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final Failure failure;
}
