import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../pawcare/data/datasources/health_reminder_local_datasource.dart';
import '../../../pawcare/domain/entities/health_reminder.dart';
import '../../domain/entities/home_summary.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';
import '../dtos/home_summary_dto.dart';

/// Home repository. Maps the remote DTO onto [HomeSummary] and turns
/// [AppException]s into [Failure]s.
///
/// Offline-first: every successful fetch is cached in Hive (whole payload) and
/// also fans the timeline into the per-slice reminder cache. A network failure
/// reconciles against the last cached payload - the dashboard keeps rendering
/// the previous snapshot instead of erroring out. Non-network failures (403 /
/// 404 / server) propagate so the UI can surface them honestly.
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remote, this._local, this._reminderCache);

  final HomeRemoteDataSource _remote;
  final HomeLocalDataSource _local;
  final HealthReminderLocalDataSource _reminderCache;

  @override
  Future<Result<HomeSummary>> getHomeSummary({int? petId}) async {
    try {
      final dto = await _remote.getHomeSummary(petId: petId);
      // Cache the whole payload, then fan the timeline into the reminder cache.
      await _cacheSummary(petId, dto);
      final summary = dto.toEntity();
      await _cacheTimeline(summary.upcoming);
      return Result.success(summary);
    } on NetworkException catch (e) {
      // Offline / unreachable: fall back to the last cached snapshot if we have
      // one; otherwise surface the network failure. Mark it cache-sourced so the
      // legal gate won't seed from this stale snapshot (authoritative-only).
      final cached = await _readCached(petId);
      if (cached != null) return Result.success(cached.asCached());
      return Result.failure(_mapFailure(e));
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<HomeSummary?> getCachedHomeSummary({int? petId}) => _readCached(petId);

  Future<HomeSummary?> _readCached(int? petId) async {
    try {
      return (await _local.read(petId))?.toEntity();
    } catch (_) {
      return null;
    }
  }

  /// Best-effort write of the full payload - a cache failure never fails the
  /// fetch.
  Future<void> _cacheSummary(int? petId, HomeSummaryDto dto) async {
    try {
      await _local.write(petId, dto);
    } catch (_) {}
  }

  /// Rewrites the reminder cache from the server timeline, one slice per
  /// (pet, kind), so the offline home view matches what the server just
  /// returned. Best-effort - a cache write failure never fails the fetch.
  Future<void> _cacheTimeline(List<HealthReminder> upcoming) async {
    try {
      // Group by (petId, kind) to match the cache's per-slice key scheme.
      final bySlice = <String, List<HealthReminder>>{};
      for (final r in upcoming) {
        bySlice.putIfAbsent('${r.petId}:${r.kind.name}', () => []).add(r);
      }
      for (final entry in bySlice.entries) {
        final first = entry.value.first;
        await _reminderCache.writeForPet(first.petId, first.kind, entry.value);
      }
    } catch (_) {}
  }

  Failure _mapFailure(AppException e) => switch (e) {
        NetworkException() => NetworkFailure(message: e.message),
        UnauthorizedException() => UnauthorizedFailure(message: e.message),
        SuspendedException() => SuspendedFailure(
            message: e.message,
            suspendedUntil: e.suspendedUntil,
          ),
        BannedException() => BannedFailure(message: e.message),
        ForbiddenException() => ForbiddenFailure(message: e.message),
        NotFoundException() => NotFoundFailure(message: e.message),
        ValidationException() => ValidationFailure(
            message: e.message,
            fieldErrors: e.fieldErrors,
          ),
        RateLimitException() => RateLimitFailure(
            message: e.message,
            retryAfter: e.retryAfter,
          ),
        ConflictException() => ConflictFailure(message: e.message),
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
