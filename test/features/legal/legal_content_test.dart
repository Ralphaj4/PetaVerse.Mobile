import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petaverse_mobile/core/errors/app_exception.dart';
import 'package:petaverse_mobile/core/errors/failure.dart';
import 'package:petaverse_mobile/core/network/api_client.dart';
import 'package:petaverse_mobile/core/network/api_endpoints.dart';
import 'package:petaverse_mobile/features/legal/data/datasources/legal_remote_datasource.dart';
import 'package:petaverse_mobile/features/legal/data/repositories/legal_repository_impl.dart';
import 'package:petaverse_mobile/features/legal/domain/entities/legal.dart';

class _MockApiClient extends Mock implements ApiClient {}

void main() {
  late _MockApiClient client;
  late LegalRemoteDataSource datasource;
  late LegalRepositoryImpl repository;

  setUp(() {
    client = _MockApiClient();
    datasource = LegalRemoteDataSource(client);
    repository = LegalRepositoryImpl(remote: datasource);
  });

  const expectedPath = '/legal/PrivacyPolicy/1.0/content';

  final contentJson = <String, dynamic>{
    'documentType': 'PrivacyPolicy',
    'version': '1.0',
    'acceptanceKind': 'Acknowledgement',
    'body': '# Privacy Policy\n\nWe respect your data.',
    'contentHash': 'sha256-abc',
    'url': 'https://petaverseapp.com/privacy',
    'effectiveAt': '2026-10-05T00:00:00Z',
  };

  group('ApiEndpoints.legalContent', () {
    test('builds the PascalCase path with version segment', () {
      expect(ApiEndpoints.legalContent('PrivacyPolicy', '1.0'), expectedPath);
    });
  });

  group('LegalRemoteDataSource.getContent', () {
    test('hits the content endpoint and maps all seven fields', () async {
      when(() => client.get<Map<String, dynamic>>(expectedPath))
          .thenAnswer((_) async => contentJson);

      final dto = await datasource.getContent(
        type: LegalDocumentType.privacyPolicy,
        version: '1.0',
      );

      expect(dto.documentType, 'PrivacyPolicy');
      expect(dto.version, '1.0');
      expect(dto.acceptanceKind, 'Acknowledgement');
      expect(dto.body, '# Privacy Policy\n\nWe respect your data.');
      expect(dto.contentHash, 'sha256-abc');
      expect(dto.url, 'https://petaverseapp.com/privacy');
      expect(dto.effectiveAt, '2026-10-05T00:00:00Z');
      verify(() => client.get<Map<String, dynamic>>(expectedPath)).called(1);
    });
  });

  group('LegalRepositoryImpl.getContent', () {
    test('returns a mapped LegalContent entity on success', () async {
      when(() => client.get<Map<String, dynamic>>(expectedPath))
          .thenAnswer((_) async => contentJson);

      final result = await repository.getContent(
        type: LegalDocumentType.privacyPolicy,
        version: '1.0',
      );

      final content = result.valueOrNull;
      expect(content, isA<LegalContent>());
      expect(content!.documentType, LegalDocumentType.privacyPolicy);
      expect(content.acceptanceKind, LegalAcceptanceKind.acknowledgement);
      expect(content.body, contains('Privacy Policy'));
      expect(content.effectiveAt, DateTime.utc(2026, 10, 5));
    });

    test('maps a 404 (unpublished) to a NotFoundFailure, never throwing',
        () async {
      when(() => client.get<Map<String, dynamic>>(any()))
          .thenThrow(const NotFoundException('not found'));

      final result = await repository.getContent(
        type: LegalDocumentType.termsAndConditions,
        version: '9.9',
      );

      expect(result.isFailure, true);
      expect(result.failureOrNull, isA<NotFoundFailure>());
    });
  });
}
