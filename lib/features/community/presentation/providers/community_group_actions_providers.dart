import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/analytics/analytics_events.dart';
import '../../../../core/analytics/analytics_service.dart';
import '../../domain/entities/community_group_entities.dart';
import '../../domain/entities/community_group_enums.dart';
import '../../domain/repositories/community_group_repository.dart';
import 'community_group_feed_providers.dart';
import 'community_group_providers.dart';
import 'community_providers.dart';

part 'community_group_actions_providers.g.dart';

/// Write actions for pet-led communities (create, join, leave, delete, remove
/// member). Each mutates the server then reconciles the loaded directory /
/// detail / my-communities views so every screen updates at once.
///
/// Read as a plain object (`ref.read(communityGroupActionsProvider)`); it holds
/// no state. Mirrors [CommunityActions].
@Riverpod(keepAlive: true)
CommunityGroupActions communityGroupActions(Ref ref) =>
    CommunityGroupActions(ref);

class CommunityGroupActions {
  CommunityGroupActions(this._ref);

  final Ref _ref;

  CommunityGroupRepository get _repo =>
      _ref.read(communityGroupRepositoryProvider);
  int? get _actingPetId => _ref.read(actingPetIdProvider);

  // ── Membership ──────────────────────────────────────────────────────────────

  /// Joins [community] as the acting pet. Optimistically flips membership in
  /// the directory + detail views, then reconciles with the server's counts.
  /// Returns the new membership state (falls back to prior state on failure).
  Future<bool> join(CommunityGroup community) async {
    final petId = _actingPetId;
    if (petId == null) return community.isMember;

    _applyMembership(community, isMember: true, delta: 1);
    final result = await _repo.join(communityId: community.id, petId: petId);
    return result.when(
      success: (r) {
        _reconcile(community.id, r);
        _ref.read(analyticsServiceProvider).logEvent(
          AnalyticsEvents.communityJoined,
          parameters: {'communityId': community.id},
        );
        _ref.invalidate(myCommunitiesProvider);
        _ref.invalidate(suggestedCommunitiesProvider);
        return r.isMember;
      },
      failure: (_) {
        // Roll back the optimistic flip.
        _applyMembership(community, isMember: false, delta: -1);
        return community.isMember;
      },
    );
  }

  /// Leaves [community] as the acting pet. The lead cannot leave (they must
  /// delete instead) — the server enforces this; we surface it as a no-op.
  Future<bool> leave(CommunityGroup community) async {
    final petId = _actingPetId;
    if (petId == null || community.isLead) return community.isMember;

    _applyMembership(community, isMember: false, delta: -1);
    final result = await _repo.leave(communityId: community.id, petId: petId);
    return result.when(
      success: (r) {
        _reconcile(community.id, r);
        _ref.invalidate(myCommunitiesProvider);
        _ref.invalidate(suggestedCommunitiesProvider);
        return r.isMember;
      },
      failure: (_) {
        _applyMembership(community, isMember: true, delta: 1);
        return community.isMember;
      },
    );
  }

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  /// Creates a community led by the acting pet. Returns it, or null on failure
  /// (read [createFailure] for the reason).
  Future<CommunityGroup?> create({
    required String name,
    required CommunityCategory category,
    String? handle,
    String? description,
    String? avatarAssetId,
    String? bannerAssetId,
  }) async {
    final petId = _actingPetId;
    if (petId == null) return null;
    final result = await _repo.createCommunity(
      leadPetId: petId,
      name: name,
      category: category,
      handle: handle,
      description: description,
      avatarAssetId: avatarAssetId,
      bannerAssetId: bannerAssetId,
    );
    return result.when(
      success: (community) {
        _ref.read(analyticsServiceProvider).logEvent(
          AnalyticsEvents.communityCreated,
          parameters: {'communityId': community.id, 'category': category.name},
        );
        _refreshDirectory();
        _ref.invalidate(myCommunitiesProvider);
        return community;
      },
      failure: (_) => null,
    );
  }

  /// Updates a community (lead only). Any non-null field is changed; nulls are
  /// left as-is. Returns the updated community, or null on failure. Refreshes
  /// the detail + directory so the new images/fields show immediately.
  Future<CommunityGroup?> update({
    required int communityId,
    String? name,
    String? handle,
    String? description,
    CommunityCategory? category,
    String? avatarAssetId,
    String? bannerAssetId,
  }) async {
    final result = await _repo.updateCommunity(
      communityId: communityId,
      name: name,
      handle: handle,
      description: description,
      category: category,
      avatarAssetId: avatarAssetId,
      bannerAssetId: bannerAssetId,
    );
    return result.when(
      success: (community) {
        _tryReplaceDirectory(community);
        try {
          _ref.read(communityDetailProvider(communityId).notifier).refresh();
        } catch (_) {}
        _ref.invalidate(myCommunitiesProvider);
        return community;
      },
      failure: (_) => null,
    );
  }

  /// Deletes [communityId] (lead only). Returns whether it succeeded.
  Future<bool> delete(int communityId) async {
    final result = await _repo.deleteCommunity(communityId: communityId);
    return result.when(
      success: (_) {
        _refreshDirectory();
        _ref.invalidate(myCommunitiesProvider);
        _ref.invalidate(suggestedCommunitiesProvider);
        return true;
      },
      failure: (_) => false,
    );
  }

  /// Removes another pet from [communityId] (lead only).
  Future<bool> removeMember({
    required int communityId,
    required int petId,
  }) async {
    final result = await _repo.removeMember(
      communityId: communityId,
      petId: petId,
    );
    return result.when(
      success: (_) {
        _ref.invalidate(communityMembersProvider(communityId));
        _ref.read(communityDetailProvider(communityId).notifier).refresh();
        return true;
      },
      failure: (_) => false,
    );
  }

  // ── Plumbing ──────────────────────────────────────────────────────────────

  /// Optimistically updates the directory row and detail header. [delta] nudges
  /// the member count; the server's real count arrives via [_reconcile].
  void _applyMembership(
    CommunityGroup community, {
    required bool isMember,
    required int delta,
  }) {
    final nextCount = (community.memberCount + delta).clamp(0, 1 << 30);
    _tryReplaceDirectory(
      community.copyWith(isMember: isMember, memberCount: nextCount),
    );
    _trySetDetail(community.id, isMember: isMember, memberCount: nextCount);
  }

  void _reconcile(int communityId, JoinResult r) {
    _trySetDetail(communityId, isMember: r.isMember, memberCount: r.memberCount);
  }

  void _tryReplaceDirectory(CommunityGroup updated) {
    try {
      _ref.read(communityDirectoryProvider.notifier).replace(updated);
    } catch (_) {
      // Directory not loaded — nothing to reconcile there.
    }
  }

  void _trySetDetail(
    int communityId, {
    required bool isMember,
    required int memberCount,
  }) {
    try {
      _ref.read(communityDetailProvider(communityId).notifier).setMembership(
            isMember: isMember,
            memberCount: memberCount,
          );
    } catch (_) {
      // Detail not loaded.
    }
  }

  void _refreshDirectory() {
    try {
      _ref.read(communityDirectoryProvider.notifier).refresh();
    } catch (_) {
      // Not loaded.
    }
  }
}
