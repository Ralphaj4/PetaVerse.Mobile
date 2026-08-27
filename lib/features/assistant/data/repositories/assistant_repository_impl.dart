import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/repositories/assistant_repository.dart';
import '../datasources/assistant_remote_datasource.dart';

class AssistantRepositoryImpl implements AssistantRepository {
  const AssistantRepositoryImpl({required AssistantRemoteDataSource remote})
      : _remote = remote;

  final AssistantRemoteDataSource _remote;

  @override
  Future<Result<List<ChatSessionSummary>>> getSessions() => _guard(
        () async => (await _remote.getSessions())
            .map((d) => d.toEntity())
            .toList(growable: false),
      );

  @override
  Future<Result<ChatSession>> getSession(int sessionId) =>
      _guard(() async => (await _remote.getSession(sessionId)).toEntity());

  @override
  Future<Result<ChatSession>> createSession({int? petId, String? title}) =>
      _guard(() async =>
          (await _remote.createSession(petId: petId, title: title)).toEntity());

  @override
  Future<Result<void>> deleteSession(int sessionId) =>
      _guard(() => _remote.deleteSession(sessionId));

  /// The stream itself is not wrapped in Result — transport errors arrive as
  /// terminal [ErrorEvent]s. Catastrophic setup errors are caught and emitted
  /// as a single [ErrorEvent] so the notifier always has one code path.
  @override
  Stream<ChatStreamEvent> sendMessage(int sessionId, String text) async* {
    try {
      yield* _remote.sendMessage(sessionId, text);
    } on AppException catch (e) {
      yield ErrorEvent('transport', e.message);
    } catch (e) {
      yield ErrorEvent('unknown', e.toString());
    }
  }

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
