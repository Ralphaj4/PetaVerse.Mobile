import '../../../../core/errors/result.dart';
import '../entities/poll_event_entities.dart';
import '../entities/poll_event_enums.dart';

/// Contract for community **poll & event** data access. Implemented in the data
/// layer; consumed by presentation providers. Every method returns a [Result]
/// so the UI never sees raw exceptions.
///
/// Membership/leadership gating (who may create, vote, RSVP, delete) is
/// enforced by the backend (403/422); the UI mirrors it for affordances only.
abstract interface class PollEventRepository {
  // ── Polls ──────────────────────────────────────────────────────────────────

  Future<Result<PollPage>> getPolls({
    required int communityId,
    int? actingPetId,
    int page = 0,
    int limit = 20,
  });

  Future<Result<Poll>> getPoll({required int pollId, int? actingPetId});

  /// Create a poll. [creatorPetId] must be a member of [communityId].
  /// [options] must have 2–10 items. [expiresAt] optional, must be future.
  Future<Result<Poll>> createPoll({
    required int communityId,
    required int creatorPetId,
    required String title,
    required List<String> options,
    String? description,
    bool allowMultipleVotes = false,
    DateTime? expiresAt,
  });

  /// Cast (or replace) a vote. Multiple [optionIds] only when the poll allows.
  Future<Result<Poll>> vote({
    required int pollId,
    required int petId,
    required List<int> optionIds,
  });

  /// Retract all of the acting pet's votes on a poll.
  Future<Result<Poll>> retractVote({required int pollId, required int petId});

  /// Delete a poll. Creator or community lead only.
  Future<Result<void>> deletePoll({required int pollId, required int petId});

  // ── Events ─────────────────────────────────────────────────────────────────

  Future<Result<EventPage>> getEvents({
    required int communityId,
    int? actingPetId,
    int page = 0,
    int limit = 20,
  });

  Future<Result<CommunityEvent>> getEvent({
    required int eventId,
    int? actingPetId,
  });

  Future<Result<EventAttendeePage>> getAttendees({
    required int eventId,
    AttendeeStatus? status,
    int page = 0,
    int limit = 20,
  });

  /// Create an event. [creatorPetId] must be a member of [communityId].
  /// [startsAt] required and must be future; [endsAt] optional, after start.
  /// [location] is a geocoded place, or null for no location.
  Future<Result<CommunityEvent>> createEvent({
    required int communityId,
    required int creatorPetId,
    required String title,
    required DateTime startsAt,
    String? description,
    EventLocation? location,
    DateTime? endsAt,
  });

  /// Patch-update an event. Creator or lead only. All fields optional.
  ///
  /// Location semantics: pass [location] to set it; pass [clearLocation] `true`
  /// to explicitly clear it (sends `location: null`). Leaving both unset leaves
  /// the location unchanged.
  Future<Result<CommunityEvent>> updateEvent({
    required int eventId,
    required int actingPetId,
    String? title,
    String? description,
    EventLocation? location,
    bool clearLocation = false,
    DateTime? startsAt,
    DateTime? endsAt,
  });

  /// Delete an event (soft). Creator or lead only.
  Future<Result<void>> deleteEvent({
    required int eventId,
    required int actingPetId,
  });

  /// RSVP to an event (or update an existing RSVP).
  Future<Result<CommunityEvent>> rsvp({
    required int eventId,
    required int petId,
    required AttendeeStatus status,
  });
}
