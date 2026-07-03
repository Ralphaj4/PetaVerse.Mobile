import '../../../../core/errors/result.dart';
import '../entities/lost_found_dashboard.dart';
import '../entities/lost_found_report.dart';

/// Contract for Lost & Found data against the API.
///
/// All methods return [Result] — exceptions never cross this boundary.
abstract interface class LostFoundRepository {
  /// The dashboard for a location: map pins, filtered recent alerts, and the
  /// viewer's volunteer status. [filter] is "lost" | "found" (null for all).
  Future<Result<LostFoundDashboard>> getDashboard({
    required double latitude,
    required double longitude,
    double radiusKm,
    String? filter,
  });

  /// Creates a lost/found report and returns it. [type] is the integer enum
  /// (1 = lost, 2 = found). [avatarMediaAssetId] is optional.
  Future<Result<LostFoundReport>> createReport({
    required int type,
    required String petName,
    required int speciesId,
    int? breedId,
    required String description,
    required String lastSeenAddress,
    required double latitude,
    required double longitude,
    int? petId,
    int? reward,
    String? avatarMediaAssetId,
  });

  /// Fetches a single report by its id (for the details screen).
  Future<Result<LostFoundReport>> getReport(int id);

  /// Deletes the user's own report.
  Future<Result<void>> deleteReport(int id);

  /// The viewer's current volunteer status.
  Future<Result<VolunteerInfo>> getVolunteerStatus();

  /// Joins the volunteers; returns the updated status/count.
  Future<Result<VolunteerInfo>> joinVolunteers();

  /// Leaves the volunteers.
  Future<Result<void>> leaveVolunteers();
}
