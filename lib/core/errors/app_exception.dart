/// Internal exceptions thrown by data sources and mapped to [Failure]s
/// inside repositories. These must never escape the data layer.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkException extends AppException {
  const NetworkException(super.message);
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message);
}

final class ForbiddenException extends AppException {
  const ForbiddenException(super.message);
}

final class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

final class ValidationException extends AppException {
  const ValidationException(super.message, {this.fieldErrors = const {}});

  final Map<String, String> fieldErrors;
}

final class ServerException extends AppException {
  const ServerException(super.message);
}

/// 429 responses — too many requests. [retryAfter] is the value of the
/// `Retry-After` header (seconds), when the server supplied one.
final class RateLimitException extends AppException {
  const RateLimitException(super.message, {this.retryAfter});

  final Duration? retryAfter;
}

final class CacheException extends AppException {
  const CacheException(super.message);
}
