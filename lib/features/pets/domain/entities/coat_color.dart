/// A coat / fur color (Black, White, …) used to populate the color picker.
///
/// Backed by the API's CoatColors lookup, where id equals the CoatColor enum
/// value and is fixed forever (1-based, no zero row). "Not specified" is the
/// pet's coat-color FK being null — never a color row.
///
/// Domain layer — no Flutter or JSON imports.
class CoatColor {
  const CoatColor({required this.id, required this.name, required this.displayName});

  final int id;

  /// The raw enum member name (e.g. "PartiColor").
  final String name;

  /// Human-friendly label derived from [name] by splitting PascalCase
  /// (e.g. "Parti Color"). What the picker shows.
  final String displayName;
}
