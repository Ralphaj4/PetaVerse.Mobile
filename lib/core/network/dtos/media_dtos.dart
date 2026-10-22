import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_dtos.freezed.dart';
part 'media_dtos.g.dart';

/// Media categories. The ordinals MUST match the backend `MediaCategory`
/// enum exactly - the API serializes/deserializes this as an integer
/// (default System.Text.Json, no string converter), so we send/read the
/// ordinal via `.index`.
enum MediaCategory {
  @JsonValue(0)
  userAvatar,
  @JsonValue(1)
  petAvatar,
  @JsonValue(2)
  story,
  @JsonValue(3)
  post,
  @JsonValue(4)
  petDocument,
  @JsonValue(5)
  petReport,
  @JsonValue(6)
  adoptionListingPhoto,
  @JsonValue(7)
  communityAvatar,
  @JsonValue(8)
  communityBanner,
}

@freezed
abstract class UploadUrlRequest with _$UploadUrlRequest {
  const factory UploadUrlRequest({
    required int category,
    required String contentType,
    String? fileName,
    // Required by the backend for petAvatar/petDocument categories; the pet
    // must already exist and be owned by the caller.
    int? petId,
    // Declared size of the file about to be uploaded. The backend uses this to
    // reject oversized uploads before issuing a signed URL, and to sign the PUT
    // with a Content-Length condition (closing the presigned-URL bypass). Sent
    // forward-compatibly: a backend that ignores unknown fields is unaffected.
    int? sizeBytes,
    // Video duration in whole seconds (null for images). Lets the backend reject
    // over-length videos at URL-issue time rather than only at post-creation.
    int? durationSeconds,
  }) = _UploadUrlRequest;

  factory UploadUrlRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadUrlRequestFromJson(json);
}

@freezed
abstract class UploadUrlResponse with _$UploadUrlResponse {
  const factory UploadUrlResponse({
    required String assetId,
    required String uploadUrl,
    required String objectKey,
    required String contentType,
    required DateTime expiresAt,
  }) = _UploadUrlResponse;

  factory UploadUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadUrlResponseFromJson(json);
}

@freezed
abstract class MediaAsset with _$MediaAsset {
  const factory MediaAsset({
    required String id,
    required int category,
    required String contentType,
    required int sizeBytes,
    String? originalFileName,
    required String url,
    required DateTime createdAt,
  }) = _MediaAsset;

  factory MediaAsset.fromJson(Map<String, dynamic> json) =>
      _$MediaAssetFromJson(json);
}
