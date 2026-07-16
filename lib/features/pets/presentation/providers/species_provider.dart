import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/breed.dart';
import '../../domain/entities/coat_color.dart';
import '../../domain/entities/pet_size.dart';
import '../../domain/entities/species.dart';
import 'pet_repository_provider.dart';

part 'species_provider.g.dart';

/// All species for the create-pet animal-type picker.
@riverpod
Future<List<Species>> speciesList(Ref ref) async {
  final result = await ref.watch(petRepositoryProvider).getSpecies();
  return result.when(
    success: (species) => species,
    failure: (f) => throw f,
  );
}

/// Breeds for the selected [speciesId]. A family so each species' breeds are
/// fetched and cached independently as the picker changes.
@riverpod
Future<List<Breed>> breedsList(Ref ref, int speciesId) async {
  final result = await ref.watch(petRepositoryProvider).getBreeds(speciesId);
  return result.when(
    success: (breeds) => breeds,
    failure: (f) => throw f,
  );
}

/// All pet sizes for the create-pet size picker.
@riverpod
Future<List<PetSize>> petSizesList(Ref ref) async {
  final result = await ref.watch(petRepositoryProvider).getPetSizes();
  return result.when(
    success: (sizes) => sizes,
    failure: (f) => throw f,
  );
}

/// All coat colors for the create-pet coat-color picker.
@riverpod
Future<List<CoatColor>> coatColorsList(Ref ref) async {
  final result = await ref.watch(petRepositoryProvider).getCoatColors();
  return result.when(
    success: (colors) => colors,
    failure: (f) => throw f,
  );
}

/// Surfaces the [Failure] type behind a thrown error so the UI can localize it.
Failure asFailure(Object error) =>
    error is Failure ? error : const UnknownFailure();
