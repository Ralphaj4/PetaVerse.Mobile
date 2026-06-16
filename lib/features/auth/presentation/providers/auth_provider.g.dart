// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives the auth submission state for the login / register / OTP flows.
///
/// Each action returns a [bool] (success) for the pages' navigation logic,
/// while the AsyncValue carries loading + the last [Failure] so the UI can
/// show a spinner and surface a localized error message.

@ProviderFor(AuthNotifier)
final authProvider = AuthNotifierProvider._();

/// Drives the auth submission state for the login / register / OTP flows.
///
/// Each action returns a [bool] (success) for the pages' navigation logic,
/// while the AsyncValue carries loading + the last [Failure] so the UI can
/// show a spinner and surface a localized error message.
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, void> {
  /// Drives the auth submission state for the login / register / OTP flows.
  ///
  /// Each action returns a [bool] (success) for the pages' navigation logic,
  /// while the AsyncValue carries loading + the last [Failure] so the UI can
  /// show a spinner and surface a localized error message.
  AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();
}

String _$authNotifierHash() => r'a62973cc770b09d3e5d8ff679f82e1d199dc7f3a';

/// Drives the auth submission state for the login / register / OTP flows.
///
/// Each action returns a [bool] (success) for the pages' navigation logic,
/// while the AsyncValue carries loading + the last [Failure] so the UI can
/// show a spinner and surface a localized error message.

abstract class _$AuthNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
