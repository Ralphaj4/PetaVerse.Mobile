import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/breed.dart';
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

/// Surfaces the [Failure] type behind a thrown error so the UI can localize it.
Failure asFailure(Object error) =>
    error is Failure ? error : const UnknownFailure();
