// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(visionProfile)
final visionProfileProvider = VisionProfileFamily._();

final class VisionProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<VisionProfile?>,
          VisionProfile?,
          FutureOr<VisionProfile?>
        >
    with $FutureModifier<VisionProfile?>, $FutureProvider<VisionProfile?> {
  VisionProfileProvider._({
    required VisionProfileFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'visionProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$visionProfileHash();

  @override
  String toString() {
    return r'visionProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<VisionProfile?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VisionProfile?> create(Ref ref) {
    final argument = this.argument as int;
    return visionProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VisionProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$visionProfileHash() => r'55e1931f7feef2259dc3e98ffbe9dc77b424a600';

final class VisionProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<VisionProfile?>, int> {
  VisionProfileFamily._()
    : super(
        retry: null,
        name: r'visionProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VisionProfileProvider call(int speciesId) =>
      VisionProfileProvider._(argument: speciesId, from: this);

  @override
  String toString() => r'visionProfileProvider';
}

@ProviderFor(visionProfileByName)
final visionProfileByNameProvider = VisionProfileByNameFamily._();

final class VisionProfileByNameProvider
    extends
        $FunctionalProvider<
          AsyncValue<VisionProfile?>,
          VisionProfile?,
          FutureOr<VisionProfile?>
        >
    with $FutureModifier<VisionProfile?>, $FutureProvider<VisionProfile?> {
  VisionProfileByNameProvider._({
    required VisionProfileByNameFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'visionProfileByNameProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$visionProfileByNameHash();

  @override
  String toString() {
    return r'visionProfileByNameProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<VisionProfile?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VisionProfile?> create(Ref ref) {
    final argument = this.argument as String;
    return visionProfileByName(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VisionProfileByNameProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$visionProfileByNameHash() =>
    r'90845f1e25fdd2488476d91f29c489cf9243be66';

final class VisionProfileByNameFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<VisionProfile?>, String> {
  VisionProfileByNameFamily._()
    : super(
        retry: null,
        name: r'visionProfileByNameProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VisionProfileByNameProvider call(String speciesName) =>
      VisionProfileByNameProvider._(argument: speciesName, from: this);

  @override
  String toString() => r'visionProfileByNameProvider';
}

@ProviderFor(allVisionProfiles)
final allVisionProfilesProvider = AllVisionProfilesProvider._();

final class AllVisionProfilesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VisionProfile>>,
          List<VisionProfile>,
          FutureOr<List<VisionProfile>>
        >
    with
        $FutureModifier<List<VisionProfile>>,
        $FutureProvider<List<VisionProfile>> {
  AllVisionProfilesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allVisionProfilesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allVisionProfilesHash();

  @$internal
  @override
  $FutureProviderElement<List<VisionProfile>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VisionProfile>> create(Ref ref) {
    return allVisionProfiles(ref);
  }
}

String _$allVisionProfilesHash() => r'56e170c905ee8fb9641fd35330853479ef1adcdb';
