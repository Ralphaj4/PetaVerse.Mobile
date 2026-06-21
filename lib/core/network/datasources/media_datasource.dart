import 'dart:io';

import 'package:dio/dio.dart';

import '../../errors/app_exception.dart';
import '../../errors/failure.dart';
import '../../errors/result.dart';
import '../api_client.dart';
import '../api_endpoints.dart';
import '../dtos/media_dtos.dart';

abstract class IMediaDatasource {
  Future<Result<UploadUrlResponse>> getUploadUrl(UploadUrlRequest request);
  Future<Result<void>> uploadToR2(String uploadUrl, File file, String contentType);
  Future<Result<MediaAsset>> confirmUpload(String assetId);
  Future<Result<MediaAsset>> getMedia(String assetId);
  Future<Result<void>> deleteMedia(String assetId);
}

class MediaDatasource implements IMediaDatasource {
  final ApiClient _apiClient;
  final Dio _rawDio;

  MediaDatasource({required ApiClient apiClient, required Dio rawDio})
      : _apiClient = apiClient,
        _rawDio = rawDio;

  @override
  Future<Result<UploadUrlResponse>> getUploadUrl(
    UploadUrlRequest request,
  ) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.mediaUploadUrl,
        data: request.toJson(),
      );
      final dto = UploadUrlResponse.fromJson(response);
      return Result.success(dto);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> uploadToR2(
    String uploadUrl,
    File file,
    String contentType,
  ) async {
    try {
      final fileBytes = await file.readAsBytes();
      // Use raw Dio without interceptors for R2 upload
      await _rawDio.put<void>(
        uploadUrl,
        data: fileBytes,
        options: Options(
          contentType: contentType, // Must match exactly
          headers: {
            'Content-Type': contentType,
          },
        ),
      );
      return const Result.success(null);
    } on DioException catch (e) {
      return Result.failure(_mapDioFailure(e));
    }
  }

  @override
  Future<Result<MediaAsset>> confirmUpload(String assetId) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.mediaConfirm(assetId),
      );
      final asset = MediaAsset.fromJson(response);
      return Result.success(asset);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<MediaAsset>> getMedia(String assetId) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.media(assetId),
      );
      final asset = MediaAsset.fromJson(response);
      return Result.success(asset);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<void>> deleteMedia(String assetId) async {
    try {
      await _apiClient.delete<void>(ApiEndpoints.media(assetId));
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  Failure _mapFailure(AppException e) => switch (e) {
        NetworkException() => NetworkFailure(message: e.message),
        UnauthorizedException() => UnauthorizedFailure(message: e.message),
        ForbiddenException() => ForbiddenFailure(message: e.message),
        NotFoundException() => NotFoundFailure(message: e.message),
        ValidationException() => ValidationFailure(
            message: e.message,
            fieldErrors: e.fieldErrors,
          ),
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };

  Failure _mapDioFailure(DioException e) {
    final status = e.response?.statusCode ?? 0;
    final message = e.message ?? 'Upload failed';

    if (status == 403 && message.contains('SignatureDoesNotMatch')) {
      return const ServerFailure(
        message: 'Content-Type mismatch or URL expired. Retry from step 1.',
      );
    }
    if (status >= 500) return const ServerFailure(message: 'Server error');
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      return const NetworkFailure(message: 'Upload failed: network error');
    }
    return const ServerFailure(message: 'Upload failed');
  }
}
