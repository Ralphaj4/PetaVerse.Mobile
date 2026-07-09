// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PetDto _$PetDtoFromJson(Map<String, dynamic> json) => _PetDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  gender: json['gender'] as String? ?? '',
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  breedId: (json['breedId'] as num?)?.toInt(),
  breedName: json['breedName'] as String?,
  speciesName: json['speciesName'] as String?,
  pelage: json['pelage'] as String?,
  microchipNumber: json['microchipNumber'] as String?,
  microchipLocation: json['microchipLocation'] as String?,
  sterilizationStatus: json['sterilizationStatus'] as String?,
  sterilizationDate: json['sterilizationDate'] == null
      ? null
      : DateTime.parse(json['sterilizationDate'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  avatarUrl: json['avatarUrl'] as String?,
  isPrimaryOwner: json['isPrimaryOwner'] as bool? ?? true,
);

Map<String, dynamic> _$PetDtoToJson(_PetDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'gender': instance.gender,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'breedId': instance.breedId,
  'breedName': instance.breedName,
  'speciesName': instance.speciesName,
  'pelage': instance.pelage,
  'microchipNumber': instance.microchipNumber,
  'microchipLocation': instance.microchipLocation,
  'sterilizationStatus': instance.sterilizationStatus,
  'sterilizationDate': instance.sterilizationDate?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'avatarUrl': instance.avatarUrl,
  'isPrimaryOwner': instance.isPrimaryOwner,
};
