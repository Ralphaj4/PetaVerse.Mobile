// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_pet_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePetResponseDto _$CreatePetResponseDtoFromJson(
  Map<String, dynamic> json,
) => _CreatePetResponseDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  imagePath: json['imagePath'] as String? ?? '',
);

Map<String, dynamic> _$CreatePetResponseDtoToJson(
  _CreatePetResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'imagePath': instance.imagePath,
};
