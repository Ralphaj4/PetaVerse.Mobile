/// Domain entities for the versioned legal-document acceptance system.
///
/// The backend tracks, per user, which version of each legal document has been
/// accepted. When a document gains a newer published version the user must
/// re-accept it before continuing - the router gates on this.
library;

/// The kinds of legal document the platform versions.
///
/// The wire form (what the API sends/expects) is the PascalCase [wireName];
/// unknown values from the server degrade to [unknown] rather than throwing so
/// a backend addition can never crash an older client.
enum LegalDocumentType {
  privacyPolicy('PrivacyPolicy'),
  termsAndConditions('TermsAndConditions'),
  communityGuidelines('CommunityGuidelines'),
  unknown('');

  const LegalDocumentType(this.wireName);

  /// The exact string the API uses for this type.
  final String wireName;

  /// Parses the API's `documentType` string, falling back to [unknown].
  static LegalDocumentType fromWire(String? raw) {
    for (final type in values) {
      if (type.wireName == raw) return type;
    }
    return unknown;
  }
}

/// Whether a document is legally *agreed to* or merely *acknowledged*. Drives
/// the acceptance CTA wording ("I agree" vs "I understand").
enum LegalAcceptanceKind {
  agreement('Agreement'),
  acknowledgement('Acknowledgement'),
  unknown('');

  const LegalAcceptanceKind(this.wireName);

  final String wireName;

  static LegalAcceptanceKind fromWire(String? raw) {
    for (final kind in values) {
      if (kind.wireName == raw) return kind;
    }
    return unknown;
  }
}

/// One line of the user's acceptance status for a single document type.
class LegalStatusItem {
  const LegalStatusItem({
    required this.documentType,
    required this.currentVersion,
    required this.acceptedVersion,
    required this.requiresAction,
  });

  final LegalDocumentType documentType;

  /// Latest published version, or null if the server has none.
  final String? currentVersion;

  /// Version the user last accepted, or null if they never have.
  final String? acceptedVersion;

  /// True when the user must (re-)accept before proceeding.
  final bool requiresAction;
}

/// The full acceptance status across every document type (GET /legal/status).
class LegalStatus {
  const LegalStatus({required this.items});

  final List<LegalStatusItem> items;

  /// Documents the user must act on before continuing, skipping [unknown]
  /// types the client doesn't recognize (it has no screen for them).
  List<LegalStatusItem> get pending => items
      .where((i) =>
          i.requiresAction && i.documentType != LegalDocumentType.unknown)
      .toList(growable: false);

  /// True when at least one recognized document needs the user's action.
  bool get requiresAction => pending.isNotEmpty;
}

/// Metadata for the current published version of one document
/// (part of GET /legal/current).
class LegalDocument {
  const LegalDocument({
    required this.version,
    required this.url,
    required this.acceptanceKind,
    required this.contentHash,
    required this.effectiveAt,
  });

  final String version;
  final String url;
  final LegalAcceptanceKind acceptanceKind;
  final String contentHash;
  final DateTime? effectiveAt;
}

/// The full renderable content of one published document version
/// (GET /legal/{documentType}/{version}/content).
///
/// [body] is markdown with any frontmatter already stripped by the backend, so
/// the client renders it as-is. Shown in-app at the consent gate.
class LegalContent {
  const LegalContent({
    required this.documentType,
    required this.version,
    required this.acceptanceKind,
    required this.body,
    required this.contentHash,
    required this.url,
    required this.effectiveAt,
  });

  final LegalDocumentType documentType;
  final String version;
  final LegalAcceptanceKind acceptanceKind;

  /// Markdown document body (frontmatter already stripped server-side).
  final String body;
  final String contentHash;
  final String url;
  final DateTime? effectiveAt;
}

/// The current published legal documents (GET /legal/current). Any field may be
/// absent if the backend has not published that document.
class LegalDocuments {
  const LegalDocuments({
    required this.privacyPolicy,
    required this.termsAndConditions,
    required this.communityGuidelines,
  });

  final LegalDocument? privacyPolicy;
  final LegalDocument? termsAndConditions;
  final LegalDocument? communityGuidelines;

  /// The document matching [type], or null if none is published for it.
  LegalDocument? forType(LegalDocumentType type) => switch (type) {
        LegalDocumentType.privacyPolicy => privacyPolicy,
        LegalDocumentType.termsAndConditions => termsAndConditions,
        LegalDocumentType.communityGuidelines => communityGuidelines,
        LegalDocumentType.unknown => null,
      };
}
