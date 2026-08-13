import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/poll_event_entities.dart';
import '../../domain/entities/poll_event_enums.dart';
import '../../domain/repositories/poll_event_repository.dart';
import '../datasources/poll_event_remote_datasource.dart';

/// Poll & event repository. Maps DTOs onto domain entities and turns
/// [AppException]s into [Failure]s. Mirrors [CommunityGroupRepositoryImpl].
///
/// [myPetIds] is a callback (not a snapshot) supplying the ids of the pets the
/// signed-in user owns, so `isMine` on creator/attendee pets always reflects
/// the current pet set.
class PollEventRepositoryImpl implements PollEventRepository {
  const PollEventRepositoryImpl(this._source, this._myPetIds);

  final PollEventDataSource _source;
  final Set<int> Function() _myPetIds;

  Set<int> get _mine => _myPetIds();

  // ── Polls ──────────────────────────────────────────────────────────────────

  @override
  Future<Result<PollPage>> getPolls({
    required int communityId,
    int? actingPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _source.getPolls(
          communityId: communityId,
          petId: actingPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Poll>> getPoll({required int pollId, int? actingPetId}) =>
      _guard(() async {
        final dto = await _source.getPoll(pollId: pollId, petId: actingPetId);
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Poll>> createPoll({
    required int communityId,
    required int creatorPetId,
    required String title,
    required List<String> options,
    String? description,
    bool allowMultipleVotes = false,
    DateTime? expiresAt,
  }) =>
      _guard(() async {
        final dto = await _source.createPoll(communityId, {
          'creatorPetId': creatorPetId,
          'title': title,
          'description': ?description,
          'options': options,
          'allowMultipleVotes': allowMultipleVotes,
          'expiresAt': ?expiresAt?.toUtc().toIso8601String(),
        });
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Poll>> vote({
    required int pollId,
    required int petId,
    required List<int> optionIds,
  }) =>
      _guard(() async {
        final dto = await _source.vote(pollId, {
          'petId': petId,
          'optionIds': optionIds,
        });
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Poll>> retractVote({
    required int pollId,
    required int petId,
  }) =>
      _guard(() async {
        final dto = await _source.retractVote(pollId, petId);
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<void>> deletePoll({
    required int pollId,
    required int petId,
  }) =>
      _guardVoid(() => _source.deletePoll(pollId, petId));

  // ── Events ─────────────────────────────────────────────────────────────────

  @override
  Future<Result<EventPage>> getEvents({
    required int communityId,
    int? actingPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _source.getEvents(
          communityId: communityId,
          petId: actingPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<CommunityEvent>> getEvent({
    required int eventId,
    int? actingPetId,
  }) =>
      _guard(() async {
        final dto = await _source.getEvent(eventId: eventId, petId: actingPetId);
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<EventAttendeePage>> getAttendees({
    required int eventId,
    AttendeeStatus? status,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _source.getAttendees(
          eventId: eventId,
          status: status?.wire,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<CommunityEvent>> createEvent({
    required int communityId,
    required int creatorPetId,
    required String title,
    required DateTime startsAt,
    String? description,
    EventLocation? location,
    DateTime? endsAt,
  }) =>
      _guard(() async {
        final dto = await _source.createEvent(communityId, {
          'creatorPetId': creatorPetId,
          'title': title,
          'description': ?description,
          'location': ?_locationJson(location),
          'startsAt': startsAt.toUtc().toIso8601String(),
          'endsAt': ?endsAt?.toUtc().toIso8601String(),
        });
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<CommunityEvent>> updateEvent({
    required int eventId,
    required int actingPetId,
    String? title,
    String? description,
    EventLocation? location,
    bool clearLocation = false,
    DateTime? startsAt,
    DateTime? endsAt,
  }) =>
      _guard(() async {
        final dto = await _source.updateEvent(eventId, actingPetId, {
          'title': ?title,
          'description': ?description,
          // Explicit clear sends null; otherwise send the object only when set,
          // leaving it out (unchanged) when neither is provided.
          if (clearLocation)
            'location': null
          else if (location != null)
            'location': _locationJson(location),
          'startsAt': ?startsAt?.toUtc().toIso8601String(),
          'endsAt': ?endsAt?.toUtc().toIso8601String(),
        });
        return dto.toEntity(myPetIds: _mine);
      });

  /// Serializes an [EventLocation] to the wire shape, or null when absent.
  Map<String, dynamic>? _locationJson(EventLocation? location) {
    if (location == null) return null;
    return {
      'displayName': location.displayName,
      'lat': ?location.lat,
      'lng': ?location.lng,
    };
  }

  @override
  Future<Result<void>> deleteEvent({
    required int eventId,
    required int actingPetId,
  }) =>
      _guardVoid(() => _source.deleteEvent(eventId, actingPetId));

  @override
  Future<Result<CommunityEvent>> rsvp({
    required int eventId,
    required int petId,
    required AttendeeStatus status,
  }) =>
      _guard(() async {
        final dto = await _source.rsvp(eventId, {
          'petId': petId,
          'status': status.wire,
        });
        return dto.toEntity(myPetIds: _mine);
      });

  // ── Plumbing (mirrors CommunityGroupRepositoryImpl) ─────────────────────────

  Future<Result<T>> _guard<T>(Future<T> Function() body) async {
    try {
      return Result.success(await body());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  Future<Result<void>> _guardVoid(Future<void> Function() body) async {
    try {
      await body();
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  Failure _mapFailure(AppException e) => switch (e) {
        NetworkException() => NetworkFailure(message: e.message),
        UnauthorizedException() => UnauthorizedFailure(message: e.message),
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
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
