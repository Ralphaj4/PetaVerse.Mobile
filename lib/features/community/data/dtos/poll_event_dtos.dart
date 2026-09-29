import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/community_entities.dart' show PageCursor;
import '../../domain/entities/poll_event_entities.dart';
import '../../domain/entities/poll_event_enums.dart';
import 'community_dtos.dart';

part 'poll_event_dtos.freezed.dart';
part 'poll_event_dtos.g.dart';

/// Wire shapes for community **poll** and **event** endpoints. Each DTO exposes
/// a `toEntity()` mapping onto the pure-Dart domain entities. Reuses
/// [PetSummaryDto] for the creator/attendee pet.
///
/// The [PetSummaryDto.mine] flag is derived client-side (the wire has no
/// `isMine`); callers pass `myPetIds` so creators owned by the signed-in user
/// are marked.

// ── Polls ────────────────────────────────────────────────────────────────────

/// One option in `PollResponse.options[]`.
@freezed
abstract class PollOptionDto with _$PollOptionDto {
  const factory PollOptionDto({
    required int id,
    @Default('') String text,
    @Default(0) int voteCount,
    @Default(false) bool votedByMe,
  }) = _PollOptionDto;

  const PollOptionDto._();

  factory PollOptionDto.fromJson(Map<String, dynamic> json) =>
      _$PollOptionDtoFromJson(json);

  PollOption toEntity() => PollOption(
        id: id,
        text: text,
        voteCount: voteCount,
        votedByMe: votedByMe,
      );
}

/// `PollResponse` — a single poll.
@freezed
abstract class PollDto with _$PollDto {
  const factory PollDto({
    required int id,
    @Default(0) int communityId,
    required PetSummaryDto creator,
    @Default('') String title,
    String? description,
    @Default(<PollOptionDto>[]) List<PollOptionDto> options,
    @Default(false) bool allowMultipleVotes,
    @Default(0) int totalVotes,
    @Default(false) bool hasVoted,
    @Default(false) bool isExpired,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) = _PollDto;

  const PollDto._();

  factory PollDto.fromJson(Map<String, dynamic> json) =>
      _$PollDtoFromJson(json);

  Poll toEntity({Set<int> myPetIds = const {}}) => Poll(
        id: id,
        communityId: communityId,
        creator: creator.toEntity(mine: myPetIds.contains(creator.id)),
        title: title,
        description: description,
        options: options.map((o) => o.toEntity()).toList(growable: false),
        allowMultipleVotes: allowMultipleVotes,
        totalVotes: totalVotes,
        hasVoted: hasVoted,
        isExpired: isExpired,
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        expiresAt: expiresAt,
      );
}

/// `{ polls, hasMore, nextPage }`.
@freezed
abstract class PollListResponseDto with _$PollListResponseDto {
  const factory PollListResponseDto({
    @Default(<PollDto>[]) List<PollDto> polls,
    @Default(false) bool hasMore,
    int? nextPage,
  }) = _PollListResponseDto;

  const PollListResponseDto._();

  factory PollListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PollListResponseDtoFromJson(json);

  PollPage toEntity({Set<int> myPetIds = const {}}) => PollPage(
        polls: polls
            .map((p) => p.toEntity(myPetIds: myPetIds))
            .toList(growable: false),
        cursor: PageCursor(hasMore: hasMore, nextPage: nextPage),
      );
}

// ── Events ───────────────────────────────────────────────────────────────────

/// `EventResponse` — a single event.
/// `EventResponse.location` — a geocoded place, or null when unset.
@freezed
abstract class EventLocationDto with _$EventLocationDto {
  const factory EventLocationDto({
    @Default('') String displayName,
    double? lat,
    double? lng,
  }) = _EventLocationDto;

  const EventLocationDto._();

  factory EventLocationDto.fromJson(Map<String, dynamic> json) =>
      _$EventLocationDtoFromJson(json);

  EventLocation toEntity() =>
      EventLocation(displayName: displayName, lat: lat, lng: lng);
}

@freezed
abstract class EventDto with _$EventDto {
  const factory EventDto({
    required int id,
    @Default(0) int communityId,
    required PetSummaryDto creator,
    @Default('') String title,
    String? description,
    EventLocationDto? location,
    DateTime? startsAt,
    DateTime? endsAt,
    @Default(0) int attendingCount,
    @Default(0) int interestedCount,
    // Nullable: null when petId wasn't passed or the pet hasn't RSVPed.
    int? myStatus,
    DateTime? createdAt,
  }) = _EventDto;

  const EventDto._();

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);

  CommunityEvent toEntity({Set<int> myPetIds = const {}}) => CommunityEvent(
        id: id,
        communityId: communityId,
        creator: creator.toEntity(mine: myPetIds.contains(creator.id)),
        title: title,
        description: description,
        location: location?.toEntity(),
        startsAt: startsAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        endsAt: endsAt,
        attendingCount: attendingCount,
        interestedCount: interestedCount,
        myStatus: myStatus == null ? null : attendeeStatusFromWire(myStatus!),
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// `{ events, hasMore, nextPage }`.
@freezed
abstract class EventListResponseDto with _$EventListResponseDto {
  const factory EventListResponseDto({
    @Default(<EventDto>[]) List<EventDto> events,
    @Default(false) bool hasMore,
    int? nextPage,
  }) = _EventListResponseDto;

  const EventListResponseDto._();

  factory EventListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EventListResponseDtoFromJson(json);

  EventPage toEntity({Set<int> myPetIds = const {}}) => EventPage(
        events: events
            .map((e) => e.toEntity(myPetIds: myPetIds))
            .toList(growable: false),
        cursor: PageCursor(hasMore: hasMore, nextPage: nextPage),
      );
}

/// One attendee row in `{ attendees, hasMore, nextPage }`.
@freezed
abstract class EventAttendeeDto with _$EventAttendeeDto {
  const factory EventAttendeeDto({
    required PetSummaryDto pet,
    @Default(0) int status,
    DateTime? respondedAt,
  }) = _EventAttendeeDto;

  const EventAttendeeDto._();

  factory EventAttendeeDto.fromJson(Map<String, dynamic> json) =>
      _$EventAttendeeDtoFromJson(json);

  EventAttendee toEntity({bool mine = false}) => EventAttendee(
        pet: pet.toEntity(mine: mine),
        status: attendeeStatusFromWire(status),
        respondedAt: respondedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// `{ attendees, hasMore, nextPage }`.
@freezed
abstract class EventAttendeeListResponseDto
    with _$EventAttendeeListResponseDto {
  const factory EventAttendeeListResponseDto({
    @Default(<EventAttendeeDto>[]) List<EventAttendeeDto> attendees,
    @Default(false) bool hasMore,
    int? nextPage,
  }) = _EventAttendeeListResponseDto;

  const EventAttendeeListResponseDto._();

  factory EventAttendeeListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EventAttendeeListResponseDtoFromJson(json);

  EventAttendeePage toEntity({Set<int> myPetIds = const {}}) =>
      EventAttendeePage(
        attendees: attendees
            .map((a) => a.toEntity(mine: myPetIds.contains(a.pet.id)))
            .toList(growable: false),
        cursor: PageCursor(hasMore: hasMore, nextPage: nextPage),
      );
}
