import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/community_entities.dart';
import 'community_providers.dart';

part 'community_comments_providers.g.dart';

/// The comment thread for a post. Top-level comments carry their replies
/// inline. Supports paginated loading and optimistic add / like / pin.
@riverpod
class PostComments extends _$PostComments {
  @override
  Future<CommentPage> build(int postId) async {
    final result = await ref.read(communityRepositoryProvider).getComments(
          postId: postId,
          viewerPetId: ref.watch(actingPetIdProvider),
        );
    return result.when(success: (p) => p, failure: (f) => throw f);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.cursor.hasMore) return;
    final result = await ref.read(communityRepositoryProvider).getComments(
          postId: postId,
          viewerPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        CommentPage(
          comments: [...current.comments, ...page.comments],
          cursor: page.cursor,
        ),
      ),
      failure: (_) {},
    );
  }

  /// Posts a comment (or a reply when [parentCommentId] is set). Returns the
  /// created comment, or null with [Failure] surfaced via [state] on error.
  Future<Comment?> add(String body, {int? parentCommentId}) async {
    final actingPetId = ref.read(actingPetIdProvider);
    if (actingPetId == null) return null;

    final result = await ref.read(communityRepositoryProvider).addComment(
          postId: postId,
          authorPetId: actingPetId,
          body: body,
          parentCommentId: parentCommentId,
        );
    return result.when(
      success: (comment) {
        _insert(comment, parentCommentId: parentCommentId);
        ref.read(analyticsServiceProvider).logEvent(
          'CommentAdded',
          parameters: {'postId': postId, 'isReply': parentCommentId != null},
        );
        return comment;
      },
      failure: (_) => null,
    );
  }

  void _insert(Comment comment, {int? parentCommentId}) {
    final current = state.value;
    if (current == null) return;
    if (parentCommentId == null) {
      state = AsyncData(
        CommentPage(
          comments: [...current.comments, comment],
          cursor: current.cursor,
        ),
      );
    } else {
      state = AsyncData(
        CommentPage(
          comments: [
            for (final c in current.comments)
              c.id == parentCommentId
                  ? c.copyWith(replies: [...c.replies, comment])
                  : c,
          ],
          cursor: current.cursor,
        ),
      );
    }
  }

  /// Toggles a like on a top-level comment (optimistic).
  Future<void> toggleLike(Comment comment) async {
    final actingPetId = ref.read(actingPetIdProvider);
    if (actingPetId == null) return;
    final repo = ref.read(communityRepositoryProvider);
    final result = comment.likedByMe
        ? await repo.unlikeComment(
            commentId: comment.id, actingPetId: actingPetId)
        : await repo.likeComment(
            commentId: comment.id, actingPetId: actingPetId);
    result.when(
      success: (likes) => _replace(
        comment.copyWith(likes: likes, likedByMe: !comment.likedByMe),
      ),
      failure: (_) {},
    );
  }

  /// Pins / unpins a comment (post author only, one pinned per post).
  Future<void> togglePin(Comment comment) async {
    final actingPetId = ref.read(actingPetIdProvider);
    if (actingPetId == null) return;
    final result = await ref.read(communityRepositoryProvider).pinComment(
          commentId: comment.id,
          actingPetId: actingPetId,
          pin: !comment.isPinned,
        );
    result.when(
      success: (isPinned) {
        final current = state.value;
        if (current == null) return;
        // Only one pinned comment per post: clear any other pin.
        state = AsyncData(
          CommentPage(
            comments: [
              for (final c in current.comments)
                c.id == comment.id
                    ? c.copyWith(isPinned: isPinned)
                    : c.copyWith(isPinned: false),
            ],
            cursor: current.cursor,
          ),
        );
      },
      failure: (_) {},
    );
  }

  void _replace(Comment updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      CommentPage(
        comments: [
          for (final c in current.comments)
            c.id == updated.id
                ? updated
                : c.copyWith(
                    replies: [
                      for (final r in c.replies)
                        r.id == updated.id ? updated : r,
                    ],
                  ),
        ],
        cursor: current.cursor,
      ),
    );
  }
}
