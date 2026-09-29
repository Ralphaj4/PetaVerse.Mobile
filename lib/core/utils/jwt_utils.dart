import 'dart:convert';

/// Minimal, dependency-free JWT helpers.
///
/// We only ever need to read the standard `exp` claim to decide whether a
/// stored access token is still usable, so a full JWT library would be
/// overkill. This does NOT verify the signature — verification is the
/// backend's job; the client only reads the expiry to avoid firing a request
/// it already knows will 401.
abstract final class JwtUtils {
  /// Returns the token's expiry, or null if the token is malformed or has no
  /// `exp` claim. A null result means "we can't tell" — callers should treat
  /// that conservatively (assume it may still be valid) rather than force a
  /// logout on an unparseable-but-possibly-fine token.
  static DateTime? expiryOf(String token) {
    final payload = _decodePayload(token);
    final exp = payload?['exp'];
    if (exp is! int) return null;
    // `exp` is seconds since epoch (RFC 7519), UTC.
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
  }

  /// Whether [token] is expired at [now] (defaults to current UTC time),
  /// applying [leeway] so a token that expires in the next few seconds is
  /// treated as already expired — this pre-empts the race where a request
  /// leaves with a token that dies in transit. Returns false when the expiry
  /// can't be determined (see [expiryOf]).
  static bool isExpired(
    String token, {
    DateTime? now,
    Duration leeway = const Duration(seconds: 30),
  }) {
    final expiry = expiryOf(token);
    if (expiry == null) return false;
    final reference = (now ?? DateTime.now().toUtc()).add(leeway);
    return !expiry.isAfter(reference);
  }

  static Map<String, dynamic>? _decodePayload(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return null;
    try {
      final normalized = base64Url.normalize(parts[1]);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final json = jsonDecode(decoded);
      return json is Map<String, dynamic> ? json : null;
    } catch (_) {
      return null;
    }
  }
}
