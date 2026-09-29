// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_event_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PollOptionDto _$PollOptionDtoFromJson(Map<String, dynamic> json) =>
    _PollOptionDto(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String? ?? '',
      voteCount: (json['voteCount'] as num?)?.toInt() ?? 0,
      votedByMe: json['votedByMe'] as bool? ?? false,
    );

Map<String, dynamic> _$PollOptionDtoToJson(_PollOptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'voteCount': instance.voteCount,
      'votedByMe': instance.votedByMe,
    };

_PollDto _$PollDtoFromJson(Map<String, dynamic> json) => _PollDto(
  id: (json['id'] as num).toInt(),
  communityId: (json['communityId'] as num?)?.toInt() ?? 0,
  creator: PetSummaryDto.fromJson(json['creator'] as Map<String, dynamic>),
  title: json['title'] as String? ?? '',
  description: json['description'] as String?,
  options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => PollOptionDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PollOptionDto>[],
  allowMultipleVotes: json['allowMultipleVotes'] as bool? ?? false,
  totalVotes: (json['totalVotes'] as num?)?.toInt() ?? 0,
  hasVoted: json['hasVoted'] as bool? ?? false,
  isExpired: json['isExpired'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$PollDtoToJson(_PollDto instance) => <String, dynamic>{
  'id': instance.id,
  'communityId': instance.communityId,
  'creator': instance.creator,
  'title': instance.title,
  'description': instance.description,
  'options': instance.options,
  'allowMultipleVotes': instance.allowMultipleVotes,
  'totalVotes': instance.totalVotes,
  'hasVoted': instance.hasVoted,
  'isExpired': instance.isExpired,
  'createdAt': instance.createdAt?.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
};

_PollListResponseDto _$PollListResponseDtoFromJson(Map<String, dynamic> json) =>
    _PollListResponseDto(
      polls:
          (json['polls'] as List<dynamic>?)
              ?.map((e) => PollDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PollDto>[],
      hasMore: json['hasMore'] as bool? ?? false,
      nextPage: (json['nextPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PollListResponseDtoToJson(
  _PollListResponseDto instance,
) => <String, dynamic>{
  'polls': instance.polls,
  'hasMore': instance.hasMore,
  'nextPage': instance.nextPage,
};

_EventLocationDto _$EventLocationDtoFromJson(Map<String, dynamic> json) =>
    _EventLocationDto(
      displayName: json['displayName'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EventLocationDtoToJson(_EventLocationDto instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'lat': instance.lat,
      'lng': instance.lng,
    };

_EventDto _$EventDtoFromJson(Map<String, dynamic> json) => _EventDto(
  id: (json['id'] as num).toInt(),
  communityId: (json['communityId'] as num?)?.toInt() ?? 0,
  creator: PetSummaryDto.fromJson(json['creator'] as Map<String, dynamic>),
  title: json['title'] as String? ?? '',
  description: json['description'] as String?,
  location: json['location'] == null
      ? null
      : EventLocationDto.fromJson(json['location'] as Map<String, dynamic>),
  startsAt: json['startsAt'] == null
      ? null
      : DateTime.parse(json['startsAt'] as String),
  endsAt: json['endsAt'] == null
      ? null
      : DateTime.parse(json['endsAt'] as String),
  attendingCount: (json['attendingCount'] as num?)?.toInt() ?? 0,
  interestedCount: (json['interestedCount'] as num?)?.toInt() ?? 0,
  myStatus: (json['myStatus'] as num?)?.toInt(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$EventDtoToJson(_EventDto instance) => <String, dynamic>{
  'id': instance.id,
  'communityId': instance.communityId,
  'creator': instance.creator,
  'title': instance.title,
  'description': instance.description,
  'location': instance.location,
  'startsAt': instance.startsAt?.toIso8601String(),
  'endsAt': instance.endsAt?.toIso8601String(),
  'attendingCount': instance.attendingCount,
  'interestedCount': instance.interestedCount,
  'myStatus': instance.myStatus,
  'createdAt': instance.createdAt?.toIso8601String(),
};

_EventListResponseDto _$EventListResponseDtoFromJson(
  Map<String, dynamic> json,
) => _EventListResponseDto(
  events:
      (json['events'] as List<dynamic>?)
          ?.map((e) => EventDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EventDto>[],
  hasMore: json['hasMore'] as bool? ?? false,
  nextPage: (json['nextPage'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventListResponseDtoToJson(
  _EventListResponseDto instance,
) => <String, dynamic>{
  'events': instance.events,
  'hasMore': instance.hasMore,
  'nextPage': instance.nextPage,
};

_EventAttendeeDto _$EventAttendeeDtoFromJson(Map<String, dynamic> json) =>
    _EventAttendeeDto(
      pet: PetSummaryDto.fromJson(json['pet'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt() ?? 0,
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
    );

Map<String, dynamic> _$EventAttendeeDtoToJson(_EventAttendeeDto instance) =>
    <String, dynamic>{
      'pet': instance.pet,
      'status': instance.status,
      'respondedAt': instance.respondedAt?.toIso8601String(),
    };

_EventAttendeeListResponseDto _$EventAttendeeListResponseDtoFromJson(
  Map<String, dynamic> json,
) => _EventAttendeeListResponseDto(
  attendees:
      (json['attendees'] as List<dynamic>?)
          ?.map((e) => EventAttendeeDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EventAttendeeDto>[],
  hasMore: json['hasMore'] as bool? ?? false,
  nextPage: (json['nextPage'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventAttendeeListResponseDtoToJson(
  _EventAttendeeListResponseDto instance,
) => <String, dynamic>{
  'attendees': instance.attendees,
  'hasMore': instance.hasMore,
  'nextPage': instance.nextPage,
};
