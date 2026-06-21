import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/vision_profile_dto.dart';
import '../../domain/entities/vision_profile.dart';

abstract class IVisionProfileRemoteDatasource {
  Future<Result<VisionProfile?>> getBySpeciesId(int speciesId);
  Future<Result<VisionProfile?>> getBySpeciesName(String speciesName);
  Future<Result<List<VisionProfile>>> getAll();
}

class VisionProfileRemoteDatasource implements IVisionProfileRemoteDatasource {
  final ApiClient _apiClient;

  VisionProfileRemoteDatasource(this._apiClient);

  @override
  Future<Result<VisionProfile?>> getBySpeciesId(int speciesId) async {
    try {
      final data = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.speciesVision(speciesId),
      );
      final dto = VisionProfileDto.fromJson(data);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<VisionProfile?>> getBySpeciesName(String speciesName) async {
    try {
      final data = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.speciesVisionByName(speciesName),
      );
      final dto = VisionProfileDto.fromJson(data);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<VisionProfile>>> getAll() async {
    try {
      final data = await _apiClient.get<List<dynamic>>(
        ApiEndpoints.speciesVisionAll,
      );
      final list = data
          .map((e) => VisionProfileDto.fromJson(e as Map<String, dynamic>).toEntity())
          .toList(growable: false);
      return Result.success(list);
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
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
