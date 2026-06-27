// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Offline-first profile state.
///
/// The cache is warmed at login/verify time, so [build] returns the cached
/// user instantly (no spinner) and reconciles with the server in the
/// background. Only a cold cache (no login-time warm) falls back to a
/// blocking network fetch.

@ProviderFor(UserNotifier)
final userProvider = UserNotifierProvider._();

/// Offline-first profile state.
///
/// The cache is warmed at login/verify time, so [build] returns the cached
/// user instantly (no spinner) and reconciles with the server in the
/// background. Only a cold cache (no login-time warm) falls back to a
/// blocking network fetch.
final class UserNotifierProvider
    extends $AsyncNotifierProvider<UserNotifier, User> {
  /// Offline-first profile state.
  ///
  /// The cache is warmed at login/verify time, so [build] returns the cached
  /// user instantly (no spinner) and reconciles with the server in the
  /// background. Only a cold cache (no login-time warm) falls back to a
  /// blocking network fetch.
  UserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userNotifierHash();

  @$internal
  @override
  UserNotifier create() => UserNotifier();
}

String _$userNotifierHash() => r'9859aec7dfe3aacb117b2163bf994fb86ee91557';

/// Offline-first profile state.
///
/// The cache is warmed at login/verify time, so [build] returns the cached
/// user instantly (no spinner) and reconciles with the server in the
/// background. Only a cold cache (no login-time warm) falls back to a
/// blocking network fetch.

abstract class _$UserNotifier extends $AsyncNotifier<User> {
  FutureOr<User> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User>, User>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User>, User>,
              AsyncValue<User>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
