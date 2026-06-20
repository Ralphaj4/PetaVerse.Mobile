// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpeciesDto _$SpeciesDtoFromJson(Map<String, dynamic> json) => _SpeciesDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$SpeciesDtoToJson(_SpeciesDto instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
