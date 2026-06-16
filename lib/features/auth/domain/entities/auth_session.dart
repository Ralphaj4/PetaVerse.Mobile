/// An authenticated session: the token pair and the user's identity.
///
/// Domain layer — no Flutter or JSON imports.
class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.roles,
  });

  final String accessToken;
  final String refreshToken;
  final String userId;
  final List<String> roles;
}
