import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/vision_profile.dart';

part 'vision_profile_dto.freezed.dart';
part 'vision_profile_dto.g.dart';

@freezed
abstract class VisionProfileDto with _$VisionProfileDto {
  const factory VisionProfileDto({
    required int id,
    required int speciesId,
    required String speciesName,
    required int version,
    required List<List<double>> colorMatrix,
    required double brightness,
    required double contrast,
    required double saturation,
    required String description,
    required String funFact,
    required bool isActive,
  }) = _VisionProfileDto;

  factory VisionProfileDto.fromJson(Map<String, dynamic> json) =>
      _$VisionProfileDtoFromJson(json);
}

extension VisionProfileDtoExt on VisionProfileDto {
  VisionProfile toEntity() {
    return VisionProfile(
      speciesName: speciesName.toLowerCase(),
      displayName: speciesName,
      description: description,
      funFact: funFact,
      colorMatrix: colorMatrix,
      brightness: brightness,
      contrast: contrast,
      saturation: saturation,
    );
  }
}
