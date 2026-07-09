import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../pets/domain/entities/pet.dart';
import '../../domain/entities/co_ownership.dart';
import '../../domain/repositories/co_ownership_repository.dart';
import '../datasources/co_ownership_remote_datasource.dart';

/// Co-ownership repository. Wraps every remote call so exceptions never cross
/// the repository boundary — mapped AppExceptions become typed [Failure]s, and
/// any other error (e.g. a response-shape/parse error) becomes a
/// [ServerFailure] rather than escaping and hanging the caller's async state.
class CoOwnershipRepositoryImpl implements CoOwnershipRepository {
  const CoOwnershipRepositoryImpl({required CoOwnershipRemoteDataSource remote})
      : _remote = remote;

  final CoOwnershipRemoteDataSource _remote;

  @override
  Future<Result<PublicUserCard>> lookupByCode(String code, {int? petId}) =>
      _guard(() async =>
          (await _remote.lookupByCode(code, petId: petId)).toEntity());

  @override
  Future<Result<SentCoOwnerInvite>> sendInvite({
    required int petId,
    required String userCode,
  }) =>
      _guard(() async =>
          (await _remote.sendInvite(petId: petId, userCode: userCode))
              .toEntity());

  @override
  Future<Result<List<IncomingCoOwnerInvite>>> getIncoming() => _guard(
      () async => (await _remote.getIncoming()).map((d) => d.toEntity()).toList());

  @override
  Future<Result<Pet>> acceptInvite(int id) =>
      _guard(() async => (await _remote.acceptInvite(id)).toEntity());

  @override
  Future<Result<void>> declineInvite(int id) =>
      _guard(() => _remote.declineInvite(id));

  @override
  Future<Result<List<SentCoOwnerInvite>>> getSent(int petId) => _guard(
      () async => (await _remote.getSent(petId)).map((d) => d.toEntity()).toList());

  @override
  Future<Result<void>> cancelInvite({required int petId, required int id}) =>
      _guard(() => _remote.cancelInvite(petId: petId, id: id));

  @override
  Future<Result<List<PetOwner>>> getOwners(int petId) => _guard(
      () async => (await _remote.getOwners(petId)).map((d) => d.toEntity()).toList());

  @override
  Future<Result<void>> removeOwner({
    required int petId,
    required String userId,
  }) =>
      _guard(() => _remote.removeOwner(petId: petId, userId: userId));

  /// Runs [action], mapping AppExceptions to typed failures and any other
  /// error to a [ServerFailure] — so no exception ever escapes.
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
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
