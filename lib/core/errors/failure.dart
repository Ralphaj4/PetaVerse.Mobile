/// Domain-level failure types returned by repositories.
///
/// UI layers must never receive raw exceptions; every error is mapped to
/// one of these sealed variants so screens can render localized messages.
sealed class Failure {
  const Failure({this.message});

  /// Optional technical detail. Never shown to the user directly;
  /// presentation maps the failure type to a localized string.
  final String? message;
}

/// Connectivity problems: timeouts, no internet, DNS failures.
final class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}

/// 401 responses — session expired or invalid credentials.
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message});
}

/// 403 responses — authenticated but not allowed.
final class ForbiddenFailure extends Failure {
  const ForbiddenFailure({super.message});
}

/// 404 responses — the requested resource does not exist.
final class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});
}

/// 422/400 responses or client-side validation problems.
final class ValidationFailure extends Failure {
  const ValidationFailure({super.message, this.fieldErrors = const {}});

  /// Per-field server validation messages keyed by field name.
  final Map<String, String> fieldErrors;
}

/// 5xx responses.
final class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

/// Local cache read/write problems.
final class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

/// Anything that does not fit the other categories.
final class UnknownFailure extends Failure {
  const UnknownFailure({super.message});
}
