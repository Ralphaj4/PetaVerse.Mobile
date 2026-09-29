// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_size_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetSizeDto _$PetSizeDtoFromJson(Map<String, dynamic> json) => _PetSizeDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  displayName: json['displayName'] as String?,
);

Map<String, dynamic> _$PetSizeDtoToJson(_PetSizeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
    };
