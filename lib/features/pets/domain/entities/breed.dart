/// A breed within a species, used to populate the breed dropdown.
///
/// Domain layer — no Flutter or JSON imports.
class Breed {
  const Breed({required this.id, required this.name, this.origin});

  final int id;
  final String name;
  final String? origin;
}
