/// A pet's server-computed health score — a 0–100 summary of preventive-care
/// compliance and vitals tracking (NOT a clinical diagnosis).
///
/// Domain layer — no Flutter or JSON imports. Mirrors
/// `GET /api/pets/{petId}/health-score`. The app renders this; it never
/// computes it. See `docs/Pet-Health-Score-Mobile-Guide.md`.
class PetHealthScore {
  const PetHealthScore({
    required this.petId,
    required this.value,
    required this.band,
    required this.confidence,
    required this.applicableCount,
    required this.components,
    required this.reasons,
    required this.conditions,
    required this.computedAt,
  });

  final int petId;

  /// The gauge number, 0–100.
  final int value;

  /// The score band (drives color + label). See [HealthBand].
  final HealthBand band;

  /// How much of the score is data-backed, 0–1.
  final double confidence;

  /// How many of the four signals had usable data, 0–4.
  final int applicableCount;

  /// The four signals, always in fixed order
  /// (vaccinations, medications, weight, activity).
  final List<HealthComponent> components;

  /// "Why this score", pre-sorted worst-first by the server.
  final List<HealthReason> reasons;

  /// Chronic conditions on file — context only, never lowers [value].
  final ConditionsContext conditions;

  final DateTime computedAt;

  /// `true` unless this is the cold-start empty state. Branch on this (or
  /// [HealthBand.noData]) rather than on `value == 0` — a real 0 is possible
  /// but "No data" is an onboarding prompt, not a failing grade.
  bool get hasData => band != HealthBand.noData;
}

/// The five possible score bands. The wire value is [wire]; switch on the enum
/// for color and copy — never parse the string in the UI.
enum HealthBand {
  excellent('Excellent'),
  good('Good'),
  fair('Fair'),
  needsAttention('Needs Attention'),
  noData('No data');

  const HealthBand(this.wire);

  /// The exact token the API returns.
  final String wire;

  /// Parses a wire band token, defaulting to [HealthBand.noData] for anything
  /// unrecognized (safest fallback — treats unknowns as an empty state).
  static HealthBand fromWire(String? raw) {
    for (final b in HealthBand.values) {
      if (b.wire == raw) return b;
    }
    return HealthBand.noData;
  }
}

/// One of the four scored signals.
class HealthComponent {
  const HealthComponent({
    required this.key,
    required this.label,
    required this.weight,
    required this.applicable,
    required this.ratio,
    required this.earned,
    this.naReason,
  });

  /// Stable identifier: `vaccinations` | `medications` | `weight` | `activity`.
  /// Switch on this, not on list index.
  final String key;

  /// Display-ready, server-localized label (e.g. "Weight tracking").
  final String label;

  /// Max points this signal can contribute (30 / 25 / 20 / 15).
  final int weight;

  /// Whether this signal had usable data for this pet.
  final bool applicable;

  /// Quality of this signal, 0–1 — the per-component bar fill. `0` when N/A.
  final double ratio;

  /// `ratio * weight` — raw points before redistribution. `0` when N/A.
  final double earned;

  /// Why it's N/A (e.g. "This species doesn't track activity"); `null` when
  /// applicable. Not a penalty — the weight is redistributed to other signals.
  final String? naReason;
}

/// A single "why this score" line.
class HealthReason {
  const HealthReason({
    required this.severity,
    required this.text,
    required this.deltaPoints,
  });

  /// `good` | `warn` | `bad` — drives icon & color. See [ReasonSeverity].
  final HealthReasonSeverity severity;

  /// Display-ready, server-localized text (e.g. "2 of 3 medications overdue").
  final String text;

  /// Impact on the final value. Negative = points lost; `0` = informational.
  final double deltaPoints;

  /// Whether the points chip is worth showing (meaningfully negative).
  bool get showDelta => deltaPoints < -0.05;
}

/// Severity of a [HealthReason].
enum HealthReasonSeverity {
  good('good'),
  warn('warn'),
  bad('bad');

  const HealthReasonSeverity(this.wire);

  final String wire;

  /// Parses a wire severity token, defaulting to [bad] (the loudest) for
  /// anything unrecognized so a formatting change never hides a warning.
  static HealthReasonSeverity fromWire(String? raw) {
    for (final s in HealthReasonSeverity.values) {
      if (s.wire == raw) return s;
    }
    return HealthReasonSeverity.bad;
  }
}

/// Chronic conditions on file — informational context, never affects the score.
class ConditionsContext {
  const ConditionsContext({required this.count, required this.labels});

  final int count;
  final List<String> labels;

  bool get isEmpty => count == 0;
}
