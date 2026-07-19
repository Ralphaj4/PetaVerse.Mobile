/// A lightweight pet identity — id, name, and image — enough for the routing
/// gate, the current-pet pointer, and a compact pet switcher. Full records
/// (breed, DOB, gender) live behind the display-only pet list, fetched on
/// demand by the screens that need them.
///
/// Domain layer — no Flutter or JSON imports.
class PetRef {
  const PetRef({
    required this.id,
    required this.name,
    this.imagePath,
    this.supportsActivityTracking = false,
  });

  final int id;
  final String name;

  /// Path to the pet's image; null/empty until media support lands.
  final String? imagePath;

  /// True when the pet's species supports activity (walk) tracking — gates
  /// the home-screen walk banner. Mirrors PetResponse's
  /// `speciesSupportsActivityTracking`.
  final bool supportsActivityTracking;
}
