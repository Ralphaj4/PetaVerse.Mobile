import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/analytics/analytics_events.dart';
import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/poll_event_entities.dart';
import '../../domain/entities/poll_event_enums.dart';
import '../../domain/repositories/poll_event_repository.dart';
import 'poll_event_providers.dart';

part 'poll_event_actions_providers.g.dart';

/// Write actions for community polls & events (create poll, vote, create/update
/// event, RSVP). Thin wrapper over [PollEventRepository] that emits the
/// analytics event on success, so each event fires in exactly one place no
/// matter which screen triggers the action. Mirrors [CommunityGroupActions].
///
/// Read as a plain object (`ref.read(pollEventActionsProvider)`); holds no
/// state. Reads/mutations of the loaded lists still go through the list
/// notifiers at the call site — this only owns the repo call + analytics.
@Riverpod(keepAlive: true)
PollEventActions pollEventActions(Ref ref) => PollEventActions(ref);

class PollEventActions {
  PollEventActions(this._ref);

  final Ref _ref;

  PollEventRepository get _repo => _ref.read(pollEventRepositoryProvider);
  AnalyticsService get _analytics => _ref.read(analyticsServiceProvider);

  // ── Polls ──────────────────────────────────────────────────────────────────

  Future<Result<Poll>> createPoll({
    required int communityId,
    required int creatorPetId,
    required String title,
    required List<String> options,
    String? description,
    bool allowMultipleVotes = false,
    DateTime? expiresAt,
  }) async {
    final result = await _repo.createPoll(
      communityId: communityId,
      creatorPetId: creatorPetId,
      title: title,
      options: options,
      description: description,
      allowMultipleVotes: allowMultipleVotes,
      expiresAt: expiresAt,
    );
    result.when(
      success: (poll) => unawaited(_analytics.logEvent(
        AnalyticsEvents.pollCreated,
        parameters: {
          'communityId': communityId,
          'optionCount': options.length,
          'allowMultipleVotes': allowMultipleVotes,
        },
      )),
      failure: (_) {},
    );
    return result;
  }

  Future<Result<Poll>> vote({
    required int pollId,
    required int petId,
    required List<int> optionIds,
  }) async {
    final result =
        await _repo.vote(pollId: pollId, petId: petId, optionIds: optionIds);
    result.when(
      success: (poll) => unawaited(_analytics.logEvent(
        AnalyticsEvents.pollVoted,
        parameters: {'pollId': pollId, 'communityId': poll.communityId},
      )),
      failure: (_) {},
    );
    return result;
  }

  /// Retract carries no analytics event (mirrors the app not tracking unlike /
  /// unsave / unfollow).
  Future<Result<Poll>> retractVote({
    required int pollId,
    required int petId,
  }) =>
      _repo.retractVote(pollId: pollId, petId: petId);

  // ── Events ─────────────────────────────────────────────────────────────────

  Future<Result<CommunityEvent>> createEvent({
    required int communityId,
    required int creatorPetId,
    required String title,
    required DateTime startsAt,
    String? description,
    EventLocation? location,
    DateTime? endsAt,
  }) async {
    final result = await _repo.createEvent(
      communityId: communityId,
      creatorPetId: creatorPetId,
      title: title,
      startsAt: startsAt,
      description: description,
      location: location,
      endsAt: endsAt,
    );
    result.when(
      success: (event) => unawaited(_analytics.logEvent(
        AnalyticsEvents.eventCreated,
        parameters: {
          'communityId': communityId,
          'hasLocation': location != null,
        },
      )),
      failure: (_) {},
    );
    return result;
  }

  /// Edits carry no analytics event (mirrors the app not tracking post edits).
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
      _repo.updateEvent(
        eventId: eventId,
        actingPetId: actingPetId,
        title: title,
        description: description,
        location: location,
        clearLocation: clearLocation,
        startsAt: startsAt,
        endsAt: endsAt,
      );

  Future<Result<CommunityEvent>> rsvp({
    required int eventId,
    required int petId,
    required AttendeeStatus status,
  }) async {
    final result =
        await _repo.rsvp(eventId: eventId, petId: petId, status: status);
    result.when(
      success: (event) => unawaited(_analytics.logEvent(
        AnalyticsEvents.eventRsvp,
        parameters: {
          'eventId': eventId,
          'communityId': event.communityId,
          'status': status.name,
        },
      )),
      failure: (_) {},
    );
    return result;
  }
}
