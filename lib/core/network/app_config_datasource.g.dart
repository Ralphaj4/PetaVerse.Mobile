// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appConfigDatasource)
final appConfigDatasourceProvider = AppConfigDatasourceProvider._();

final class AppConfigDatasourceProvider
    extends
        $FunctionalProvider<
          AppConfigDatasource,
          AppConfigDatasource,
          AppConfigDatasource
        >
    with $Provider<AppConfigDatasource> {
  AppConfigDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigDatasourceHash();

  @$internal
  @override
  $ProviderElement<AppConfigDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppConfigDatasource create(Ref ref) {
    return appConfigDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppConfigDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppConfigDatasource>(value),
    );
  }
}

String _$appConfigDatasourceHash() =>
    r'66e3a6eeb15eedcf804d43a87c82c1c276bd0992';

/// Fetches (or cache-falls-back) the app config once per process lifetime.
/// The result is a [Result<AppConfig>] so the router can handle failure
/// explicitly - it never throws.

@ProviderFor(appConfig)
final appConfigProvider = AppConfigProvider._();

/// Fetches (or cache-falls-back) the app config once per process lifetime.
/// The result is a [Result<AppConfig>] so the router can handle failure
/// explicitly - it never throws.

final class AppConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<AppConfig>>,
          Result<AppConfig>,
          FutureOr<Result<AppConfig>>
        >
    with
        $FutureModifier<Result<AppConfig>>,
        $FutureProvider<Result<AppConfig>> {
  /// Fetches (or cache-falls-back) the app config once per process lifetime.
  /// The result is a [Result<AppConfig>] so the router can handle failure
  /// explicitly - it never throws.
  AppConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigHash();

  @$internal
  @override
  $FutureProviderElement<Result<AppConfig>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Result<AppConfig>> create(Ref ref) {
    return appConfig(ref);
  }
}

String _$appConfigHash() => r'54d55dc25aa542de326698cadcb24cbe228cbf21';
