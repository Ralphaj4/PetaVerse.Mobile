import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:petaverse_mobile/core/utils/jwt_utils.dart';

/// Builds a minimal JWT (header.payload.signature) whose payload carries the
/// given claims. The signature is a placeholder — [JwtUtils] never verifies it.
String _jwt(Map<String, dynamic> payload) {
  String seg(Map<String, dynamic> m) =>
      base64Url.encode(utf8.encode(jsonEncode(m))).replaceAll('=', '');
  return '${seg({'alg': 'HS256', 'typ': 'JWT'})}.${seg(payload)}.sig';
}

void main() {
  group('JwtUtils.expiryOf', () {
    test('reads the exp claim as UTC seconds-since-epoch', () {
      final token = _jwt({'exp': 1700000000});
      expect(
        JwtUtils.expiryOf(token),
        DateTime.fromMillisecondsSinceEpoch(1700000000 * 1000, isUtc: true),
      );
    });

    test('returns null for a malformed (non-3-part) token', () {
      expect(JwtUtils.expiryOf('not-a-jwt'), isNull);
      expect(JwtUtils.expiryOf('a.b'), isNull);
    });

    test('returns null when exp is missing or not an int', () {
      expect(JwtUtils.expiryOf(_jwt({'sub': '1'})), isNull);
      expect(JwtUtils.expiryOf(_jwt({'exp': 'soon'})), isNull);
    });

    test('returns null for a non-decodable payload', () {
      expect(JwtUtils.expiryOf('header.!!!not-base64!!!.sig'), isNull);
    });
  });

  group('JwtUtils.isExpired', () {
    final now = DateTime.utc(2024, 1, 1, 12, 0, 0);
    int epoch(DateTime d) => d.millisecondsSinceEpoch ~/ 1000;

    test('true when exp is in the past', () {
      final token = _jwt({'exp': epoch(now.subtract(const Duration(hours: 1)))});
      expect(JwtUtils.isExpired(token, now: now), isTrue);
    });

    test('false when exp is comfortably in the future', () {
      final token = _jwt({'exp': epoch(now.add(const Duration(hours: 1)))});
      expect(JwtUtils.isExpired(token, now: now), isFalse);
    });

    test('leeway treats an about-to-expire token as already expired', () {
      final token = _jwt({'exp': epoch(now.add(const Duration(seconds: 10)))});
      expect(
        JwtUtils.isExpired(token, now: now, leeway: const Duration(seconds: 30)),
        isTrue,
      );
    });

    test('false (not expired) when expiry cannot be determined', () {
      // Unparseable → we must not force a logout on a possibly-valid token.
      expect(JwtUtils.isExpired('garbage', now: now), isFalse);
      expect(JwtUtils.isExpired(_jwt({'sub': 'x'}), now: now), isFalse);
    });
  });
}
