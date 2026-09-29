import '../../domain/entities/walk_activity.dart';

class WalkActivityDto {
  const WalkActivityDto({
    required this.id,
    required this.petId,
    required this.startedAt,
    required this.endedAt,
    required this.durationSeconds,
    this.distanceMeters,
    this.avgSpeedKmh,
  });

  final int id;
  final int petId;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationSeconds;
  final double? distanceMeters;
  final double? avgSpeedKmh;

  /// [petId] is passed in from the request context — the list endpoint
  /// omits it from each item since it's implied by the URL.
  factory WalkActivityDto.fromJson(Map<String, dynamic> json, {int petId = 0}) =>
      WalkActivityDto(
        id: (json['id'] as num).toInt(),
        petId: (json['petId'] as num?)?.toInt() ?? petId,
        startedAt: DateTime.parse(json['startedAt'] as String),
        endedAt: DateTime.parse(json['endedAt'] as String),
        durationSeconds: (json['durationSeconds'] as num).toInt(),
        distanceMeters: (json['distanceMeters'] as num?)?.toDouble(),
        avgSpeedKmh: (json['avgSpeedKmh'] as num?)?.toDouble(),
      );

  WalkActivity toEntity() => WalkActivity(
        id: id,
        petId: petId,
        startedAt: startedAt,
        endedAt: endedAt,
        durationSeconds: durationSeconds,
        distanceMeters: distanceMeters,
        avgSpeedKmh: avgSpeedKmh,
      );
}

class WalkActivityPageDto {
  const WalkActivityPageDto({
    required this.items,
    required this.totalCount,
  });

  final List<WalkActivityDto> items;
  final int totalCount;

  factory WalkActivityPageDto.fromJson(Map<String, dynamic> json,
      {int petId = 0}) {
    final rawItems = (json['items'] ?? json['data'] ?? json['results'])
        as List<dynamic>? ??
        const [];
    final items = rawItems
        .map((e) =>
            WalkActivityDto.fromJson(e as Map<String, dynamic>, petId: petId))
        .toList(growable: false);
    return WalkActivityPageDto(
      items: items,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? items.length,
    );
  }

  /// Handles a backend that returns a bare JSON array instead of a page object.
  factory WalkActivityPageDto.fromList(List<dynamic> json, {int petId = 0}) {
    final items = json
        .map((e) =>
            WalkActivityDto.fromJson(e as Map<String, dynamic>, petId: petId))
        .toList(growable: false);
    return WalkActivityPageDto(items: items, totalCount: items.length);
  }
}
