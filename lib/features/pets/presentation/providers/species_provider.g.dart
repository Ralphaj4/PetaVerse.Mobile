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

/// All pet sizes for the create-pet size picker.

@ProviderFor(petSizesList)
final petSizesListProvider = PetSizesListProvider._();

/// All pet sizes for the create-pet size picker.

final class PetSizesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PetSize>>,
          List<PetSize>,
          FutureOr<List<PetSize>>
        >
    with $FutureModifier<List<PetSize>>, $FutureProvider<List<PetSize>> {
  /// All pet sizes for the create-pet size picker.
  PetSizesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'petSizesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$petSizesListHash();

  @$internal
  @override
  $FutureProviderElement<List<PetSize>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PetSize>> create(Ref ref) {
    return petSizesList(ref);
  }
}

String _$petSizesListHash() => r'4cb08144b4cee1bc1f1aa18bf69d5b9f5ae05f4f';

/// All coat colors for the create-pet coat-color picker.

@ProviderFor(coatColorsList)
final coatColorsListProvider = CoatColorsListProvider._();

/// All coat colors for the create-pet coat-color picker.

final class CoatColorsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CoatColor>>,
          List<CoatColor>,
          FutureOr<List<CoatColor>>
        >
    with $FutureModifier<List<CoatColor>>, $FutureProvider<List<CoatColor>> {
  /// All coat colors for the create-pet coat-color picker.
  CoatColorsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'coatColorsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$coatColorsListHash();

  @$internal
  @override
  $FutureProviderElement<List<CoatColor>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CoatColor>> create(Ref ref) {
    return coatColorsList(ref);
  }
}

String _$coatColorsListHash() => r'cbf46bbd75384dd8bab422ab990e964354a206d0';
