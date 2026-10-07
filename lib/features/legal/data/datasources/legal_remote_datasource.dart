import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/entities/legal.dart';
import '../dtos/legal_dtos.dart';

/// Remote legal data source. Talks to the API exclusively through [ApiClient];
/// never touches Dio directly. Throws AppExceptions (mapped by ApiClient) - the
/// repository turns those into Failures.
class LegalRemoteDataSource {
  const LegalRemoteDataSource(this._client);

  final ApiClient _client;

  /// GET /legal/status → the signed-in user's per-document acceptance status.
  /// The auth header is added automatically by the AuthInterceptor.
  Future<LegalStatusDto> getStatus() async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.legalStatus,
    );
    return LegalStatusDto.fromJson(data);
  }

  /// GET /legal/current → current published versions + metadata (public).
  Future<LegalCurrentDto> getCurrent() async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.legalCurrent,
    );
    return LegalCurrentDto.fromJson(data);
  }

  /// GET /legal/{documentType}/{version}/content → the full renderable document
  /// (markdown body + metadata) for one published version (public). Unknown or
  /// unpublished versions return 404.
  Future<LegalContentDto> getContent({
    required LegalDocumentType type,
    required String version,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.legalContent(type.wireName, version),
    );
    return LegalContentDto.fromJson(data);
  }

  /// POST /legal/accept → refreshed LegalStatus. The backend validates the
  /// version and is idempotent per (user, version); we just post and use the
  /// returned status.
  Future<LegalStatusDto> accept({
    required LegalDocumentType type,
    required String version,
  }) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.legalAccept,
      data: {
        'documentType': type.wireName,
        'version': version,
      },
    );
    return LegalStatusDto.fromJson(data);
  }
}
