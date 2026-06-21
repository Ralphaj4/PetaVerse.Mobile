import 'dart:io';

import '../errors/failure.dart';
import '../errors/result.dart';
import '../network/datasources/media_datasource.dart';
import '../network/dtos/media_dtos.dart';

class MediaUploadService {
  final IMediaDatasource _datasource;

  MediaUploadService(this._datasource);

  /// Upload a file with automatic retry on confirm failure.
  /// Returns the confirmed asset or a failure.
  Future<Result<MediaAsset>> uploadFile({
    required File file,
    required String contentType,
    required MediaCategory category,
    String? fileName,
    int? entityId,
  }) async {
    // Step 1: Get upload URL
    final urlResult = await _datasource.getUploadUrl(
      UploadUrlRequest(
        category: category.index,
        contentType: contentType,
        fileName: fileName,
        entityId: entityId,
      ),
    );

    return urlResult.when(
      success: (uploadUrlResponse) async {
        // Step 2: Upload bytes to R2
        final uploadResult = await _datasource.uploadToR2(
          uploadUrlResponse.uploadUrl,
          file,
          contentType,
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
