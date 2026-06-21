// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VisionProfileDto _$VisionProfileDtoFromJson(Map<String, dynamic> json) =>
    _VisionProfileDto(
      id: (json['id'] as num).toInt(),
      speciesId: (json['speciesId'] as num).toInt(),
      speciesName: json['speciesName'] as String,
      version: (json['version'] as num).toInt(),
      colorMatrix: (json['colorMatrix'] as List<dynamic>)
          .map(
            (e) =>
                (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
          )
          .toList(),
      brightness: (json['brightness'] as num).toDouble(),
      contrast: (json['contrast'] as num).toDouble(),
      saturation: (json['saturation'] as num).toDouble(),
      description: json['description'] as String,
      funFact: json['funFact'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$VisionProfileDtoToJson(_VisionProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'speciesId': instance.speciesId,
      'speciesName': instance.speciesName,
      'version': instance.version,
      'colorMatrix': instance.colorMatrix,
      'brightness': instance.brightness,
      'contrast': instance.contrast,
      'saturation': instance.saturation,
      'description': instance.description,
      'funFact': instance.funFact,
      'isActive': instance.isActive,
    };
