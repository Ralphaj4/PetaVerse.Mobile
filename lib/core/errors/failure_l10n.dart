import 'package:intl/intl.dart';

import '../localization/generated/app_localizations.dart';
import 'failure.dart';

/// Maps a [Failure] to a user-facing message.
///
/// The backend's message (e.g. "Invalid mobile number or password.") is more
/// specific and actionable than a generic string, so it is preferred for every
/// failure type when present. The localized generic string is the fallback for
/// cases with no server message - chiefly true transport failures (offline,
/// timeout) whose [NetworkFailure] carries only a technical Dio message, and
/// local [CacheFailure]s, both of which fall back to their localized text.
extension FailureL10n on Failure {
  String localizedMessage(AppLocalizations l10n) => switch (this) {
        // Transport/local failures have no meaningful server message - always
        // use the localized generic string.
        NetworkFailure() => l10n.errorNetwork,
        CacheFailure() => l10n.errorCache,
        // Server-originated failures: prefer the API message, fall back to the
        // localized generic string when the body carried none.
        ForbiddenFailure(:final message) =>
          _detail(message) ?? l10n.errorForbidden,
        NotFoundFailure(:final message) =>
          _detail(message) ?? l10n.errorNotFound,
        ServerFailure(:final message) => _detail(message) ?? l10n.errorServer,
        RateLimitFailure(:final message, :final retryAfter) =>
          _detail(message) ??
              (retryAfter != null
                  ? l10n.errorRateLimitRetry(retryAfter.inSeconds)
                  : l10n.errorRateLimit),
        UnauthorizedFailure(:final message) =>
          _detail(message) ?? l10n.errorUnauthorized,
        SuspendedFailure(:final suspendedUntil) => suspendedUntil != null
            ? l10n.errorSuspended(_formatLocal(suspendedUntil))
            : l10n.errorUnauthorized,
        BannedFailure() => l10n.errorBanned,
        ValidationFailure(:final message) =>
          _detail(message) ?? l10n.errorValidation,
        ConflictFailure(:final message) =>
          _detail(message) ?? l10n.errorUnknown,
        UnknownFailure(:final message) =>
          _detail(message) ?? l10n.errorUnknown,
      };

  String? _detail(String? message) =>
      (message != null && message.trim().isNotEmpty) ? message : null;

  /// Converts a UTC [DateTime] to the device's local timezone and formats it
  /// as "Sep 10, 2026 at 4:00 PM" (locale-neutral medium date + short time).
  String _formatLocal(DateTime utc) {
    final local = utc.toLocal();
    return DateFormat.yMMMd().add_jm().format(local);
  }
}
