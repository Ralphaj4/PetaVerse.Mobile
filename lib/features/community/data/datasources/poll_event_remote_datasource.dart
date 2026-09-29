import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/poll_event_dtos.dart';

/// Data-source contract for community **polls & events**, implemented by
/// [PollEventRemoteDataSource]. Throws AppExceptions (mapped by [ApiClient]);
/// the repository turns those into Failures.
abstract interface class PollEventDataSource {
  // ── Polls ──────────────────────────────────────────────────────────────────

  Future<PollListResponseDto> getPolls({
    required int communityId,
    int? petId,
    required int page,
    required int limit,
  });

  Future<PollDto> getPoll({required int pollId, int? petId});

  Future<PollDto> createPoll(int communityId, Map<String, dynamic> body);

  Future<PollDto> vote(int pollId, Map<String, dynamic> body);

  Future<PollDto> retractVote(int pollId, int petId);

  Future<void> deletePoll(int pollId, int petId);

  // ── Events ─────────────────────────────────────────────────────────────────

  Future<EventListResponseDto> getEvents({
    required int communityId,
    int? petId,
    required int page,
    required int limit,
  });

  Future<EventDto> getEvent({required int eventId, int? petId});

  Future<EventAttendeeListResponseDto> getAttendees({
    required int eventId,
    int? status,
    required int page,
    required int limit,
  });

  Future<EventDto> createEvent(int communityId, Map<String, dynamic> body);

  Future<EventDto> updateEvent(int eventId, int petId, Map<String, dynamic> body);

  Future<void> deleteEvent(int eventId, int petId);

  Future<EventDto> rsvp(int eventId, Map<String, dynamic> body);
}

/// Remote (live API) implementation. Talks to the API exclusively through
/// [ApiClient]; never touches Dio directly.
class PollEventRemoteDataSource implements PollEventDataSource {
  const PollEventRemoteDataSource(this._client);

  final ApiClient _client;

  // ── Polls ──────────────────────────────────────────────────────────────────

  @override
  Future<PollListResponseDto> getPolls({
    required int communityId,
    int? petId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityPolls(communityId),
      queryParameters: {'petId': ?petId, 'page': page, 'limit': limit},
    );
    return PollListResponseDto.fromJson(data);
  }

  @override
  Future<PollDto> getPoll({required int pollId, int? petId}) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityPoll(pollId),
      queryParameters: {'petId': ?petId},
    );
    return PollDto.fromJson(data);
  }

  @override
  Future<PollDto> createPoll(int communityId, Map<String, dynamic> body) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityPolls(communityId),
      data: body,
    );
    return PollDto.fromJson(data);
  }

  @override
  Future<PollDto> vote(int pollId, Map<String, dynamic> body) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityPollVote(pollId),
      data: body,
    );
    return PollDto.fromJson(data);
  }

  @override
  Future<PollDto> retractVote(int pollId, int petId) async {
    final data = await _client.deleteWithBody<Map<String, dynamic>>(
      '${ApiEndpoints.communityPollVote(pollId)}?petId=$petId',
    );
    return PollDto.fromJson(data);
  }

  @override
  Future<void> deletePoll(int pollId, int petId) async {
    await _client.delete<void>(
      '${ApiEndpoints.communityPoll(pollId)}?petId=$petId',
    );
  }

  // ── Events ─────────────────────────────────────────────────────────────────

  @override
  Future<EventListResponseDto> getEvents({
    required int communityId,
    int? petId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityEvents(communityId),
      queryParameters: {'petId': ?petId, 'page': page, 'limit': limit},
    );
    return EventListResponseDto.fromJson(data);
  }

  @override
  Future<EventDto> getEvent({required int eventId, int? petId}) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityEvent(eventId),
      queryParameters: {'petId': ?petId},
    );
    return EventDto.fromJson(data);
  }

  @override
  Future<EventAttendeeListResponseDto> getAttendees({
    required int eventId,
    int? status,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityEventAttendees(eventId),
      queryParameters: {
        'status': ?status,
        'page': page,
        'limit': limit,
      },
    );
    return EventAttendeeListResponseDto.fromJson(data);
  }

  @override
  Future<EventDto> createEvent(
      int communityId, Map<String, dynamic> body) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityEvents(communityId),
      data: body,
    );
    return EventDto.fromJson(data);
  }

  @override
  Future<EventDto> updateEvent(
      int eventId, int petId, Map<String, dynamic> body) async {
    final data = await _client.put<Map<String, dynamic>>(
      '${ApiEndpoints.communityEvent(eventId)}?petId=$petId',
      data: body,
    );
    return EventDto.fromJson(data);
  }

  @override
  Future<void> deleteEvent(int eventId, int petId) async {
    await _client.delete<void>(
      '${ApiEndpoints.communityEvent(eventId)}?petId=$petId',
    );
  }

  @override
  Future<EventDto> rsvp(int eventId, Map<String, dynamic> body) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityEventRsvp(eventId),
      data: body,
    );
    return EventDto.fromJson(data);
  }
}
