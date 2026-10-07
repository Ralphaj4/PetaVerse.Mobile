// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeSummaryDto _$HomeSummaryDtoFromJson(Map<String, dynamic> json) =>
    _HomeSummaryDto(
      pet: HomePetDto.fromJson(json['pet'] as Map<String, dynamic>),
      hero: HomeHeroDto.fromJson(json['hero'] as Map<String, dynamic>),
      stats: HomeStatsDto.fromJson(json['stats'] as Map<String, dynamic>),
      upcoming:
          (json['upcoming'] as List<dynamic>?)
              ?.map(
                (e) => HomeUpcomingItemDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <HomeUpcomingItemDto>[],
      explore: json['explore'] == null
          ? null
          : HomeExploreDto.fromJson(json['explore'] as Map<String, dynamic>),
      legal: json['legal'] == null
          ? null
          : HomeLegalDto.fromJson(json['legal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeSummaryDtoToJson(_HomeSummaryDto instance) =>
    <String, dynamic>{
      'pet': instance.pet,
      'hero': instance.hero,
      'stats': instance.stats,
      'upcoming': instance.upcoming,
      'explore': instance.explore,
      'legal': instance.legal,
    };

_HomeLegalDto _$HomeLegalDtoFromJson(Map<String, dynamic> json) =>
    _HomeLegalDto(
      requiresAcceptance: json['requiresAcceptance'] as bool? ?? false,
      pending:
          (json['pending'] as List<dynamic>?)
              ?.map(
                (e) => HomeLegalPendingDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <HomeLegalPendingDto>[],
    );

Map<String, dynamic> _$HomeLegalDtoToJson(_HomeLegalDto instance) =>
    <String, dynamic>{
      'requiresAcceptance': instance.requiresAcceptance,
      'pending': instance.pending,
    };

_HomeLegalPendingDto _$HomeLegalPendingDtoFromJson(Map<String, dynamic> json) =>
    _HomeLegalPendingDto(
      documentType: json['documentType'] as String?,
      currentVersion: json['currentVersion'] as String?,
    );

Map<String, dynamic> _$HomeLegalPendingDtoToJson(
  _HomeLegalPendingDto instance,
) => <String, dynamic>{
  'documentType': instance.documentType,
  'currentVersion': instance.currentVersion,
};

_HomeExploreDto _$HomeExploreDtoFromJson(Map<String, dynamic> json) =>
    _HomeExploreDto(
      lostNearbyCount: (json['lostNearbyCount'] as num?)?.toInt(),
      adoptionAvailableCount: (json['adoptionAvailableCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HomeExploreDtoToJson(_HomeExploreDto instance) =>
    <String, dynamic>{
      'lostNearbyCount': instance.lostNearbyCount,
      'adoptionAvailableCount': instance.adoptionAvailableCount,
    };

_HomePetDto _$HomePetDtoFromJson(Map<String, dynamic> json) => _HomePetDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$HomePetDtoToJson(_HomePetDto instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_HomeHeroDto _$HomeHeroDtoFromJson(Map<String, dynamic> json) => _HomeHeroDto(
  healthScore: json['healthScore'] == null
      ? null
      : HomeScoreDto.fromJson(json['healthScore'] as Map<String, dynamic>),
  nextVisit: json['nextVisit'] == null
      ? null
      : HomeNextVisitDto.fromJson(json['nextVisit'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeHeroDtoToJson(_HomeHeroDto instance) =>
    <String, dynamic>{
      'healthScore': instance.healthScore,
      'nextVisit': instance.nextVisit,
    };

_HomeScoreDto _$HomeScoreDtoFromJson(Map<String, dynamic> json) =>
    _HomeScoreDto(
      value: (json['value'] as num?)?.toInt() ?? 0,
      band: json['band'] as String? ?? 'No data',
    );

Map<String, dynamic> _$HomeScoreDtoToJson(_HomeScoreDto instance) =>
    <String, dynamic>{'value': instance.value, 'band': instance.band};

_HomeNextVisitDto _$HomeNextVisitDtoFromJson(Map<String, dynamic> json) =>
    _HomeNextVisitDto(
      appointmentId: (json['appointmentId'] as num).toInt(),
      petId: (json['petId'] as num).toInt(),
      petName: json['petName'] as String? ?? '',
      title: json['title'] as String? ?? '',
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      location: json['location'] as String?,
    );

Map<String, dynamic> _$HomeNextVisitDtoToJson(_HomeNextVisitDto instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'petId': instance.petId,
      'petName': instance.petName,
      'title': instance.title,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'location': instance.location,
    };

_HomeStatsDto _$HomeStatsDtoFromJson(Map<String, dynamic> json) =>
    _HomeStatsDto(
      health: json['health'] == null
          ? const HomeScoreDto()
          : HomeScoreDto.fromJson(json['health'] as Map<String, dynamic>),
      activity: json['activity'] == null
          ? const HomeActivityDto()
          : HomeActivityDto.fromJson(json['activity'] as Map<String, dynamic>),
      vaccines: json['vaccines'] == null
          ? const HomeVaccinesDto()
          : HomeVaccinesDto.fromJson(json['vaccines'] as Map<String, dynamic>),
      weight: json['weight'] == null
          ? null
          : HomeWeightDto.fromJson(json['weight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeStatsDtoToJson(_HomeStatsDto instance) =>
    <String, dynamic>{
      'health': instance.health,
      'activity': instance.activity,
      'vaccines': instance.vaccines,
      'weight': instance.weight,
    };

_HomeActivityDto _$HomeActivityDtoFromJson(Map<String, dynamic> json) =>
    _HomeActivityDto(
      minutes: (json['minutes'] as num?)?.toInt() ?? 0,
      activeDays: (json['activeDays'] as num?)?.toInt() ?? 0,
      windowDays: (json['windowDays'] as num?)?.toInt() ?? 7,
    );

Map<String, dynamic> _$HomeActivityDtoToJson(_HomeActivityDto instance) =>
    <String, dynamic>{
      'minutes': instance.minutes,
      'activeDays': instance.activeDays,
      'windowDays': instance.windowDays,
    };

_HomeVaccinesDto _$HomeVaccinesDtoFromJson(Map<String, dynamic> json) =>
    _HomeVaccinesDto(
      upcomingCount: (json['upcomingCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$HomeVaccinesDtoToJson(_HomeVaccinesDto instance) =>
    <String, dynamic>{'upcomingCount': instance.upcomingCount};

_HomeWeightDto _$HomeWeightDtoFromJson(Map<String, dynamic> json) =>
    _HomeWeightDto(
      value: (json['value'] as num?)?.toDouble() ?? 0,
      unit: json['unit'] as String? ?? 'kg',
      trend: json['trend'] as String?,
    );

Map<String, dynamic> _$HomeWeightDtoToJson(_HomeWeightDto instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
      'trend': instance.trend,
    };

_HomeUpcomingItemDto _$HomeUpcomingItemDtoFromJson(Map<String, dynamic> json) =>
    _HomeUpcomingItemDto(
      kind: json['kind'] as String? ?? 'medication',
      sourceId: (json['sourceId'] as num?)?.toInt() ?? 0,
      petId: (json['petId'] as num?)?.toInt() ?? 0,
      petName: json['petName'] as String? ?? '',
      title: json['title'] as String? ?? '',
      dueDate: DateTime.parse(json['dueDate'] as String),
      isOverdue: json['isOverdue'] as bool? ?? false,
    );

Map<String, dynamic> _$HomeUpcomingItemDtoToJson(
  _HomeUpcomingItemDto instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'sourceId': instance.sourceId,
  'petId': instance.petId,
  'petName': instance.petName,
  'title': instance.title,
  'dueDate': instance.dueDate.toIso8601String(),
  'isOverdue': instance.isOverdue,
};
