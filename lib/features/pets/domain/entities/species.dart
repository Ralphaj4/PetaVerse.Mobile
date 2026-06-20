/// A pet species (Dog, Cat, …) used to populate the animal-type picker.
///
/// Domain layer — no Flutter or JSON imports.
class Species {
  const Species({required this.id, required this.name});

  final int id;
  final String name;
}
