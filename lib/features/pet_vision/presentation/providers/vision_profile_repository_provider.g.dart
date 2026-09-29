// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_profile_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(visionProfileRepository)
final visionProfileRepositoryProvider = VisionProfileRepositoryProvider._();

final class VisionProfileRepositoryProvider
    extends
        $FunctionalProvider<
          VisionProfileRepository,
          VisionProfileRepository,
          VisionProfileRepository
        >
    with $Provider<VisionProfileRepository> {
  VisionProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visionProfileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visionProfileRepositoryHash();

  @$internal
  @override
  $ProviderElement<VisionProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VisionProfileRepository create(Ref ref) {
    return visionProfileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisionProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisionProfileRepository>(value),
    );
  }
}

String _$visionProfileRepositoryHash() =>
    r'05ad5f12e291625db3a8771d8f42d0567f479fbf';
