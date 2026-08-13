import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/analytics/analytics_events.dart';
import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/dtos/media_dtos.dart';
import '../../../../core/network/providers/media_datasource_provider.dart';
import '../../../../core/services/media_upload_service.dart';
import '../../domain/entities/community_enums.dart';
import '../../domain/repositories/community_repository.dart';
import 'community_feed_providers.dart';
import 'community_group_feed_providers.dart';
import 'community_providers.dart';
import 'create_post_provider.dart' show DraftMedia;

/// Immutable payload describing a post to publish. Built by the composer and
/// handed to [PostUploadQueue.enqueue] so uploading can outlive the composer.
class PostDraft {
  const PostDraft({
    required this.authorPetId,
    required this.media,
    this.caption,
    this.locationName,
    this.visibility = PostVisibility.public,
    this.taggedPetIds = const [],
    this.hashtags = const [],
    this.communityId,
  });

  final int authorPetId;
  final List<DraftMedia> media;
  final String? caption;
  final String? locationName;
  final PostVisibility visibility;
  final List<int> taggedPetIds;
  final List<String> hashtags;
  final int? communityId;

  /// A local file to show as the job's preview thumbnail (first image, else the
  /// first media file — a video's frame isn't extracted here).
  File? get thumbnailFile {
    if (media.isEmpty) return null;
    final image = media.where((m) => !m.isVideo);
    final chosen = image.isNotEmpty ? image.first : media.first;
    return chosen.file;
  }
}

enum PostUploadStatus { uploading, creating, success, failed }

/// One in-flight (or finished) post upload shown by the progress banner.
class PostUploadJob {
  const PostUploadJob({
    required this.id,
    required this.draft,
    this.status = PostUploadStatus.uploading,
    this.progress = 0,
    this.failure,
  });

  final String id;
  final PostDraft draft;
  final PostUploadStatus status;

  /// 0.0–1.0 aggregate upload fraction across all media (byte-weighted).
  final double progress;
  final Failure? failure;

  bool get isVideo => draft.media.any((m) => m.isVideo);

  PostUploadJob copyWith({
    PostUploadStatus? status,
    double? progress,
    Failure? failure,
  }) =>
      PostUploadJob(
        id: id,
        draft: draft,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        failure: failure,
      );
}

/// App-scoped queue that uploads post media in the background and creates the
/// post, so the composer can pop immediately. Drives the global progress
/// banner. In-process only — a job does not survive the app being killed.
final postUploadQueueProvider =
    NotifierProvider<PostUploadQueue, List<PostUploadJob>>(PostUploadQueue.new);

class PostUploadQueue extends Notifier<List<PostUploadJob>> {
  int _seq = 0;

  @override
  List<PostUploadJob> build() => const [];

  /// Queue [draft] and start uploading immediately (fire-and-forget).
  void enqueue(PostDraft draft) {
    final job = PostUploadJob(id: 'upload_${_seq++}', draft: draft);
    state = [...state, job];
    unawaited(_run(job.id));
  }

  /// Retry a failed job.
  void retry(String id) {
    _patch(id, (j) => j.copyWith(
          status: PostUploadStatus.uploading,
          progress: 0,
          failure: null,
        ));
    unawaited(_run(id));
  }

  /// Remove a job from the banner (dismiss a finished/failed one).
  void dismiss(String id) =>
      state = state.where((j) => j.id != id).toList(growable: false);

  // ── Internals ───────────────────────────────────────────────────────────

  PostUploadJob? _find(String id) {
    for (final j in state) {
      if (j.id == id) return j;
    }
    return null;
  }

  void _patch(String id, PostUploadJob Function(PostUploadJob) f) {
    state = [
      for (final j in state) j.id == id ? f(j) : j,
    ];
  }

  Future<void> _run(String id) async {
    final job = _find(id);
    if (job == null) return;
    final draft = job.draft;

    final uploader = MediaUploadService(ref.read(mediaDatasourceProvider));

    // Byte-weight progress so a large video dominates the bar correctly.
    final sizes = <int>[];
    for (final m in draft.media) {
      sizes.add(await _safeLength(m.file));
    }
    final totalBytes = sizes.fold<int>(0, (a, b) => a + b);
    final sentBytes = List<int>.filled(draft.media.length, 0);

    void report() {
      if (totalBytes <= 0) return;
      final sent = sentBytes.fold<int>(0, (a, b) => a + b);
      _patch(id, (j) => j.copyWith(progress: (sent / totalBytes).clamp(0, 1)));
    }

    // Step 1: upload each file, collecting confirmed asset ids. For a video
    // with a user-chosen cover image, upload that too and attach its id as the
    // thumbnail. Progress weighting covers the main files only — the small
    // cover JPEGs don't move the bar meaningfully.
    final drafts = <PostMediaDraft>[];
    for (var i = 0; i < draft.media.length; i++) {
      final m = draft.media[i];
      final result = await uploader.uploadFile(
        file: m.file,
        contentType: m.contentType,
        category: MediaCategory.post,
        petId: draft.authorPetId,
        onProgress: (fraction) {
          sentBytes[i] = (fraction * sizes[i]).round();
          report();
        },
      );
      final asset = result.when(success: (a) => a, failure: (_) => null);
      if (asset == null) {
        _patch(
          id,
          (j) => j.copyWith(
            status: PostUploadStatus.failed,
            failure: result.failureOrNull ??
                const ServerFailure(message: 'Media upload failed'),
          ),
        );
        return;
      }
      sentBytes[i] = sizes[i]; // fully uploaded
      report();

      // Upload the optional cover image as a separate asset. A failed cover
      // upload doesn't fail the post — we just omit the thumbnail.
      String? thumbnailAssetId;
      final thumb = m.thumbnailFile;
      if (thumb != null) {
        final thumbResult = await uploader.uploadFile(
          file: thumb,
          contentType: 'image/jpeg',
          category: MediaCategory.post,
          petId: draft.authorPetId,
        );
        thumbnailAssetId =
            thumbResult.when(success: (a) => a.id, failure: (_) => null);
      }

      drafts.add(PostMediaDraft(
        mediaAssetId: asset.id,
        altText: m.altText,
        durationSeconds: m.durationSeconds,
        thumbnailAssetId: thumbnailAssetId,
      ));
    }

    // Step 2: create the post.
    _patch(id, (j) => j.copyWith(status: PostUploadStatus.creating));
    final result = await ref.read(communityRepositoryProvider).createPost(
          authorPetId: draft.authorPetId,
          caption: draft.caption,
          locationName: draft.locationName,
          visibility: draft.visibility,
          media: drafts,
          taggedPetIds: draft.taggedPetIds,
          hashtags: draft.hashtags,
          communityId: draft.communityId,
        );

    result.when(
      success: (post) {
        _patch(id, (j) => j.copyWith(
              status: PostUploadStatus.success,
              progress: 1,
            ));
        ref.read(analyticsServiceProvider).logEvent(
          AnalyticsEvents.postCreated,
          parameters: {
            'postId': post.id,
            'mediaCount': drafts.length,
            'hasCaption': (draft.caption ?? '').isNotEmpty,
          },
        );
        // Surface the new post: refresh the following feed, and the community
        // feed if it was posted into one.
        _refreshFeeds(draft.communityId);
        // Auto-dismiss the success chip shortly after.
        Future.delayed(const Duration(seconds: 3), () {
          if (_find(id)?.status == PostUploadStatus.success) dismiss(id);
        });
      },
      failure: (f) =>
          _patch(id, (j) => j.copyWith(status: PostUploadStatus.failed, failure: f)),
    );
  }

  void _refreshFeeds(int? communityId) {
    try {
      ref.read(followingFeedProvider.notifier).refresh();
    } catch (_) {}
    if (communityId != null) {
      try {
        ref.read(communityFeedProvider(communityId).notifier).refresh();
      } catch (_) {}
    }
  }

  Future<int> _safeLength(File f) async {
    try {
      return await f.length();
    } catch (_) {
      return 0;
    }
  }
}
