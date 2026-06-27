// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadUrlRequest _$UploadUrlRequestFromJson(Map<String, dynamic> json) =>
    _UploadUrlRequest(
      category: (json['category'] as num).toInt(),
      contentType: json['contentType'] as String,
      fileName: json['fileName'] as String?,
      petId: (json['petId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UploadUrlRequestToJson(_UploadUrlRequest instance) =>
    <String, dynamic>{
      'category': instance.category,
      'contentType': instance.contentType,
      'fileName': instance.fileName,
      'petId': instance.petId,
    };

_UploadUrlResponse _$UploadUrlResponseFromJson(Map<String, dynamic> json) =>
    _UploadUrlResponse(
      assetId: json['assetId'] as String,
      uploadUrl: json['uploadUrl'] as String,
      objectKey: json['objectKey'] as String,
      contentType: json['contentType'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$UploadUrlResponseToJson(_UploadUrlResponse instance) =>
    <String, dynamic>{
      'assetId': instance.assetId,
      'uploadUrl': instance.uploadUrl,
      'objectKey': instance.objectKey,
      'contentType': instance.contentType,
      'expiresAt': instance.expiresAt.toIso8601String(),
    };

_MediaAsset _$MediaAssetFromJson(Map<String, dynamic> json) => _MediaAsset(
  id: json['id'] as String,
  category: (json['category'] as num).toInt(),
  contentType: json['contentType'] as String,
  sizeBytes: (json['sizeBytes'] as num).toInt(),
  originalFileName: json['originalFileName'] as String?,
  url: json['url'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$MediaAssetToJson(_MediaAsset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'contentType': instance.contentType,
      'sizeBytes': instance.sizeBytes,
      'originalFileName': instance.originalFileName,
      'url': instance.url,
      'createdAt': instance.createdAt.toIso8601String(),
    };
