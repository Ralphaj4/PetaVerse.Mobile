import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/community_entities.dart';
import '../../domain/entities/community_enums.dart';
import '../../domain/entities/community_group_entities.dart';
import '../../domain/entities/community_group_enums.dart';
import '../../domain/repositories/community_group_repository.dart';
import '../datasources/community_group_remote_datasource.dart';

/// Community (group) repository. Maps DTOs onto domain entities and turns
/// [AppException]s into [Failure]s. Mirrors [CommunityRepositoryImpl].
///
/// [myPetIds] is a callback (not a snapshot) supplying the ids of the pets the
/// signed-in user owns, so `isMine` on lead/member pets always reflects the
/// current pet set.
class CommunityGroupRepositoryImpl implements CommunityGroupRepository {
  const CommunityGroupRepositoryImpl(this._source, this._myPetIds);

  final CommunityGroupDataSource _source;
  final Set<int> Function() _myPetIds;

  Set<int> get _mine => _myPetIds();

  // ── Directory & discovery ──────────────────────────────────────────────────

  @override
  Future<Result<CommunityDirectoryPage>> getCommunities({
    int? actingPetId,
    CommunityCategory? category,
    CommunitySort sort = CommunitySort.popular,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _source.getCommunities(
          petId: actingPetId,
          category: category?.wire,
          sort: sort.wire,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<CommunityDirectoryPage>> searchCommunities({
    required String query,
    int? actingPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _source.searchCommunities(
          query: query,
          petId: actingPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<List<CommunityGroup>>> getSuggestedCommunities({
    int? actingPetId,
    int limit = 10,
  }) =>
      _guard(() async {
        final dto = await _source.getSuggested(petId: actingPetId, limit: limit);
        return dto.toEntities(myPetIds: _mine);
      });

  @override
  Future<Result<List<CommunityGroup>>> getMyCommunities({
    required int actingPetId,
  }) =>
      _guard(() async {
        final dto = await _source.getMine(petId: actingPetId);
        return dto.toEntities(myPetIds: _mine);
      });

  // ── Single community ───────────────────────────────────────────────────────

  @override
  Future<Result<CommunityGroup>> getCommunity({
    required int communityId,
    int? viewerPetId,
  }) =>
      _guard(() async {
        final dto = await _source.getCommunity(
          id: communityId,
          viewerPetId: viewerPetId,
        );
        return dto.toEntity(leadIsMine: _mine.contains(dto.lead.id));
      });

  @override
  Future<Result<FeedPage>> getCommunityFeed({
    required int communityId,
    int? actingPetId,
    FeedSort sort = FeedSort.latest,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _source.getCommunityFeed(
          id: communityId,
          petId: actingPetId,
          sort: sort.wire,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<CommunityMemberPage>> getMembers({
    required int communityId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _source.getMembers(
          id: communityId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  // ── Lifecycle & membership ─────────────────────────────────────────────────

  @override
  Future<Result<CommunityGroup>> createCommunity({
    required int leadPetId,
    required String name,
    required CommunityCategory category,
    String? handle,
    String? description,
    String? avatarAssetId,
    String? bannerAssetId,
  }) =>
      _guard(() async {
        final dto = await _source.createCommunity({
          'leadPetId': leadPetId,
          'name': name,
          'category': category.wire,
          'handle': ?handle,
          'description': ?description,
          'avatarAssetId': ?avatarAssetId,
          'bannerAssetId': ?bannerAssetId,
        });
        return dto.toEntity(leadIsMine: _mine.contains(dto.lead.id));
      });

  @override
  Future<Result<CommunityGroup>> updateCommunity({
    required int communityId,
    String? name,
    String? handle,
    String? description,
    CommunityCategory? category,
    String? avatarAssetId,
    String? bannerAssetId,
  }) =>
      _guard(() async {
        final dto = await _source.updateCommunity(communityId, {
          'name': ?name,
          'handle': ?handle,
          'description': ?description,
          'category': ?category?.wire,
          'avatarAssetId': ?avatarAssetId,
          'bannerAssetId': ?bannerAssetId,
        });
        return dto.toEntity(leadIsMine: _mine.contains(dto.lead.id));
      });

  @override
  Future<Result<void>> deleteCommunity({required int communityId}) =>
      _guardVoid(() => _source.deleteCommunity(communityId));

  @override
  Future<Result<JoinResult>> join({
    required int communityId,
    required int petId,
  }) =>
      _guard(() async => (await _source.join(communityId, petId)).toEntity());

  @override
  Future<Result<JoinResult>> leave({
    required int communityId,
    required int petId,
  }) =>
      _guard(() async => (await _source.leave(communityId, petId)).toEntity());

  @override
  Future<Result<void>> removeMember({
    required int communityId,
    required int petId,
  }) =>
      _guardVoid(() => _source.removeMember(communityId, petId));

  @override
  Future<Result<bool>> checkHandleAvailable(String handle) =>
      _guard(() => _source.isHandleAvailable(handle));

  // ── Plumbing (mirrors CommunityRepositoryImpl) ──────────────────────────────

  Future<Result<T>> _guard<T>(Future<T> Function() body) async {
    try {
      return Result.success(await body());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  Future<Result<void>> _guardVoid(Future<void> Function() body) async {
    try {
      await body();
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
