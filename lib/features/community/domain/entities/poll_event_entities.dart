import 'community_entities.dart' show CommunityPet, PageCursor;
import 'poll_event_enums.dart';

/// Domain entities for community **polls** and **events**. Pure Dart — no
/// Flutter, no JSON. DTOs map onto these; the UI only sees these.
///
/// The social actor is always a [CommunityPet] (the creator / attendee).
/// Ids are ints (the API uses int ids throughout).

// ── Polls ────────────────────────────────────────────────────────────────────

/// One option in a poll (`PollResponse.options[]`).
class PollOption {
  const PollOption({
    required this.id,
    required this.text,
    this.voteCount = 0,
    this.votedByMe = false,
  });

  final int id;
  final String text;
  final int voteCount;

  /// Whether the acting pet voted for this option.
  final bool votedByMe;

  PollOption copyWith({int? voteCount, bool? votedByMe}) => PollOption(
        id: id,
        text: text,
        voteCount: voteCount ?? this.voteCount,
        votedByMe: votedByMe ?? this.votedByMe,
      );
}

/// A community poll (`PollResponse`).
class Poll {
  const Poll({
    required this.id,
    required this.communityId,
    required this.creator,
    required this.title,
    required this.options,
    required this.createdAt,
    this.description,
    this.allowMultipleVotes = false,
    this.totalVotes = 0,
    this.hasVoted = false,
    this.isExpired = false,
    this.expiresAt,
  });

  final int id;
  final int communityId;
  final CommunityPet creator;
  final String title;
  final String? description;
  final List<PollOption> options;
  final bool allowMultipleVotes;
  final int totalVotes;

  /// Whether the acting pet has cast any vote on this poll.
  final bool hasVoted;
  final bool isExpired;
  final DateTime createdAt;
  final DateTime? expiresAt;

  /// A [0,1] fraction of total votes for [option] — 0 when there are no votes.
  double share(PollOption option) =>
      totalVotes <= 0 ? 0 : option.voteCount / totalVotes;

  /// Whether the acting pet may still vote (member gate is applied at the UI).
  bool get isOpen => !isExpired;

  Poll copyWith({
    String? title,
    String? description,
    List<PollOption>? options,
    int? totalVotes,
    bool? hasVoted,
    bool? isExpired,
  }) =>
      Poll(
        id: id,
        communityId: communityId,
        creator: creator,
        title: title ?? this.title,
        options: options ?? this.options,
        createdAt: createdAt,
        description: description ?? this.description,
        allowMultipleVotes: allowMultipleVotes,
        totalVotes: totalVotes ?? this.totalVotes,
        hasVoted: hasVoted ?? this.hasVoted,
        isExpired: isExpired ?? this.isExpired,
        expiresAt: expiresAt,
      );
}

/// A page of polls in a community (`{ polls, hasMore, nextPage }`).
class PollPage {
  const PollPage({required this.polls, required this.cursor});

  final List<Poll> polls;
  final PageCursor cursor;
}

// ── Events ───────────────────────────────────────────────────────────────────

/// A geocoded event location. [displayName] is the human-readable address; the
/// coordinates enable mapping. Nullable as a whole on an event (no location).
class EventLocation {
  const EventLocation({
    required this.displayName,
    this.lat,
    this.lng,
  });

  final String displayName;
  final double? lat;
  final double? lng;

  bool get hasCoordinates => lat != null && lng != null;
}

/// A community event (`EventResponse`).
class CommunityEvent {
  const CommunityEvent({
    required this.id,
    required this.communityId,
    required this.creator,
    required this.title,
    required this.startsAt,
    required this.createdAt,
    this.description,
    this.location,
    this.endsAt,
    this.attendingCount = 0,
    this.interestedCount = 0,
    this.myStatus,
  });

  final int id;
  final int communityId;
  final CommunityPet creator;
  final String title;
  final String? description;
  final EventLocation? location;
  final DateTime startsAt;
  final DateTime? endsAt;
  final int attendingCount;
  final int interestedCount;

  /// The acting pet's RSVP, or null if none / not passed.
  final AttendeeStatus? myStatus;

  final DateTime createdAt;

  /// Whether the event's start is in the past.
  bool get isPast => startsAt.isBefore(DateTime.now());

  CommunityEvent copyWith({
    String? title,
    String? description,
    EventLocation? location,
    DateTime? startsAt,
    DateTime? endsAt,
    int? attendingCount,
    int? interestedCount,
    AttendeeStatus? myStatus,
    bool clearMyStatus = false,
    bool clearLocation = false,
  }) =>
      CommunityEvent(
        id: id,
        communityId: communityId,
        creator: creator,
        title: title ?? this.title,
        startsAt: startsAt ?? this.startsAt,
        createdAt: createdAt,
        description: description ?? this.description,
        location: clearLocation ? null : (location ?? this.location),
        endsAt: endsAt ?? this.endsAt,
        attendingCount: attendingCount ?? this.attendingCount,
        interestedCount: interestedCount ?? this.interestedCount,
        myStatus: clearMyStatus ? null : (myStatus ?? this.myStatus),
      );
}

/// A page of events in a community (`{ events, hasMore, nextPage }`).
class EventPage {
  const EventPage({required this.events, required this.cursor});

  final List<CommunityEvent> events;
  final PageCursor cursor;
}

/// One attendee row (`{ pet, status, respondedAt }`).
class EventAttendee {
  const EventAttendee({
    required this.pet,
    required this.status,
    required this.respondedAt,
  });

  final CommunityPet pet;
  final AttendeeStatus status;
  final DateTime respondedAt;
}

/// A page of an event's attendees.
class EventAttendeePage {
  const EventAttendeePage({required this.attendees, required this.cursor});

  final List<EventAttendee> attendees;
  final PageCursor cursor;
}
