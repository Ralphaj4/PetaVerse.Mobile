import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../legal/domain/entities/legal.dart';
import '../../../pawcare/domain/entities/health_reminder.dart';
import '../../../pawcare/domain/entities/pet_health_score.dart';
import '../../../pawcare/domain/entities/weight_record.dart';
import '../../domain/entities/home_summary.dart';

part 'home_summary_dto.freezed.dart';
part 'home_summary_dto.g.dart';

/// Wire shape of `GET /api/users/me/home-summary`.
@freezed
abstract class HomeSummaryDto with _$HomeSummaryDto {
  const factory HomeSummaryDto({
    required HomePetDto pet,
    required HomeHeroDto hero,
    required HomeStatsDto stats,
    @Default(<HomeUpcomingItemDto>[]) List<HomeUpcomingItemDto> upcoming,
    HomeExploreDto? explore,
    HomeLegalDto? legal,
  }) = _HomeSummaryDto;

  const HomeSummaryDto._();

  factory HomeSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$HomeSummaryDtoFromJson(json);

  HomeSummary toEntity() => HomeSummary(
        petId: pet.id,
        petName: pet.name,
        healthScore: hero.healthScore?.value ?? stats.health.value,
        healthBand: HealthBand.fromWire(
          hero.healthScore?.band ?? stats.health.band,
        ),
        nextVisit: hero.nextVisit?.toEntity(),
        activity: stats.activity.toEntity(),
        vaccinesUpcomingCount: stats.vaccines.upcomingCount,
        weight: stats.weight?.toEntity(),
        upcoming:
            upcoming.map((e) => e.toEntity()).toList(growable: false),
        lostNearbyCount: explore?.lostNearbyCount,
        adoptionAvailableCount: explore?.adoptionAvailableCount,
        // Null when the backend omitted the block (older server): the gate then
        // falls back to its authoritative /legal/status reconcile.
        legal: legal?.toEntity(),
      );
}

/// The legal pre-check delegated from /legal/status into the home-summary, so
/// the common "nothing owed" case is learned without a second round-trip.
/// Absent on older backends - treated as "nothing owed" (the gate then falls
/// through to its authoritative /legal/status reconcile).
@freezed
abstract class HomeLegalDto with _$HomeLegalDto {
  const factory HomeLegalDto({
    @Default(false) bool requiresAcceptance,
    @Default(<HomeLegalPendingDto>[]) List<HomeLegalPendingDto> pending,
  }) = _HomeLegalDto;

  const HomeLegalDto._();

  factory HomeLegalDto.fromJson(Map<String, dynamic> json) =>
      _$HomeLegalDtoFromJson(json);

  HomeLegal toEntity() => HomeLegal(
        requiresAcceptance: requiresAcceptance,
        pending: pending.map((e) => e.toEntity()).toList(growable: false),
      );
}

@freezed
abstract class HomeLegalPendingDto with _$HomeLegalPendingDto {
  const factory HomeLegalPendingDto({
    String? documentType,
    String? currentVersion,
  }) = _HomeLegalPendingDto;

  const HomeLegalPendingDto._();

  factory HomeLegalPendingDto.fromJson(Map<String, dynamic> json) =>
      _$HomeLegalPendingDtoFromJson(json);

  HomeLegalPending toEntity() => HomeLegalPending(
        documentType: LegalDocumentType.fromWire(documentType),
        currentVersion: currentVersion,
      );
}

/// Optional Home "Explore" counts (Lost & Found / Adoption). Absent until the
/// backend ships it - the tiles fall back to static subtitles.
@freezed
abstract class HomeExploreDto with _$HomeExploreDto {
  const factory HomeExploreDto({
    int? lostNearbyCount,
    int? adoptionAvailableCount,
  }) = _HomeExploreDto;

  factory HomeExploreDto.fromJson(Map<String, dynamic> json) =>
      _$HomeExploreDtoFromJson(json);
}

@freezed
abstract class HomePetDto with _$HomePetDto {
  const factory HomePetDto({
    required int id,
    @Default('') String name,
  }) = _HomePetDto;

  factory HomePetDto.fromJson(Map<String, dynamic> json) =>
      _$HomePetDtoFromJson(json);
}

@freezed
abstract class HomeHeroDto with _$HomeHeroDto {
  const factory HomeHeroDto({
    HomeScoreDto? healthScore,
    HomeNextVisitDto? nextVisit,
  }) = _HomeHeroDto;

  factory HomeHeroDto.fromJson(Map<String, dynamic> json) =>
      _$HomeHeroDtoFromJson(json);
}

@freezed
abstract class HomeScoreDto with _$HomeScoreDto {
  const factory HomeScoreDto({
    @Default(0) int value,
    @Default('No data') String band,
  }) = _HomeScoreDto;

  factory HomeScoreDto.fromJson(Map<String, dynamic> json) =>
      _$HomeScoreDtoFromJson(json);
}

@freezed
abstract class HomeNextVisitDto with _$HomeNextVisitDto {
  const factory HomeNextVisitDto({
    required int appointmentId,
    required int petId,
    @Default('') String petName,
    @Default('') String title,
    required DateTime scheduledAt,
    String? location,
  }) = _HomeNextVisitDto;

  const HomeNextVisitDto._();

  factory HomeNextVisitDto.fromJson(Map<String, dynamic> json) =>
      _$HomeNextVisitDtoFromJson(json);

  NextVisit toEntity() => NextVisit(
        appointmentId: appointmentId,
        petId: petId,
        petName: petName,
        title: title,
        scheduledAt: scheduledAt.toLocal(),
        location: location,
      );
}

@freezed
abstract class HomeStatsDto with _$HomeStatsDto {
  const factory HomeStatsDto({
    @Default(HomeScoreDto()) HomeScoreDto health,
    @Default(HomeActivityDto()) HomeActivityDto activity,
    @Default(HomeVaccinesDto()) HomeVaccinesDto vaccines,
    HomeWeightDto? weight,
  }) = _HomeStatsDto;

  factory HomeStatsDto.fromJson(Map<String, dynamic> json) =>
      _$HomeStatsDtoFromJson(json);
}

@freezed
abstract class HomeActivityDto with _$HomeActivityDto {
  const factory HomeActivityDto({
    @Default(0) int minutes,
    @Default(0) int activeDays,
    @Default(7) int windowDays,
  }) = _HomeActivityDto;

  const HomeActivityDto._();

  factory HomeActivityDto.fromJson(Map<String, dynamic> json) =>
      _$HomeActivityDtoFromJson(json);

  ActivityStat toEntity() => ActivityStat(
        minutes: minutes,
        activeDays: activeDays,
        windowDays: windowDays,
      );
}

@freezed
abstract class HomeVaccinesDto with _$HomeVaccinesDto {
  const factory HomeVaccinesDto({
    @Default(0) int upcomingCount,
  }) = _HomeVaccinesDto;

  factory HomeVaccinesDto.fromJson(Map<String, dynamic> json) =>
      _$HomeVaccinesDtoFromJson(json);
}

@freezed
abstract class HomeWeightDto with _$HomeWeightDto {
  const factory HomeWeightDto({
    @Default(0) double value,
    @Default('kg') String unit,
    String? trend,
  }) = _HomeWeightDto;

  const HomeWeightDto._();

  factory HomeWeightDto.fromJson(Map<String, dynamic> json) =>
      _$HomeWeightDtoFromJson(json);

  WeightStat toEntity() => WeightStat(
        value: value,
        unit: WeightUnit.fromWire(unit),
        trend: WeightTrend.fromWire(trend),
      );
}

@freezed
abstract class HomeUpcomingItemDto with _$HomeUpcomingItemDto {
  const factory HomeUpcomingItemDto({
    @Default('medication') String kind,
    @Default(0) int sourceId,
    @Default(0) int petId,
    @Default('') String petName,
    @Default('') String title,
    required DateTime dueDate,
    @Default(false) bool isOverdue,
  }) = _HomeUpcomingItemDto;

  const HomeUpcomingItemDto._();

  factory HomeUpcomingItemDto.fromJson(Map<String, dynamic> json) =>
      _$HomeUpcomingItemDtoFromJson(json);

  HealthReminder toEntity() => HealthReminder(
        kind: HealthReminderKind.values.firstWhere(
          (k) => k.name == kind,
          orElse: () => HealthReminderKind.medication,
        ),
        sourceId: sourceId,
        petId: petId,
        petName: petName,
        title: title,
        dueDate: dueDate.toLocal(),
      );
}
