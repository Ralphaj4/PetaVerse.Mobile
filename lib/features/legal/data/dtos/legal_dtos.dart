import '../../domain/entities/legal.dart';

/// Manual DTOs for the legal API (no freezed - these are simple read models,
/// matching the app-config convention). Each maps 1:1 to the backend shape and
/// exposes a [toEntity] for the repository.

// ── GET /legal/status (and the POST /legal/accept response) ──────────────────

class LegalStatusItemDto {
  const LegalStatusItemDto({
    required this.documentType,
    required this.currentVersion,
    required this.acceptedVersion,
    required this.requiresAction,
  });

  final String? documentType;
  final String? currentVersion;
  final String? acceptedVersion;
  final bool requiresAction;

  factory LegalStatusItemDto.fromJson(Map<String, dynamic> j) =>
      LegalStatusItemDto(
        documentType: j['documentType'] as String?,
        currentVersion: j['currentVersion'] as String?,
        acceptedVersion: j['acceptedVersion'] as String?,
        requiresAction: j['requiresAction'] as bool? ?? false,
      );

  LegalStatusItem toEntity() => LegalStatusItem(
        documentType: LegalDocumentType.fromWire(documentType),
        currentVersion: currentVersion,
        acceptedVersion: acceptedVersion,
        requiresAction: requiresAction,
      );
}

class LegalStatusDto {
  const LegalStatusDto({required this.items});

  final List<LegalStatusItemDto> items;

  factory LegalStatusDto.fromJson(Map<String, dynamic> j) {
    final rawItems = j['items'] as List<dynamic>? ?? const [];
    return LegalStatusDto(
      items: rawItems
          .map((e) => LegalStatusItemDto.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  LegalStatus toEntity() => LegalStatus(
        items: items.map((d) => d.toEntity()).toList(growable: false),
      );
}

// ── GET /legal/current ───────────────────────────────────────────────────────

class LegalDocumentDto {
  const LegalDocumentDto({
    required this.version,
    required this.url,
    required this.acceptanceKind,
    required this.contentHash,
    required this.effectiveAt,
  });

  final String version;
  final String url;
  final String? acceptanceKind;
  final String contentHash;
  final String? effectiveAt;

  factory LegalDocumentDto.fromJson(Map<String, dynamic> j) => LegalDocumentDto(
        version: j['version'] as String? ?? '',
        url: j['url'] as String? ?? '',
        acceptanceKind: j['acceptanceKind'] as String?,
        contentHash: j['contentHash'] as String? ?? '',
        effectiveAt: j['effectiveAt'] as String?,
      );

  LegalDocument toEntity() => LegalDocument(
        version: version,
        url: url,
        acceptanceKind: LegalAcceptanceKind.fromWire(acceptanceKind),
        contentHash: contentHash,
        effectiveAt:
            effectiveAt == null ? null : DateTime.tryParse(effectiveAt!),
      );
}

// ── GET /legal/{documentType}/{version}/content ──────────────────────────────

class LegalContentDto {
  const LegalContentDto({
    required this.documentType,
    required this.version,
    required this.acceptanceKind,
    required this.body,
    required this.contentHash,
    required this.url,
    required this.effectiveAt,
  });

  final String? documentType;
  final String version;
  final String? acceptanceKind;
  final String body;
  final String contentHash;
  final String url;
  final String? effectiveAt;

  factory LegalContentDto.fromJson(Map<String, dynamic> j) => LegalContentDto(
        documentType: j['documentType'] as String?,
        version: j['version'] as String? ?? '',
        acceptanceKind: j['acceptanceKind'] as String?,
        body: j['body'] as String? ?? '',
        contentHash: j['contentHash'] as String? ?? '',
        url: j['url'] as String? ?? '',
        effectiveAt: j['effectiveAt'] as String?,
      );

  LegalContent toEntity() => LegalContent(
        documentType: LegalDocumentType.fromWire(documentType),
        version: version,
        acceptanceKind: LegalAcceptanceKind.fromWire(acceptanceKind),
        body: body,
        contentHash: contentHash,
        url: url,
        effectiveAt:
            effectiveAt == null ? null : DateTime.tryParse(effectiveAt!),
      );
}

class LegalCurrentDto {
  const LegalCurrentDto({
    required this.privacyPolicy,
    required this.termsAndConditions,
    required this.communityGuidelines,
  });

  final LegalDocumentDto? privacyPolicy;
  final LegalDocumentDto? termsAndConditions;
  final LegalDocumentDto? communityGuidelines;

  static LegalDocumentDto? _doc(Object? raw) => raw is Map<String, dynamic>
      ? LegalDocumentDto.fromJson(raw)
      : null;

  factory LegalCurrentDto.fromJson(Map<String, dynamic> j) => LegalCurrentDto(
        privacyPolicy: _doc(j['privacyPolicy']),
        termsAndConditions: _doc(j['termsAndConditions']),
        communityGuidelines: _doc(j['communityGuidelines']),
      );

  LegalDocuments toEntity() => LegalDocuments(
        privacyPolicy: privacyPolicy?.toEntity(),
        termsAndConditions: termsAndConditions?.toEntity(),
        communityGuidelines: communityGuidelines?.toEntity(),
      );
}
