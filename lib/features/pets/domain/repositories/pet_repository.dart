import '../../../../core/errors/result.dart';
import '../entities/breed.dart';
import '../entities/coat_color.dart';
import '../entities/new_pet.dart';
import '../entities/pet.dart';
import '../entities/pet_ref.dart';
import '../entities/pet_size.dart';
import '../entities/species.dart';

/// Contract for pet data against the PetsApp API.
///
/// All methods return [Result] — exceptions never cross this boundary.
///
/// Two distinct concerns:
///   • lightweight [PetRef]s drive the routing gate (does the user have a
///     pet?) and the current-pet pointer,
///   • full [Pet] records are display-only, fetched on demand by the screens
///     that render breed / age / gender.
abstract interface class PetRepository {
  /// The current user's pet refs, from the local cache only.
  ///
  /// Returns an empty list when nothing is cached. Never hits the network, so
  /// it gives the router an instant (possibly stale) routing decision on cold
  /// start. Reconcile with [fetchRefs] for the authoritative list.
  Future<Result<List<PetRef>>> cachedRefs();

  /// Fetches the current user's pets from the API as refs and replaces the
  /// ref cache. The source of truth for the gate. A failure (e.g. offline)
  /// leaves the cache untouched.
  Future<Result<List<PetRef>>> fetchRefs();

  /// Creates a pet for the current user. Returns the slim [PetRef] from the
  /// create response — no extra round-trip. The gate appends this ref; full
  /// data is fetched later by display screens.
  Future<Result<PetRef>> createPet(NewPet pet);

  /// The current user's full pet records from the local cache only, for an
  /// instant offline-first render. Empty when nothing is cached.
  Future<Result<List<Pet>>> cachedPets();

  /// The current user's full pet records from the API, replacing the full
  /// cache on success. The caller decides when to refresh.
  Future<Result<List<Pet>>> getPets();

  /// The full detail record for a single pet, always fetched from the API.
  Future<Result<Pet>> getPetById(int id);

  /// Updates an existing pet. Returns the updated [Pet] on success.
  Future<Result<Pet>> updatePet(int id, NewPet data);

  /// Deletes a pet permanently.
  Future<Result<void>> deletePet(int id);

  /// All species, for the create-pet animal-type picker.
  Future<Result<List<Species>>> getSpecies();

  /// The breeds of [speciesId], for the breed dropdown.
  Future<Result<List<Breed>>> getBreeds(int speciesId);

  /// All pet sizes, for the create-pet size picker.
  Future<Result<List<PetSize>>> getPetSizes();

  /// All coat colors, for the create-pet coat-color picker.
  Future<Result<List<CoatColor>>> getCoatColors();

  /// The persisted active pet id, or null on first launch / after logout.
  Future<int?> cachedCurrentPetId();

  /// Persists the active pet id so it survives a cold start.
  Future<void> saveCurrentPetId(int id);

  /// Clears all locally cached pet data (called on logout).
  Future<void> clearCache();
}
