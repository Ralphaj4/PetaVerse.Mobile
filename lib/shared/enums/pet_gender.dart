/// Pet gender. Serialized by [name].
enum PetGender {
  male,
  female,
  unknown;

  static PetGender fromName(String? name) => PetGender.values.firstWhere(
        (g) => g.name == name,
        orElse: () => PetGender.unknown,
      );
}
