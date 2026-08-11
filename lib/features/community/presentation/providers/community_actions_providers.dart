import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/analytics/analytics_service.dart';
import '../../domain/entities/community_entities.dart';
import '../../domain/entities/community_enums.dart';
import '../../domain/repositories/community_repository.dart';
import 'community_feed_providers.dart';
import 'community_providers.dart';

part 'community_actions_providers.g.dart';

/// Cross-cutting write actions for PawHub (like, save, share, follow, block,
/// report, post CRUD). Each mutates the server then reconciles the loaded
/// feeds so every screen showing the post updates at once.
///
/// Read as a plain object (`ref.read(communityActionsProvider)`) and call its
/// methods; it holds no state of its own.
@Riverpod(keepAlive: true)
CommunityActions communityActions(Ref ref) => CommunityActions(ref);

class CommunityActions {
  CommunityActions(this._ref);

  final Ref _ref;

  CommunityRepository get _repo => _ref.read(communityRepositoryProvider);
  int? get _actingPetId => _ref.read(actingPetIdProvider);

  void _propagate(Post post) {
    _ref.read(followingFeedProvider.notifier).replacePost(post);
    _ref.read(discoverFeedProvider.notifier).replacePost(post);
  }

  // ── Likes ────────────────────────────────────────────────────────────────

  /// Toggles a like on [post] and propagates the fresh counts to every feed.
  Future<void> toggleLike(Post post) async {
    final petId = _actingPetId;
    if (petId == null) return;
    final result = post.likedByMe
        ? await _repo.unlikePost(postId: post.id, actingPetId: petId)
        : await _repo.likePost(postId: post.id, actingPetId: petId);
    result.when(
      success: (updated) {
        _propagate(updated);
        if (!post.likedByMe) {
          _ref.read(analyticsServiceProvider).logEvent(
            'PostLiked',
            parameters: {'postId': post.id},
          );
        }
      },
      failure: (_) {},
    );
  }

  // ── Saves ────────────────────────────────────────────────────────────────

  /// Toggles the bookmark on [post]. Refreshes the saved list on change.
  Future<bool> toggleSave(Post post) async {
    final petId = _actingPetId;
    if (petId == null) return post.saved;
    final result = post.saved
        ? await _repo.unsavePost(postId: post.id, actingPetId: petId)
        : await _repo.savePost(postId: post.id, actingPetId: petId);
    return result.when(
      success: (r) {
        _propagate(post.copyWith(saved: r.saved));
        _ref.invalidate(savedPostsProvider);
        return r.saved;
      },
      failure: (_) => post.saved,
    );
  }

  // ── Share ────────────────────────────────────────────────────────────────

  /// Records a share and returns the deep link to copy, or null on failure.
  Future<String?> share(Post post, {String? shareMethod}) async {
    final petId = _actingPetId;
    if (petId == null) return null;
    final result = await _repo.sharePost(
      postId: post.id,
      actingPetId: petId,
      shareMethod: shareMethod,
    );
    return result.when(
      success: (r) {
        _ref.read(analyticsServiceProvider).logEvent(
          'PostShared',
          parameters: {'postId': post.id, 'method': shareMethod ?? 'unknown'},
        );
        return r.shareUrl;
      },
      failure: (_) => null,
    );
  }

  // ── Follows ──────────────────────────────────────────────────────────────

  /// Follows / unfollows [pet]. Returns the new follow state.
  Future<bool> toggleFollow(CommunityPet pet) async {
    final petId = _actingPetId;
    if (petId == null) return pet.isFollowing;
    final result = pet.isFollowing
        ? await _repo.unfollow(petId: pet.id, followerPetId: petId)
        : await _repo.follow(petId: pet.id, followerPetId: petId);
    return result.when(
      success: (r) {
        if (!pet.isFollowing) {
          _ref.read(analyticsServiceProvider).logEvent(
            'PetFollowed',
            parameters: {'petId': pet.id},
          );
        }
        // A follow change alters both feeds' membership — refresh them.
        _ref.read(followingFeedProvider.notifier).refresh();
        _ref.invalidate(suggestedPetsProvider);
        return r.isFollowing;
      },
      failure: (_) => pet.isFollowing,
    );
  }

  // ── Moderation ───────────────────────────────────────────────────────────

  Future<bool> block(int petId) async {
    final actingPetId = _actingPetId;
    if (actingPetId == null) return false;
    final result = await _repo.block(petId: petId, blockerPetId: actingPetId);
    return result.when(
      success: (r) {
        // Blocking tears down follows and hides content both ways — refresh.
        _ref.read(followingFeedProvider.notifier).refresh();
        _ref.read(discoverFeedProvider.notifier).refresh();
        return r.blocked;
      },
      failure: (_) => false,
    );
  }

  Future<bool> reportPost(
    int postId,
    ReportReason reason, {
    String? details,
  }) async {
    final result = await _repo.reportPost(
      postId: postId,
      reason: reason,
      reporterPetId: _actingPetId,
      details: details,
    );
    return result.when(success: (_) => true, failure: (_) => false);
  }

  Future<bool> reportPet(
    int petId,
    ReportReason reason, {
    String? details,
  }) async {
    final result = await _repo.reportPet(
      petId: petId,
      reason: reason,
      reporterPetId: _actingPetId,
      details: details,
    );
    return result.when(success: (_) => true, failure: (_) => false);
  }

  Future<bool> reportComment(
    int commentId,
    ReportReason reason, {
    String? details,
  }) async {
    final result = await _repo.reportComment(
      commentId: commentId,
      reason: reason,
      reporterPetId: _actingPetId,
      details: details,
    );
    return result.when(success: (_) => true, failure: (_) => false);
  }

  // ── Post CRUD ────────────────────────────────────────────────────────────

  /// Deletes [postId] (author only) and drops it from the loaded feeds.
  Future<bool> deletePost(int postId) async {
    final result = await _repo.deletePost(postId);
    return result.when(
      success: (_) {
        // Drop the post from any feed that's currently loaded. Each read is
        // guarded so a disposed / errored feed provider can't abort the others
        // or bubble an exception back to the caller.
        _dropFromFeed(() => _ref.read(followingFeedProvider.notifier), postId);
        _dropFromFeed(() => _ref.read(myPostsProvider.notifier), postId);
        _dropFromFeed(() => _ref.read(savedPostsProvider.notifier), postId);
        return true;
      },
      failure: (_) => false,
    );
  }

  void _dropFromFeed(dynamic Function() readNotifier, int postId) {
    try {
      // ignore: avoid_dynamic_calls
      readNotifier().removePost(postId);
    } catch (_) {
      // Feed not loaded / disposed — nothing to drop there.
    }
  }

  // ── Comment CRUD ────────────────────────────────────────────────────────

  /// Edits a comment's body.
  Future<bool> editComment({
    required int commentId,
    required String body,
  }) async {
    final result = await _repo.updateComment(commentId: commentId, body: body);
    return result.when(success: (_) => true, failure: (_) => false);
  }

  /// Deletes a comment.
  Future<bool> deleteComment(int commentId) async {
    final result = await _repo.deleteComment(commentId);
    return result.when(success: (_) => true, failure: (_) => false);
  }
}
