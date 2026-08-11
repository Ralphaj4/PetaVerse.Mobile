import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/breed.dart';
import '../../domain/entities/coat_color.dart';
import '../../domain/entities/new_pet.dart';
import '../../domain/entities/pet.dart';
import '../../domain/entities/pet_ref.dart';
import '../../domain/entities/pet_size.dart';
import '../../domain/entities/species.dart';
import '../../domain/repositories/pet_repository.dart';
import '../datasources/pet_local_datasource.dart';
import '../datasources/pet_remote_datasource.dart';

/// Pet repository.
///
/// The routing gate runs on lightweight refs (cache for an instant cold-start
/// answer, [fetchRefs] for the authoritative one). Full records ([getPets])
/// are display-only and never cached. Creating a pet returns the slim ref from
/// the create response — no extra round-trip.
class PetRepositoryImpl implements PetRepository {
  const PetRepositoryImpl({
    required PetRemoteDataSource remote,
    required PetLocalDataSource local,
  })  : _remote = remote,
        _local = local;

  final PetRemoteDataSource _remote;
  final PetLocalDataSource _local;

  @override
  Future<Result<List<PetRef>>> cachedRefs() async {
    try {
      return Result.success(await _local.readRefs());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<PetRef>>> fetchRefs() async {
    try {
      final dtos = await _remote.getMyPets();
      final refs = dtos.map((d) => d.toRef()).toList(growable: false);
      // Authoritative: replace the ref cache, then return.
      await _local.writeRefs(refs);
      return Result.success(refs);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    } catch (e) {
      // A non-AppException here means the response parsed unexpectedly (e.g. a
      // shape mismatch: /pets returned an object instead of an array, or a
      // field type changed). Surface it as a retryable failure with the real
      // detail instead of letting it escape and hang the routing gate.
      return Result.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<PetRef>> createPet(NewPet pet) async {
    try {
      final created = await _remote.createPet(pet);
      final ref = created.toRef();
      // Keep the ref cache in step so a cold start sees the new pet too.
      // Best-effort — a cache write failure doesn't fail the creation.
      try {
        final refs = [...await _local.readRefs(), ref];
        await _local.writeRefs(refs);
      } on AppException {
        // Ignore; the gate reconciles on the next read.
      }
      return Result.success(ref);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<Pet>>> cachedPets() async {
    try {
      final dtos = await _local.readPets();
      return Result.success(dtos.map((d) => d.toEntity()).toList());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<Pet>>> getPets() async {
    try {
      final dtos = await _remote.getMyPets();
      // Reconcile the offline-first display cache with the authoritative list.
      await _local.writePets(dtos);
      return Result.success(dtos.map((d) => d.toEntity()).toList());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<Pet>> getPetById(int id) async {
    try {
      final dto = await _remote.getPetById(id);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<Pet>> updatePet(int id, NewPet data) async {
    try {
      final dto = await _remote.updatePet(id, data);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> deletePet(int id) async {
    try {
      await _remote.deletePet(id);
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<Species>>> getSpecies() async {
    try {
      final dtos = await _remote.getSpecies();
      return Result.success(dtos.map((d) => d.toEntity()).toList());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<Breed>>> getBreeds(int speciesId) async {
    try {
      final dtos = await _remote.getBreeds(speciesId);
      return Result.success(dtos.map((d) => d.toEntity()).toList());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<PetSize>>> getPetSizes() async {
    try {
      final dtos = await _remote.getPetSizes();
      return Result.success(dtos.map((d) => d.toEntity()).toList());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<CoatColor>>> getCoatColors() async {
    try {
      final dtos = await _remote.getCoatColors();
      return Result.success(dtos.map((d) => d.toEntity()).toList());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<int?> cachedCurrentPetId() async {
    try {
      return await _local.readCurrentPetId();
    } on AppException {
      return null;
    }
  }

  @override
  Future<void> saveCurrentPetId(int id) async {
    try {
      await _local.writeCurrentPetId(id);
    } on AppException {
      // Best-effort; missing persistence only means re-select on next cold start.
    }
  }

  @override
  Future<void> clearCache() => _local.clear();

  Failure _mapFailure(AppException e) => switch (e) {
        NetworkException() => NetworkFailure(message: e.message),
        UnauthorizedException() => UnauthorizedFailure(message: e.message),
        ForbiddenException() => ForbiddenFailure(message: e.message),
        NotFoundException() => NotFoundFailure(message: e.message),
        ValidationException() => ValidationFailure(
            message: e.message,
            fieldErrors: e.fieldErrors,
          ),
        RateLimitException() => RateLimitFailure(
            message: e.message,
            retryAfter: e.retryAfter,
          ),
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
