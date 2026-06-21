import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_dtos.freezed.dart';
part 'media_dtos.g.dart';

enum MediaCategory {
  @JsonValue(0)
  avatar,
  @JsonValue(1)
  story,
  @JsonValue(2)
  post,
  @JsonValue(3)
  petDocument,
}

@freezed
abstract class UploadUrlRequest with _$UploadUrlRequest {
  const factory UploadUrlRequest({
    required int category,
    required String contentType,
    String? fileName,
    int? entityId,
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
