import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/adoption_listing.dart';
import '../../domain/repositories/adoption_repository.dart';
import '../datasources/adoption_remote_datasource.dart';

/// Adoption repository. Maps remote DTOs onto domain entities and turns
/// [AppException]s into [Failure]s. No local cache — the board is fetched fresh
/// for the current query.
class AdoptionRepositoryImpl implements AdoptionRepository {
  const AdoptionRepositoryImpl(this._remote);

  final AdoptionRemoteDataSource _remote;

  @override
  Future<Result<List<AdoptionListing>>> getListings({
    int? speciesId,
    String? query,
    double? lat,
    double? lng,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final dto = await _remote.getListings(
        speciesId: speciesId,
        query: query,
        lat: lat,
        lng: lng,
        page: page,
        pageSize: pageSize,
      );
      return Result.success(
        dto.items.map((e) => e.toEntity()).toList(growable: false),
      );
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<AdoptionListing>> getListing(int id) async {
    try {
      final dto = await _remote.getListing(id);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<AdoptionListing>> createListing({
    required int petId,
    String? description,
    String? locationLabel,
    double? latitude,
    double? longitude,
    bool vaccinated = false,
    bool neutered = false,
    bool goodWithKids = false,
  }) async {
    try {
      final dto = await _remote.createListing({
        'petId': petId,
        'description': ?description,
        'locationLabel': ?locationLabel,
        'latitude': ?latitude,
        'longitude': ?longitude,
        'vaccinated': vaccinated,
        'neutered': neutered,
        'goodWithKids': goodWithKids,
      });
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<AdoptionListing>> createShelterListing({
    required String petName,
    required int speciesId,
    required String gender,
    int? breedId,
    DateTime? dateOfBirth,
    int? sizeId,
    int? coatColorId,
    String? photoAssetId,
    String? description,
    String? locationLabel,
    double? latitude,
    double? longitude,
    bool vaccinated = false,
    bool neutered = false,
    bool goodWithKids = false,
  }) async {
    try {
      // No petId → the backend treats this as a shelter/stray listing.
      final dto = await _remote.createListing({
        'petName': petName,
        'speciesId': speciesId,
        'gender': gender,
        'breedId': ?breedId,
        'dateOfBirth': ?dateOfBirth?.toUtc().toIso8601String(),
        'sizeId': ?sizeId,
        'coatColorId': ?coatColorId,
        'photoAssetId': ?photoAssetId,
        'description': ?description,
        'locationLabel': ?locationLabel,
        'latitude': ?latitude,
        'longitude': ?longitude,
        'vaccinated': vaccinated,
        'neutered': neutered,
        'goodWithKids': goodWithKids,
      });
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<AdoptionListing>>> getMyListings() async {
    try {
      final dtos = await _remote.getMyListings();
      return Result.success(
        dtos.map((e) => e.toEntity()).toList(growable: false),
      );
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> withdrawListing(int id) async {
    try {
      await _remote.withdrawListing(id);
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> deleteListing(int id) async {
    try {
      await _remote.deleteListing(id);
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<AdoptionRequest>>> getListingRequests(
    int listingId,
  ) async {
    try {
      final dtos = await _remote.getListingRequests(listingId);
      return Result.success(
        dtos.map((e) => e.toEntity()).toList(growable: false),
      );
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> approveRequest(int listingId, int requestId) async {
    try {
      await _remote.approveRequest(listingId, requestId);
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> rejectRequest(int listingId, int requestId) async {
    try {
      await _remote.rejectRequest(listingId, requestId);
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<AdoptionPet>> completeRequest(
    int listingId,
    int requestId,
  ) async {
    try {
      final dto = await _remote.completeRequest(listingId, requestId);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<MyAdoptionRequest>> apply(int listingId) async {
    try {
      final dto = await _remote.apply(listingId);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<MyAdoptionRequest>>> getMyRequests() async {
    try {
      final dtos = await _remote.getMyRequests();
      return Result.success(
        dtos.map((e) => e.toEntity()).toList(growable: false),
      );
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> cancelRequest(int requestId) async {
    try {
      await _remote.cancelRequest(requestId);
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<MyAdoptionRequest>> acceptRequest(int requestId) async {
    try {
      final dto = await _remote.acceptRequest(requestId);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

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
