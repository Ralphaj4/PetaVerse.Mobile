/// Supported pet species. Serialized by [name].
enum PetSpecies {
  dog,
  cat,
  bird,
  rabbit,
  fish,
  reptile,
  other;

  static PetSpecies fromName(String? name) => PetSpecies.values.firstWhere(
        (s) => s.name == name,
        orElse: () => PetSpecies.other,
      );
}
