import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../community/domain/entities/community_entities.dart';
import '../../domain/entities/page_entities.dart';
import '../../domain/repositories/page_repository.dart';
import '../datasources/page_remote_datasource.dart';

class PageRepositoryImpl implements PageRepository {
  const PageRepositoryImpl(this._source, this._myPetIds);

  final PageDataSource _source;
  final Set<int> Function() _myPetIds;

  @override
  Future<Result<PageProfile>> getPage(int pageId) =>
      _guard(() async => (await _source.getPage(pageId)).toEntity());

  @override
  Future<Result<FeedPage>> getPageFeed(
    int pageId, {
    String? cursor,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _source.getPageFeed(pageId, cursor: cursor, limit: limit);
        return dto.toEntity(myPetIds: _myPetIds());
      });

  @override
  Future<Result<PageProfile>> follow(int pageId) =>
      _guard(() async => (await _source.follow(pageId)).toEntity());

  @override
  Future<Result<PageProfile>> unfollow(int pageId) =>
      _guard(() async => (await _source.unfollow(pageId)).toEntity());

  Future<Result<T>> _guard<T>(Future<T> Function() body) async {
    try {
      return Result.success(await body());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  Failure _mapFailure(AppException e) => switch (e) {
        NetworkException() => NetworkFailure(message: e.message),
        UnauthorizedException() => UnauthorizedFailure(message: e.message),
        SuspendedException() => SuspendedFailure(
            message: e.message,
            suspendedUntil: e.suspendedUntil,
          ),
        BannedException() => BannedFailure(message: e.message),
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
        ConflictException() => ConflictFailure(message: e.message),
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
