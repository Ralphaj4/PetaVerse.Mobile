import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../utils/logger_service.dart';
import 'router/app_router.dart';

/// Handles inbound Universal Links (iOS) / App Links (Android) — the https
/// links produced by the PawHub "Share" action. When the OS hands the app a
/// verified `https://<host>/p/<id>` link (installed-app path), this maps it to
/// the in-app post route so the app opens directly on the post.
///
/// Links that don't match a known pattern are ignored — the OS only routes a
/// link here when the domain association verifies, so a stray link is a no-op
/// rather than an error.
///
/// Wired from [AppShell.initState] (same place as FCM tap handling) so the
/// router and auth gates are ready. The router's redirect still applies: an
/// unauthenticated user tapping a link lands on login, then the app resumes.
class DeepLinkHandler {
  DeepLinkHandler._();

  static const _tag = 'DeepLink';
  static const _logger = LoggerService();

  static final AppLinks _appLinks = AppLinks();
  static StreamSubscription<Uri>? _sub;

  /// Call once, after the widget tree is ready. Handles both the cold-start
  /// link ([AppLinks.getInitialLink]) and warm links while running
  /// ([AppLinks.uriLinkStream]).
  static Future<void> init(GoRouter router) async {
    // Warm links (app already running / backgrounded).
    _sub ??= _appLinks.uriLinkStream.listen(
      (uri) => _handle(router, uri),
      onError: (Object e) => _logger.error('Link stream error', error: e),
    );

    // Cold-start link (app launched by tapping the link).
    try {
      final initial = await _appLinks.getInitialLink();
      if (initial != null) _handle(router, initial);
    } catch (e, st) {
      _logger.error('getInitialLink failed', error: e, stackTrace: st);
    }
  }

  /// Stop listening. Call from [AppShell.dispose].
  static Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
  }

  static void _handle(GoRouter router, Uri uri) {
    _logger.info('Inbound link: $uri', tag: _tag);
    final route = _routeFor(uri);
    if (route == null) {
      _logger.info('No route matched for $uri — ignoring', tag: _tag);
      return;
    }
    // Route after the current frame: init() runs from AppShell.initState while
    // the Navigator is still building its first frame; routing synchronously
    // re-enters before its key reservation settles (same guard as FCM taps).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // The post route lives inside the community shell branch, so go() (not
      // push()) — push()-ing a branch-nested location re-materialises the
      // branch stack and collides pageKeys with the already-mounted branch
      // root. go() lands on the post with the community feed beneath it.
      router.go(route);
    });
  }

  /// Maps an inbound URI to an in-app route, or null if unrecognized.
  ///
  /// Handles two shapes:
  ///   • https://petaverseapp.com/p/{id}  — verified App Link
  ///   • petaverse://p/{id}               — custom-scheme fallback (website button)
  static String? _routeFor(Uri uri) {
    // Custom scheme: petaverse://p/<id>  →  host="p", path="/<id>"
    if (uri.scheme == 'petaverse' && uri.host == 'p') {
      final id = int.tryParse(uri.pathSegments.firstOrNull ?? '');
      if (id != null && id > 0) return '${AppRoutes.community}/post/$id';
    }

    // HTTPS App Link: https://petaverseapp.com/p/<id>
    final segments = uri.pathSegments;
    if (segments.length == 2 && segments[0] == 'p') {
      final id = int.tryParse(segments[1]);
      if (id != null && id > 0) return '${AppRoutes.community}/post/$id';
    }

    return null;
  }
}
