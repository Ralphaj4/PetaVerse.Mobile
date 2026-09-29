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
    this.sizeId,
    this.sizeName,
    this.coatColorId,
    this.coatColorName,
    this.microchipNumber,
    this.microchipLocation,
    this.sterilizationStatus,
    this.sterilizationDate,
    this.createdAt,
    this.avatarUrl,
    this.isPrimaryOwner = true,
    this.supportsActivityTracking = false,
  });

  final int id;
  final String name;
  final String gender;
  final DateTime dateOfBirth;
  final int? breedId;
  final String? breedName;
  final String? speciesName;

  /// FK into the PetSizes lookup, or null when the size isn't specified.
  final int? sizeId;

  /// Display name of the pet's size (e.g. "Medium"), carried on PetResponse so
  /// rendering needs no lookup call. Null when unset.
  final String? sizeName;

  /// FK into the CoatColors lookup, or null when the coat color isn't specified.
  final int? coatColorId;

  /// Display name of the pet's coat color (e.g. "Golden"), carried on
  /// PetResponse so rendering needs no lookup call. Null when unset.
  final String? coatColorName;

  final String? microchipNumber;
  final String? microchipLocation;
  final String? sterilizationStatus;
  final DateTime? sterilizationDate;
  final DateTime? createdAt;

  /// Public CDN URL of the pet's avatar, or null when none is set.
  final String? avatarUrl;

  /// True when the requesting user is this pet's primary owner (creator);
  /// false for a co-owner. Gates primary-only actions (e.g. Invite Co-Owner).
  final bool isPrimaryOwner;

  /// True when the pet's species supports activity (walk) tracking. Gates the
  /// walk banner / activity UI.
  final bool supportsActivityTracking;

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

  /// Whole months since [dateOfBirth], floored, never negative. Used to show a
  /// finer age for pets under a year old (where [ageInYears] is 0).
  int get ageInMonths {
    final now = DateTime.now();
    var months = (now.year - dateOfBirth.year) * 12 +
        (now.month - dateOfBirth.month);
    if (now.day < dateOfBirth.day) months--;
    return months < 0 ? 0 : months;
  }

  /// The breed name, falling back to the species, for compact subtitles.
  String get breedOrSpecies => breedName ?? speciesName ?? '';
}
