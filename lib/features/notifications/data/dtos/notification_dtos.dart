import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/app_notification.dart';

part 'notification_dtos.freezed.dart';
part 'notification_dtos.g.dart';

@freezed
abstract class NotificationDataDto with _$NotificationDataDto {
  const factory NotificationDataDto({
    String? route,
    String? petId,
  }) = _NotificationDataDto;

  const NotificationDataDto._();

  factory NotificationDataDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataDtoFromJson(json);
}

@freezed
abstract class AppNotificationDto with _$AppNotificationDto {
  const factory AppNotificationDto({
    required int id,
    required String type,
    required String category,
    required String title,
    required String body,
    required bool isRead,
    required DateTime createdAt,
    NotificationDataDto? data,
  }) = _AppNotificationDto;

  const AppNotificationDto._();

  factory AppNotificationDto.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationDtoFromJson(json);

  AppNotification toEntity() => AppNotification(
        id: id,
        type: type,
        category: category,
        title: title,
        body: body,
        isRead: isRead,
        createdAt: createdAt,
        route: data?.route,
        petId: int.tryParse(data?.petId ?? ''),
      );
}

@freezed
abstract class NotificationPageDto with _$NotificationPageDto {
  const factory NotificationPageDto({
    required List<AppNotificationDto> items,
    required int totalCount,
    required int page,
    required int pageSize,
    required bool hasMore,
  }) = _NotificationPageDto;

  const NotificationPageDto._();

  factory NotificationPageDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationPageDtoFromJson(json);
}

@freezed
abstract class UnreadCountDto with _$UnreadCountDto {
  const factory UnreadCountDto({
    required int count,
  }) = _UnreadCountDto;

  const UnreadCountDto._();

  factory UnreadCountDto.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountDtoFromJson(json);
}
