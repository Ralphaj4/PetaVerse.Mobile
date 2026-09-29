// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_datasource_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mediaDatasource)
final mediaDatasourceProvider = MediaDatasourceProvider._();

final class MediaDatasourceProvider
    extends
        $FunctionalProvider<
          IMediaDatasource,
          IMediaDatasource,
          IMediaDatasource
        >
    with $Provider<IMediaDatasource> {
  MediaDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaDatasourceHash();

  @$internal
  @override
  $ProviderElement<IMediaDatasource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IMediaDatasource create(Ref ref) {
    return mediaDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IMediaDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IMediaDatasource>(value),
    );
  }
}

String _$mediaDatasourceHash() => r'c44957022cb6373c39dc9dead1f4682030ed3162';
