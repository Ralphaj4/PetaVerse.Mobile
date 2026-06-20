// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches the full detail record for a single pet by id.
/// Auto-disposed — each sheet open gets a fresh fetch.

@ProviderFor(petDetail)
final petDetailProvider = PetDetailFamily._();

/// Fetches the full detail record for a single pet by id.
/// Auto-disposed — each sheet open gets a fresh fetch.

final class PetDetailProvider
    extends $FunctionalProvider<AsyncValue<Pet>, Pet, FutureOr<Pet>>
    with $FutureModifier<Pet>, $FutureProvider<Pet> {
  /// Fetches the full detail record for a single pet by id.
  /// Auto-disposed — each sheet open gets a fresh fetch.
  PetDetailProvider._({
    required PetDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'petDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$petDetailHash();

  @override
  String toString() {
    return r'petDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Pet> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Pet> create(Ref ref) {
    final argument = this.argument as int;
    return petDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PetDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$petDetailHash() => r'b8edff5ed247c305bf45500298294707f83966b7';

/// Fetches the full detail record for a single pet by id.
/// Auto-disposed — each sheet open gets a fresh fetch.

final class PetDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Pet>, int> {
  PetDetailFamily._()
    : super(
        retry: null,
        name: r'petDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fetches the full detail record for a single pet by id.
  /// Auto-disposed — each sheet open gets a fresh fetch.

  PetDetailProvider call(int id) =>
      PetDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'petDetailProvider';
}
