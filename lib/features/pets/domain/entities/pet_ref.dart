/// A lightweight pet identity — id, name, and image — enough for the routing
/// gate, the current-pet pointer, and a compact pet switcher. Full records
/// (breed, DOB, gender) live behind the display-only pet list, fetched on
/// demand by the screens that need them.
///
/// Domain layer — no Flutter or JSON imports.
class PetRef {
  const PetRef({required this.id, required this.name, this.imagePath});

  final int id;
  final String name;

  /// Path to the pet's image; null/empty until media support lands.
  final String? imagePath;
}
