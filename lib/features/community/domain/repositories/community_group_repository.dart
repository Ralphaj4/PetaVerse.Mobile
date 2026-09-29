import '../../../../core/errors/result.dart';
import '../entities/community_entities.dart';
import '../entities/community_enums.dart';
import '../entities/community_group_entities.dart';
import '../entities/community_group_enums.dart';

/// Contract for pet-led **community** (group) data access. Implemented in the
/// data layer; consumed by presentation providers. Every method returns a
/// [Result] so the UI never sees raw exceptions.
///
/// The **acting pet** is passed explicitly where the API takes it. Membership
/// and leadership are per-pet — a user with several pets can have each pet in
/// different communities.
///
/// Note: posting *into* a community reuses `CommunityRepository.createPost`
/// with its `communityId` argument — there is no separate method here.
abstract interface class CommunityGroupRepository {
  // ── Directory & discovery ──────────────────────────────────────────────────

  Future<Result<CommunityDirectoryPage>> getCommunities({
    int? actingPetId,
    CommunityCategory? category,
    CommunitySort sort = CommunitySort.popular,
    int page = 0,
    int limit = 20,
  });

  Future<Result<CommunityDirectoryPage>> searchCommunities({
    required String query,
    int? actingPetId,
    int page = 0,
    int limit = 20,
  });

  Future<Result<List<CommunityGroup>>> getSuggestedCommunities({
    int? actingPetId,
    int limit = 10,
  });

  /// Communities the acting pet is a member of (for the "My Communities" rail).
  Future<Result<List<CommunityGroup>>> getMyCommunities({
    required int actingPetId,
  });

  // ── Single community ───────────────────────────────────────────────────────

  Future<Result<CommunityGroup>> getCommunity({
    required int communityId,
    int? viewerPetId,
  });

  /// The community's post feed — reuses the shared [FeedPage] shape, so the
  /// same feed list machinery and [PostCard] render it.
  Future<Result<FeedPage>> getCommunityFeed({
    required int communityId,
    int? actingPetId,
    FeedSort sort = FeedSort.latest,
    int page = 0,
    int limit = 20,
  });

  Future<Result<CommunityMemberPage>> getMembers({
    required int communityId,
    int page = 0,
    int limit = 20,
  });

  // ── Lifecycle & membership ─────────────────────────────────────────────────

  /// Creates a community; the [leadPetId] pet becomes its lead. Avatar/banner
  /// are confirmed `mediaAssetId`s from the presign/confirm flow (never raw
  /// URLs), matching how post media is attached.
  Future<Result<CommunityGroup>> createCommunity({
    required int leadPetId,
    required String name,
    required CommunityCategory category,
    String? handle,
    String? description,
    String? avatarAssetId,
    String? bannerAssetId,
  });

  Future<Result<CommunityGroup>> updateCommunity({
    required int communityId,
    String? name,
    String? handle,
    String? description,
    CommunityCategory? category,
    String? avatarAssetId,
    String? bannerAssetId,
  });

  /// Lead only.
  Future<Result<void>> deleteCommunity({required int communityId});

  Future<Result<JoinResult>> join({
    required int communityId,
    required int petId,
  });

  Future<Result<JoinResult>> leave({
    required int communityId,
    required int petId,
  });

  /// Lead only — removes another pet from the community.
  Future<Result<void>> removeMember({
    required int communityId,
    required int petId,
  });

  /// Whether [handle] is available (not already taken by another community).
  Future<Result<bool>> checkHandleAvailable(String handle);
}
