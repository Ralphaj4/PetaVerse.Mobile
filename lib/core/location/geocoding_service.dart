import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../errors/app_exception.dart';
import '../errors/failure.dart';
import '../errors/result.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';

part 'geocoding_service.g.dart';

/// Reverse geocoding: coordinates → a human-readable street address.
///
/// Calls our backend `GET /geocode/reverse` (which proxies a geocoding
/// provider server-side, keeping the API key off the device). Returns a
/// [Result] — exceptions never cross this boundary; callers degrade gracefully
/// (e.g. leave the address field untouched) on failure.
class GeocodingService {
  const GeocodingService(this._client);

  final ApiClient _client;

  /// Resolves [latitude]/[longitude] to a single address line, e.g.
  /// "Baddour, Rue Élias Baaklini, Achrafieh 1100, Lebanon".
  ///
  /// A 404 (no address found) maps to [NotFoundFailure]; a 502 (provider
  /// failure/timeout) to [ServerFailure]; a 400 to [ValidationFailure].
  Future<Result<String>> reverse({
    required double latitude,
    required double longitude,
  }) async {
    try {
      // ignore: avoid_print
      print('[geocode] GET ${ApiEndpoints.geocodeReverse} '
          'lat=$latitude lng=$longitude');
      final data = await _client.get<Map<String, dynamic>>(
        ApiEndpoints.geocodeReverse,
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );
      // ignore: avoid_print
      print('[geocode] response data=$data');
      final address = (data['address'] as String?)?.trim();
      if (address == null || address.isEmpty) {
        return const Result.failure(
          NotFoundFailure(message: 'No address found'),
        );
      }
      return Result.success(address);
    } on AppException catch (e) {
      // ignore: avoid_print
      print('[geocode] AppException: ${e.runtimeType} — ${e.message}');
      return Result.failure(_mapFailure(e));
    } catch (e) {
      // ignore: avoid_print
      print('[geocode] UNEXPECTED error: ${e.runtimeType} — $e');
      rethrow;
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
}

@Riverpod(keepAlive: true)
GeocodingService geocodingService(Ref ref) =>
    GeocodingService(ref.watch(apiClientProvider));
