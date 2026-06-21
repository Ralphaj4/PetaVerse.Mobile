/// The data needed to create a pet — maps 1:1 to the API's CreatePetRequest.
///
/// Required fields: name, speciesId, dateOfBirth, gender.
/// breedId is optional (some species have no breeds).
/// Optional fields are sent when the user fills them in; null means omit.
///
/// Domain layer — no Flutter or JSON imports.
class NewPet {
  const NewPet({
    required this.name,
    required this.speciesId,
    this.breedId,
    required this.dateOfBirth,
    required this.gender,
    this.pelage,
    this.microchipNumber,
    this.microchipLocation,
    this.sterilizationStatus,
    this.sterilizationDate,
  });

  final String name;
  final int speciesId;
  final int? breedId;
  final DateTime dateOfBirth;
  final String gender;

  /// Coat / fur color description.
  final String? pelage;

  /// ISO microchip number.
  final String? microchipNumber;

  /// Body location where the chip was implanted.
  final String? microchipLocation;

  /// One of: Intact, Neutered, Spayed, Unknown.
  final String? sterilizationStatus;

  /// Date of the sterilization procedure, if applicable.
  final DateTime? sterilizationDate;
}
