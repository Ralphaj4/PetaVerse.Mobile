import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/lost_found_dashboard.dart';
import '../../domain/entities/lost_found_report.dart';
import '../../domain/repositories/lost_found_repository.dart';
import '../datasources/lost_found_remote_datasource.dart';

/// Lost & Found repository. Maps remote DTOs onto domain entities and turns
/// [AppException]s into [Failure]s. No local cache — the dashboard is always
/// fetched fresh for the current location.
class LostFoundRepositoryImpl implements LostFoundRepository {
  const LostFoundRepositoryImpl(this._remote);

  final LostFoundRemoteDataSource _remote;

  @override
  Future<Result<LostFoundDashboard>> getDashboard({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
    String? filter,
  }) async {
    try {
      final dto = await _remote.getDashboard(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        filter: filter,
      );
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<LostFoundReport>> createReport({
    required int type,
    required String petName,
    required int speciesId,
    int? breedId,
    required String description,
    required String lastSeenAddress,
    required double latitude,
    required double longitude,
    int? petId,
    int? reward,
    String? avatarMediaAssetId,
  }) async {
    try {
      final dto = await _remote.createListing(
        type: type,
        petName: petName,
        speciesId: speciesId,
        breedId: breedId,
        description: description,
        lastSeenAddress: lastSeenAddress,
        latitude: latitude,
        longitude: longitude,
        petId: petId,
        reward: reward,
        avatarMediaAssetId: avatarMediaAssetId,
      );
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<LostFoundReport>> getReport(int id) async {
    try {
      final dto = await _remote.getListing(id);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> deleteReport(int id) async {
    try {
      await _remote.deleteListing(id);
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<VolunteerInfo>> getVolunteerStatus() async {
    try {
      final dto = await _remote.getVolunteerStatus();
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<VolunteerInfo>> joinVolunteers() async {
    try {
      final dto = await _remote.joinVolunteers();
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> leaveVolunteers() async {
    try {
      await _remote.leaveVolunteers();
      return const Result.success(null);
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
