import '../../../legal/domain/entities/legal.dart';
import '../../../pawcare/domain/entities/health_reminder.dart';
import '../../../pawcare/domain/entities/pet_health_score.dart';
import '../../../pawcare/domain/entities/weight_record.dart';

/// The aggregated home dashboard for the active pet plus a cross-pet "what do I
/// need to take care of" timeline. Mirrors `GET /api/users/me/home-summary`.
///
/// Domain layer - no Flutter or JSON imports.
class HomeSummary {
  const HomeSummary({
    required this.petId,
    required this.petName,
    required this.healthScore,
    required this.healthBand,
    required this.nextVisit,
    required this.activity,
    required this.vaccinesUpcomingCount,
    required this.weight,
    required this.upcoming,
    this.lostNearbyCount,
    this.adoptionAvailableCount,
    this.legal,
    this.fromCache = false,
  });

  /// The pet the hero + stat cards describe (primary/active, or the queried id).
  final int petId;
  final String petName;

  /// Hero gauge value, 0–100. Same as [HealthStat.value].
  final int healthScore;

  /// Hero + Health card band; [HealthBand.noData] on a cold-start pet →
  /// the UI shows an onboarding empty state rather than a failing grade.
  final HealthBand healthBand;

  /// Soonest non-completed appointment for the selected pet, or null.
  final NextVisit? nextVisit;

  /// Selected pet's activity over the rolling window.
  final ActivityStat activity;

  /// Selected pet's vaccinations that carry a next-due date.
  final int vaccinesUpcomingCount;

  /// Selected pet's latest weight, or null when it has no records.
  final WeightStat? weight;

  /// Cross-pet, cross-kind reminders - soonest first, all overdue included,
  /// no future cutoff. Empty when nothing is due across any pet.
  final List<HealthReminder> upcoming;

  /// Lost pets reported near the user, backing the Home "Explore" tile.
  /// Null until the backend supplies it - the tile falls back to a static
  /// subtitle rather than showing a count of zero.
  final int? lostNearbyCount;

  /// Pets available for adoption, backing the Home "Explore" tile. Null until
  /// the backend supplies it.
  final int? adoptionAvailableCount;

  /// The legal pre-check delegated from /legal/status, or null when the backend
  /// omitted the block (older server). The legal gate seeds itself from this -
  /// but only off a FRESH (non-cache) summary, so a stale cached value can never
  /// wrongly wall or release the user; a null block falls back to /legal/status.
  final HomeLegal? legal;

  /// True when this summary came from the local Hive cache (offline paint).
  /// The legal gate ignores cached summaries to preserve its authoritative-only
  /// invariant.
  final bool fromCache;

  bool get hasHealthData => healthBand != HealthBand.noData;

  /// Returns a copy marked as cache-sourced (used by the offline-first read
  /// path so the legal gate can tell fresh from cached).
  HomeSummary asCached() => HomeSummary(
        petId: petId,
        petName: petName,
        healthScore: healthScore,
        healthBand: healthBand,
        nextVisit: nextVisit,
        activity: activity,
        vaccinesUpcomingCount: vaccinesUpcomingCount,
        weight: weight,
        upcoming: upcoming,
        lostNearbyCount: lostNearbyCount,
        adoptionAvailableCount: adoptionAvailableCount,
        legal: legal,
        fromCache: true,
      );
}

/// The legal pre-check carried on the home-summary: whether the signed-in user
/// owes any acceptance, and the pending (documentType, currentVersion) pairs.
/// This is authoritative server-side (delegated from /legal/status) but carries
/// only the minimal shape - the acceptance wall still resolves the full version
/// via legalCurrent when it needs to POST.
class HomeLegal {
  const HomeLegal({
    required this.requiresAcceptance,
    required this.pending,
  });

  const HomeLegal.none()
      : requiresAcceptance = false,
        pending = const [];

  final bool requiresAcceptance;
  final List<HomeLegalPending> pending;
}

/// One pending legal document from the home-summary pre-check.
class HomeLegalPending {
  const HomeLegalPending({
    required this.documentType,
    required this.currentVersion,
  });

  final LegalDocumentType documentType;
  final String? currentVersion;
}

/// The next vet visit chip on the hero.
class NextVisit {
  const NextVisit({
    required this.appointmentId,
    required this.petId,
    required this.petName,
    required this.title,
    required this.scheduledAt,
    this.location,
  });

  final int appointmentId;
  final int petId;
  final String petName;
  final String title;
  final DateTime scheduledAt;
  final String? location;
}

/// Activity stat card: summed session minutes + distinct active days over a
/// rolling [windowDays] window for the selected pet.
class ActivityStat {
  const ActivityStat({
    required this.minutes,
    required this.activeDays,
    required this.windowDays,
  });

  final int minutes;
  final int activeDays;
  final int windowDays;
}

/// Trend of the selected pet's weight over its recent readings.
enum WeightTrend {
  stable('Stable'),
  rising('Rising'),
  dropping('Dropping');

  const WeightTrend(this.wire);

  final String wire;

  /// Parses a wire trend token, or null for an unrecognized / absent value
  /// (a single reading yields no trend).
  static WeightTrend? fromWire(String? raw) {
    for (final t in WeightTrend.values) {
      if (t.wire == raw) return t;
    }
    return null;
  }
}

/// Weight stat card: latest reading + trend (trend null with only one record).
class WeightStat {
  const WeightStat({
    required this.value,
    required this.unit,
    this.trend,
  });

  final double value;
  final WeightUnit unit;
  final WeightTrend? trend;
}
