import '../../../../core/errors/result.dart';
import '../entities/walk_activity.dart';

abstract interface class ActivityRepository {
  /// Saves a completed walk to the remote API.
  Future<Result<WalkActivity>> saveActivity({
    required int petId,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationSeconds,
    double? distanceMeters,
    double? avgSpeedKmh,
  });

  /// Paginated walk history for a pet.
  Future<Result<List<WalkActivity>>> getActivities(
    int petId, {
    int page = 1,
    int pageSize = 20,
  });

  /// Deletes a walk record.
  Future<Result<void>> deleteActivity(int petId, int activityId);
}
