import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/walk_activity.dart';
import '../../domain/repositories/activity_repository.dart';
import '../datasources/activity_remote_datasource.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl(ApiClient client)
      : _remote = ActivityRemoteDataSource(client);

  final ActivityRemoteDataSource _remote;

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Result.success(await run());
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

  @override
  Future<Result<WalkActivity>> saveActivity({
    required int petId,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationSeconds,
    double? distanceMeters,
    double? avgSpeedKmh,
  }) =>
      _guard(() async {
        final dto = await _remote.saveActivity(
          petId: petId,
          startedAt: startedAt,
          endedAt: endedAt,
          durationSeconds: durationSeconds,
          distanceMeters: distanceMeters,
          avgSpeedKmh: avgSpeedKmh,
        );
        return dto.toEntity();
      });

  @override
  Future<Result<List<WalkActivity>>> getActivities(
    int petId, {
    int page = 1,
    int pageSize = 20,
  }) =>
      _guard(() async {
        final page_ = await _remote.getActivities(petId,
            page: page, pageSize: pageSize);
        return page_.items.map((e) => e.toEntity()).toList(growable: false);
      });

  @override
  Future<Result<void>> deleteActivity(int petId, int activityId) =>
      _guard(() => _remote.deleteActivity(petId, activityId));
}
