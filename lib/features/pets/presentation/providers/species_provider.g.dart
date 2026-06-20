// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All species for the create-pet animal-type picker.

@ProviderFor(speciesList)
final speciesListProvider = SpeciesListProvider._();

/// All species for the create-pet animal-type picker.

final class SpeciesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Species>>,
          List<Species>,
          FutureOr<List<Species>>
        >
    with $FutureModifier<List<Species>>, $FutureProvider<List<Species>> {
  /// All species for the create-pet animal-type picker.
  SpeciesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'speciesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$speciesListHash();

  @$internal
  @override
  $FutureProviderElement<List<Species>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Species>> create(Ref ref) {
    return speciesList(ref);
  }
}

String _$speciesListHash() => r'99663c51394be59249137e8ba36fb754267b2d2a';

/// Breeds for the selected [speciesId]. A family so each species' breeds are
/// fetched and cached independently as the picker changes.

@ProviderFor(breedsList)
final breedsListProvider = BreedsListFamily._();

/// Breeds for the selected [speciesId]. A family so each species' breeds are
/// fetched and cached independently as the picker changes.

final class BreedsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Breed>>,
          List<Breed>,
          FutureOr<List<Breed>>
        >
    with $FutureModifier<List<Breed>>, $FutureProvider<List<Breed>> {
  /// Breeds for the selected [speciesId]. A family so each species' breeds are
  /// fetched and cached independently as the picker changes.
  BreedsListProvider._({
    required BreedsListFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'breedsListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$breedsListHash();

  @override
  String toString() {
    return r'breedsListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Breed>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Breed>> create(Ref ref) {
    final argument = this.argument as int;
    return breedsList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BreedsListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$breedsListHash() => r'798acdf018dcbd6cb79b7e2612fb86b52b07a502';

/// Breeds for the selected [speciesId]. A family so each species' breeds are
/// fetched and cached independently as the picker changes.

final class BreedsListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Breed>>, int> {
  BreedsListFamily._()
    : super(
        retry: null,
        name: r'breedsListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Breeds for the selected [speciesId]. A family so each species' breeds are
  /// fetched and cached independently as the picker changes.

  BreedsListProvider call(int speciesId) =>
      BreedsListProvider._(argument: speciesId, from: this);

  @override
  String toString() => r'breedsListProvider';
}
