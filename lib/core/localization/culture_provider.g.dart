// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'culture_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app-wide current culture.
///
/// Backed by [SecureStorageService] (saved like the access token) and loaded
/// eagerly at startup via [load] so the value is available synchronously for
/// request headers ([AppCulture.code] → `X-Culture`) and the UI locale.
/// Defaults to [AppCulture.fallback] (`en`) until the user picks one.

@ProviderFor(Culture)
final cultureProvider = CultureProvider._();

/// The app-wide current culture.
///
/// Backed by [SecureStorageService] (saved like the access token) and loaded
/// eagerly at startup via [load] so the value is available synchronously for
/// request headers ([AppCulture.code] → `X-Culture`) and the UI locale.
/// Defaults to [AppCulture.fallback] (`en`) until the user picks one.
final class CultureProvider extends $NotifierProvider<Culture, AppCulture> {
  /// The app-wide current culture.
  ///
  /// Backed by [SecureStorageService] (saved like the access token) and loaded
  /// eagerly at startup via [load] so the value is available synchronously for
  /// request headers ([AppCulture.code] → `X-Culture`) and the UI locale.
  /// Defaults to [AppCulture.fallback] (`en`) until the user picks one.
  CultureProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cultureProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cultureHash();

  @$internal
  @override
  Culture create() => Culture();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppCulture value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppCulture>(value),
    );
  }
}

String _$cultureHash() => r'210638a3ab8f24368d7c4b683b4a32e266238342';

/// The app-wide current culture.
///
/// Backed by [SecureStorageService] (saved like the access token) and loaded
/// eagerly at startup via [load] so the value is available synchronously for
/// request headers ([AppCulture.code] → `X-Culture`) and the UI locale.
/// Defaults to [AppCulture.fallback] (`en`) until the user picks one.

abstract class _$Culture extends $Notifier<AppCulture> {
  AppCulture build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppCulture, AppCulture>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppCulture, AppCulture>,
              AppCulture,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
