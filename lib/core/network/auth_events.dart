import 'dart:async';

/// A tiny, framework-free broadcaster for auth lifecycle events.
///
/// Lives in `core/network` on purpose: the [AuthInterceptor] runs deep inside
/// Dio, far from Riverpod and the router, but it is the one place that knows
/// when a session can no longer be recovered (refresh failed / refused). It
/// emits [onSessionExpired] here; the session gate listens and flips the app
/// to logged-out, which drives the router back to login.
///
/// This decouples the network layer from presentation — core never imports a
/// feature — while still letting a dead session propagate out of the interceptor.
class AuthEvents {
  final _controller = StreamController<void>.broadcast();

  /// Fires once each time an unrecoverable auth failure clears the tokens.
  Stream<void> get onSessionExpired => _controller.stream;

  /// Called by the interceptor after it has cleared the tokens because the
  /// session cannot be refreshed. Safe to call after [dispose] (no-op).
  void notifySessionExpired() {
    if (!_controller.isClosed) _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}
