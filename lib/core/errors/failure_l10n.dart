import '../localization/generated/app_localizations.dart';
import 'failure.dart';

/// Maps a [Failure] to a user-facing message.
///
/// For most failure types the localized generic string is used. For
/// validation and unauthorized errors the backend's `detail` (e.g.
/// "Invalid mobile number or password.") is more specific and actionable,
/// so it is preferred when present, with the localized string as fallback.
extension FailureL10n on Failure {
  String localizedMessage(AppLocalizations l10n) => switch (this) {
        NetworkFailure() => l10n.errorNetwork,
        ForbiddenFailure() => l10n.errorForbidden,
        NotFoundFailure(:final message) => _detail(message) ?? l10n.errorNotFound,
        ServerFailure() => l10n.errorServer,
        CacheFailure() => l10n.errorCache,
        UnauthorizedFailure(:final message) =>
          _detail(message) ?? l10n.errorUnauthorized,
        ValidationFailure(:final message) =>
          _detail(message) ?? l10n.errorValidation,
        UnknownFailure() => l10n.errorUnknown,
      };

  String? _detail(String? message) =>
      (message != null && message.trim().isNotEmpty) ? message : null;
}
