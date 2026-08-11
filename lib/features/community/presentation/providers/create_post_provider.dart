import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../domain/entities/community_entities.dart';
import '../../domain/entities/community_enums.dart';
import '../../domain/repositories/community_repository.dart';
import 'community_feed_providers.dart';
import 'community_providers.dart';

part 'create_post_provider.g.dart';

/// A local media item queued for a new post: the picked file plus its
/// per-item metadata. Turned into a confirmed `mediaAssetId` at publish time.
class DraftMedia {
  const DraftMedia({
    required this.file,
    required this.contentType,
    this.altText,
    this.durationSeconds,
  });

  final File file;
  final String contentType;
  final String? altText;
  final int? durationSeconds;

  bool get isVideo => contentType.startsWith('video/');
}

/// Publishes a new post: uploads each media file through the presign/confirm
/// flow, then creates the post with the confirmed asset ids.
///
/// `keepAlive` so the notifier isn't disposed mid-publish (which would hang the
/// returned Future).
@Riverpod(keepAlive: true)
class CreatePost extends _$CreatePost {
  @override
  FutureOr<void> build() {}

  /// The failure from the most recent attempt, or null if it succeeded.
  Failure? get lastFailure {
    final err = state.error;
    return err is Failure ? err : null;
  }

  Future<Post?> publish({
    required int authorPetId,
    String? caption,
    String? locationName,
    PostVisibility visibility = PostVisibility.public,
    List<DraftMedia> media = const [],
    List<int> taggedPetIds = const [],
    List<String> hashtags = const [],
    int? communityId,
  }) async {
    state = const AsyncLoading();

    // Step 1: upload every media file, collecting confirmed asset ids.
    final uploader = MediaUploadService(ref.read(mediaDatasourceProvider));
    final drafts = <PostMediaDraft>[];
    for (final m in media) {
      final result = await uploader.uploadFile(
        file: m.file,
        contentType: m.contentType,
        category: MediaCategory.post,
        petId: authorPetId,
      );
      final asset = result.when(success: (a) => a, failure: (_) => null);
      if (asset == null) {
        final f = result.failureOrNull ??
            const ServerFailure(message: 'Media upload failed');
        state = AsyncError(f, StackTrace.current);
        return null;
      }
      drafts.add(
        PostMediaDraft(
          mediaAssetId: asset.id,
          altText: m.altText,
          durationSeconds: m.durationSeconds,
        ),
      );
    }

    // Step 2: create the post.
    final result = await ref.read(communityRepositoryProvider).createPost(
          authorPetId: authorPetId,
          caption: caption,
          locationName: locationName,
          visibility: visibility,
          media: drafts,
          taggedPetIds: taggedPetIds,
          hashtags: hashtags,
          communityId: communityId,
        );

    return result.when(
      success: (post) {
        state = const AsyncData(null);
        ref.read(analyticsServiceProvider).logEvent(
          'PostCreated',
          parameters: {
            'postId': post.id,
            'mediaCount': drafts.length,
            'hasCaption': (caption ?? '').isNotEmpty,
          },
        );
        // Surface the new post at the top of the following feed.
        ref.read(followingFeedProvider.notifier).refresh();
        return post;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
    );
  }
}
