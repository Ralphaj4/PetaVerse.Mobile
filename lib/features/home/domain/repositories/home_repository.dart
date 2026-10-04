import '../../../../core/errors/result.dart';
import '../entities/home_summary.dart';

/// Contract for the aggregated home dashboard. The data layer maps the DTO onto
/// [HomeSummary] and turns AppExceptions into Failures.
abstract interface class HomeRepository {
  /// The home dashboard for [petId] (or the primary/first pet when null): hero
  /// score + next visit, the four stat cards, and the cross-pet upcoming
  /// timeline. On success the payload is cached; on a network failure the last
  /// cached payload is returned when available.
  Future<Result<HomeSummary>> getHomeSummary({int? petId});

  /// The last cached home summary for [petId], or null when nothing is cached.
  /// Read-only, no network - used to paint the dashboard instantly before the
  /// live fetch resolves.
  Future<HomeSummary?> getCachedHomeSummary({int? petId});
}
