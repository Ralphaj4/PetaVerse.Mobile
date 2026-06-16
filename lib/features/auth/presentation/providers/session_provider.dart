import 'package:riverpod_annotation/riverpod_annotation.dart';

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
