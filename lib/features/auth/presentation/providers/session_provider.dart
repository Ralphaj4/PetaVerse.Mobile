import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import 'auth_repository_provider.dart';

part 'session_provider.g.dart';

/// Auth session gate state.
///
/// [ready] flips true once the one-time secure-storage check completes;
/// until then the router holds on the splash. [loggedIn] is then flipped
/// synchronously by the auth flows. Kept synchronous on purpose — an
/// async re-read would let the router's redirect observe a stale value
/// and bounce the user (e.g. login → home right after logout).
class SessionState {
  const SessionState({required this.ready, required this.loggedIn});

  final bool ready;
  final bool loggedIn;

  SessionState copyWith({bool? ready, bool? loggedIn}) => SessionState(
        ready: ready ?? this.ready,
        loggedIn: loggedIn ?? this.loggedIn,
      );
}

@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  /// True once an auth flow has explicitly set the gate, so a late initial
  /// [_load] completion can't clobber a login/logout that happened first.
  bool _explicitlySet = false;

  @override
  SessionState build() {
    // Listen for unrecoverable auth failures from the network layer (the
    // interceptor cleared the tokens because refresh failed/was refused). This
    // is what flips the gate to logged-out mid-session so the router redirects
    // to login — without it the tokens would be gone but the app would still
    // believe it was signed in, stranding the user on 401s.
    final sub =
        ref.watch(authEventsProvider).onSessionExpired.listen((_) {
      setLoggedIn(false);
    });
    ref.onDispose(sub.cancel);

    _load();
    return const SessionState(ready: false, loggedIn: false);
  }

  Future<void> _load() async {
    final loggedIn = await ref.read(authRepositoryProvider).hasSession();
    if (_explicitlySet) return; // an auth flow already won; don't overwrite.
    state = SessionState(ready: true, loggedIn: loggedIn);
  }

  /// Flip the gate immediately after login/verify (true) or logout (false).
  void setLoggedIn(bool value) {
    _explicitlySet = true;
    state = SessionState(ready: true, loggedIn: value);
  }
}
