// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BreedDto _$BreedDtoFromJson(Map<String, dynamic> json) => _BreedDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  origin: json['origin'] as String?,
);

Map<String, dynamic> _$BreedDtoToJson(_BreedDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'origin': instance.origin,
};
