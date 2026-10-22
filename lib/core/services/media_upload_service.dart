import 'dart:io';

import '../errors/failure.dart';
import '../errors/result.dart';
import '../media/media_constraints.dart';
import '../media/media_validator.dart';
import '../network/datasources/media_datasource.dart';
import '../network/dtos/media_dtos.dart';

class MediaUploadService {
  final IMediaDatasource _datasource;

  MediaUploadService(this._datasource);

  /// Upload a file with automatic retry on confirm failure.
  /// Returns the confirmed asset or a failure.
  ///
  /// This is the single funnel every feature uploads through, so it is also the
  /// last-line validation guard: the file is checked against [MediaConstraints]
  /// here even if a pick site forgot to, and the real content type is detected
  /// (never a hardcoded guess) so the signed R2 PUT can't mismatch. The declared
  /// size is forwarded to the backend so it can reject oversized uploads and
  /// sign a bounded PUT.
  ///
  /// [contentType] may be passed to force a type; when null it is detected from
  /// the file. [isVideo] selects the video vs image rule set (videos aren't
  /// compressed, only bounded). [durationSeconds] enables the video length cap.
  ///
  /// [onProgress] (0.0–1.0) reports the R2 upload fraction for this file.
  Future<Result<MediaAsset>> uploadFile({
    required File file,
    required MediaCategory category,
    String? contentType,
    bool isVideo = false,
    int? durationSeconds,
    String? fileName,
    int? petId,
    void Function(double fraction)? onProgress,
  }) async {
    // ── Guard: validate before spending a round-trip on the upload URL ───────
    final validation = isVideo
        ? MediaValidator.validateVideo(file, category,
            durationSeconds: durationSeconds)
        : MediaValidator.validateImage(file, category);

    if (validation is! MediaValid) {
      return Result.failure(_validationFailure(validation));
    }

    final resolvedContentType = contentType ?? validation.contentType;
    final int sizeBytes;
    try {
      sizeBytes = await file.length();
    } catch (_) {
      return const Result.failure(
        ServerFailure(message: 'Could not read media file'),
      );
    }

    // Step 1: Get upload URL
    final urlResult = await _datasource.getUploadUrl(
      UploadUrlRequest(
        category: category.index,
        contentType: resolvedContentType,
        fileName: fileName,
        petId: petId,
        sizeBytes: sizeBytes,
        // Only meaningful for videos; null for images so the backend skips the
        // duration check.
        durationSeconds: isVideo ? durationSeconds : null,
      ),
    );

    return urlResult.when(
      success: (uploadUrlResponse) async {
        // Step 2: Upload bytes to R2
        final uploadResult = await _datasource.uploadToR2(
          uploadUrlResponse.uploadUrl,
          file,
          resolvedContentType,
          onProgress: onProgress == null
              ? null
              : (sent, total) {
                  if (total > 0) onProgress(sent / total);
                },
        );

        return uploadResult.when(
          success: (_) async {
            // Step 3: Confirm with retries (idempotent, so safe to retry)
            return _confirmWithRetry(
              uploadUrlResponse.assetId,
              maxAttempts: 3,
            );
          },
          failure: (f) => Result.failure(f),
        );
      },
      failure: (f) => Result.failure(f),
    );
  }

  /// Maps a client-side validation failure to a [ValidationFailure] carrying a
  /// key the UI can localize. The human message is produced at the call site via
  /// the validation's own `localizedMessage`; here we only need a typed failure.
  Failure _validationFailure(MediaValidation v) {
    final limit = switch (v) {
      MediaTooLarge(:final limitBytes) =>
        'max ${(limitBytes / (1024 * 1024)).toStringAsFixed(0)}MB',
      MediaVideoTooLong(:final limitSeconds) => 'max ${limitSeconds}s',
      MediaUnsupportedFormat() => 'unsupported format',
      MediaValid() => '',
    };
    return ValidationFailure(message: 'Media rejected: $limit');
  }

  /// Confirm an upload with exponential backoff retry.
  /// Called automatically by uploadFile, but can also be used
  /// if the app crashes between upload and confirm.
  Future<Result<MediaAsset>> _confirmWithRetry(
    String assetId, {
    int maxAttempts = 3,
  }) async {
    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      final result = await _datasource.confirmUpload(assetId);

      if (result.when(success: (_) => true, failure: (_) => false)) {
        return result;
      }

      // If it's the last attempt, return the failure
      if (attempt == maxAttempts) {
        return result;
      }

      // Wait before retry (100ms, 200ms, 400ms)
      await Future.delayed(Duration(milliseconds: 100 * attempt));
    }

    return const Result.failure(ServerFailure(message: 'Confirm failed'));
  }
}
