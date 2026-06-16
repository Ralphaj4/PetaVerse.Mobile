import 'auth_session.dart';

/// The two shapes a successful (HTTP 200) login can take:
///   • [LoginAuthenticated] — verified user, full token set issued.
///   • [LoginNeedsVerification] — unverified user; the backend resent an
///     OTP and issued no tokens, so the client must route to OTP entry.
sealed class LoginOutcome {
  const LoginOutcome();
}

final class LoginAuthenticated extends LoginOutcome {
  const LoginAuthenticated(this.session);

  final AuthSession session;
}

final class LoginNeedsVerification extends LoginOutcome {
  const LoginNeedsVerification({required this.mobileNumber, this.devOtp});

  final String mobileNumber;

  /// OTP echoed back by the Development backend only — for local testing.
  final String? devOtp;
}
