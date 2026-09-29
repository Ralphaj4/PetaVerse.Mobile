// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationDataDto _$NotificationDataDtoFromJson(Map<String, dynamic> json) =>
    _NotificationDataDto(
      route: json['route'] as String?,
      petId: json['petId'] as String?,
    );

Map<String, dynamic> _$NotificationDataDtoToJson(
  _NotificationDataDto instance,
) => <String, dynamic>{'route': instance.route, 'petId': instance.petId};

_AppNotificationDto _$AppNotificationDtoFromJson(Map<String, dynamic> json) =>
    _AppNotificationDto(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      data: json['data'] == null
          ? null
          : NotificationDataDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppNotificationDtoToJson(_AppNotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'category': instance.category,
      'title': instance.title,
      'body': instance.body,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'data': instance.data,
    };

_NotificationPageDto _$NotificationPageDtoFromJson(Map<String, dynamic> json) =>
    _NotificationPageDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => AppNotificationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$NotificationPageDtoToJson(
  _NotificationPageDto instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'page': instance.page,
  'pageSize': instance.pageSize,
  'hasMore': instance.hasMore,
};

_UnreadCountDto _$UnreadCountDtoFromJson(Map<String, dynamic> json) =>
    _UnreadCountDto(count: (json['count'] as num).toInt());

Map<String, dynamic> _$UnreadCountDtoToJson(_UnreadCountDto instance) =>
    <String, dynamic>{'count': instance.count};
