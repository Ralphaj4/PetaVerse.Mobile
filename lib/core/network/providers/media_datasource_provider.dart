import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api_client.dart';
import '../datasources/media_datasource.dart';

part 'media_datasource_provider.g.dart';

@Riverpod(keepAlive: true)
IMediaDatasource mediaDatasource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  // Create a bare Dio for R2 uploads (no interceptors)
  final rawDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
  return MediaDatasource(apiClient: apiClient, rawDio: rawDio);
}
