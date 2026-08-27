import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../../shared/models/paginated_response.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._remote);

  final NotificationRemoteDataSource _remote;

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Result.success(await run());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<PaginatedResponse<AppNotification>>> getNotifications({
    int page = 1,
    int pageSize = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.getNotifications(
          page: page,
          pageSize: pageSize,
        );
        return PaginatedResponse(
          items: dto.items.map((e) => e.toEntity()).toList(growable: false),
          page: dto.page,
          hasMore: dto.hasMore,
        );
      });

  @override
  Future<Result<int>> getUnreadCount() =>
      _guard(() => _remote.getUnreadCount());

  @override
  Future<Result<void>> markRead(int id) => _guard(() => _remote.markRead(id));

  @override
  Future<Result<void>> markAllRead() => _guard(() => _remote.markAllRead());

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
