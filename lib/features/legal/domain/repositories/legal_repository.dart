import '../../../../core/errors/result.dart';
import '../entities/legal.dart';

/// Contract for the versioned legal-document acceptance system. Every method
/// returns a [Result] - failures never throw across this boundary.
abstract interface class LegalRepository {
  /// The signed-in user's acceptance status for every document type
  /// (GET /legal/status, authenticated).
  Future<Result<LegalStatus>> getStatus();

  /// The current published versions + metadata of all documents
  /// (GET /legal/current, public).
  Future<Result<LegalDocuments>> getCurrent();

  /// The full renderable content (markdown body + metadata) of one published
  /// document version (GET /legal/{documentType}/{version}/content, public).
  Future<Result<LegalContent>> getContent({
    required LegalDocumentType type,
    required String version,
  });

  /// Records the user's acceptance of [type] at [version]
  /// (POST /legal/accept, authenticated). The backend validates the version
  /// and is idempotent; it returns the refreshed [LegalStatus].
  Future<Result<LegalStatus>> accept({
    required LegalDocumentType type,
    required String version,
  });
}
