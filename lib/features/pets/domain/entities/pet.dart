/// A pet owned by the current user.
///
/// Domain layer — no Flutter or JSON imports. Mirrors the API's
/// PetResponse contract; the data layer maps the DTO onto this.
class Pet {
  const Pet({
    required this.id,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    this.breedId,
    this.breedName,
    this.speciesName,
    this.pelage,
    this.microchipNumber,
    this.microchipLocation,
    this.sterilizationStatus,
    this.sterilizationDate,
    this.createdAt,
    this.avatarUrl,
  });

  final int id;
  final String name;
  final String gender;
  final DateTime dateOfBirth;
  final int? breedId;
  final String? breedName;
  final String? speciesName;
  final String? pelage;
  final String? microchipNumber;
  final String? microchipLocation;
  final String? sterilizationStatus;
  final DateTime? sterilizationDate;
  final DateTime? createdAt;

  /// Public CDN URL of the pet's avatar, or null when none is set.
  final String? avatarUrl;

  /// Whole years since [dateOfBirth], floored, never negative.
  int get ageInYears {
    final now = DateTime.now();
    var age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age < 0 ? 0 : age;
  }

  /// The breed name, falling back to the species, for compact subtitles.
  String get breedOrSpecies => breedName ?? speciesName ?? '';
}
