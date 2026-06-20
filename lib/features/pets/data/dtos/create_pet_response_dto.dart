import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pet_ref.dart';

part 'create_pet_response_dto.freezed.dart';
part 'create_pet_response_dto.g.dart';

/// Wire shape of the API's CreatePetResponse — the slim ack returned by
/// POST /api/pets: `{id, name, imagePath}`. It is NOT a full pet record, so
/// it maps to a lightweight [PetRef], not a Pet.
@freezed
abstract class CreatePetResponseDto with _$CreatePetResponseDto {
  const factory CreatePetResponseDto({
    required int id,
    @Default('') String name,
    @Default('') String imagePath,
  }) = _CreatePetResponseDto;

  const CreatePetResponseDto._();

  factory CreatePetResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePetResponseDtoFromJson(json);

  PetRef toRef() => PetRef(
        id: id,
        name: name,
        imagePath: imagePath.isEmpty ? null : imagePath,
      );
}
