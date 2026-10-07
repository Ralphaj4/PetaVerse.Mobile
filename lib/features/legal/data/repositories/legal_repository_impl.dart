import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/legal.dart';
import '../../domain/repositories/legal_repository.dart';
import '../datasources/legal_remote_datasource.dart';

/// Legal repository. Wraps every remote call so exceptions never cross the
/// repository boundary - mapped AppExceptions become typed [Failure]s, and any
/// other error (e.g. a response-shape/parse error) becomes a [ServerFailure]
/// rather than escaping and hanging the caller's async state.
class LegalRepositoryImpl implements LegalRepository {
  const LegalRepositoryImpl({required LegalRemoteDataSource remote})
      : _remote = remote;

  final LegalRemoteDataSource _remote;

  @override
  Future<Result<LegalStatus>> getStatus() =>
      _guard(() async => (await _remote.getStatus()).toEntity());

  @override
  Future<Result<LegalDocuments>> getCurrent() =>
      _guard(() async => (await _remote.getCurrent()).toEntity());

  @override
  Future<Result<LegalContent>> getContent({
    required LegalDocumentType type,
    required String version,
  }) =>
      _guard(() async =>
          (await _remote.getContent(type: type, version: version)).toEntity());

  @override
  Future<Result<LegalStatus>> accept({
    required LegalDocumentType type,
    required String version,
  }) =>
      _guard(() async =>
          (await _remote.accept(type: type, version: version)).toEntity());

  /// Runs [action], mapping AppExceptions to typed failures and any other
  /// error to a [ServerFailure] - so no exception ever escapes.
  Future<Result<T>> _guard<T>(Future<T> Function() action) async {
    try {
      return Result.success(await action());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    } catch (e) {
      return Result.failure(ServerFailure(message: e.toString()));
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
