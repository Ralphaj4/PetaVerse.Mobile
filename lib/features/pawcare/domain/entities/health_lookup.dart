/// A single option from a PawCare lookup list (medications or vaccines).
///
/// Domain layer — no Flutter or JSON imports. Medications also carry a
/// suggested [dosage] / [frequency]; vaccines carry a [syndicateCode].
class HealthLookup {
  const HealthLookup({
    required this.id,
    required this.name,
    this.dosage,
    this.frequency,
    this.syndicateCode,
  });

  final int id;
  final String name;

  /// Medication lookups only: suggested dosage text, e.g. "Varies by weight".
  final String? dosage;

  /// Medication lookups only: human frequency label, e.g. "Monthly".
  final String? frequency;

  /// Vaccine lookups only: syndicate code, e.g. "RABIES_DOG".
  final String? syndicateCode;
}
