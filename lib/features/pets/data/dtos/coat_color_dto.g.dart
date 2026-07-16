// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coat_color_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoatColorDto _$CoatColorDtoFromJson(Map<String, dynamic> json) =>
    _CoatColorDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      displayName: json['displayName'] as String?,
    );

Map<String, dynamic> _$CoatColorDtoToJson(_CoatColorDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
    };
