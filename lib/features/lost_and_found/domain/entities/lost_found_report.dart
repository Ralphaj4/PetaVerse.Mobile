/// Whether a listing is for a lost pet or a found one.
///
/// The API sends an integer on create (1 = lost, 2 = found) and a string on
/// read ("Lost" | "Found"). Only Lost is used by the mobile app today, but the
/// type is modelled in full to match the contract.
enum ReportType { lost, found }

/// Listing lifecycle status, returned as a string ("Active" | "Resolved").
enum ReportStatus { active, resolved }

/// A Lost & Found listing — the core domain object, used both in the
/// dashboard's recent-alerts list and on the details screen.
///
/// Domain layer — no Flutter or JSON imports.
class LostFoundReport {
  const LostFoundReport({
    required this.id,
    required this.type,
    required this.petName,
    required this.speciesName,
    required this.description,
    required this.lastSeenAddress,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
    this.breedName,
    this.imageUrl,
    this.reporterName,
    this.reporterPhone,
    this.petId,
    this.isOwner = false,
    this.reward,
  });

  final int id;
  final ReportType type;
  final String petName;
  final String speciesName;
  final String? breedName;
  final String description;
  final String lastSeenAddress;
  final double latitude;
  final double longitude;

  /// Public URL of the pet's photo, or null when none is set.
  final String? imageUrl;
  final ReportStatus status;
  final DateTime createdAt;
  final String? reporterName;
  final String? reporterPhone;

  /// The linked pet id, when the report references one of the user's pets.
  final int? petId;

  /// True when the current user owns this report (can edit/delete it).
  final bool isOwner;

  /// Reward offered for a Lost pet (0–999), or null when none / Found.
  final int? reward;

  /// Breed name, falling back to species, for compact subtitles.
  String get breedOrSpecies => breedName ?? speciesName;
}
