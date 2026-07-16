/// A pet size (ExtraSmall, Small, …) used to populate the size picker.
///
/// Backed by the API's PetSizes lookup, where id equals the PetSize enum value
/// and is fixed forever (1-based, no zero row). "Not specified" is the pet's
/// size FK being null — never a size row.
///
/// Domain layer — no Flutter or JSON imports.
class PetSize {
  const PetSize({required this.id, required this.name, required this.displayName});

  final int id;

  /// The raw enum member name (e.g. "ExtraSmall").
  final String name;

  /// Human-friendly label derived from [name] by splitting PascalCase
  /// (e.g. "Extra Small"). What the picker shows.
  final String displayName;
}
