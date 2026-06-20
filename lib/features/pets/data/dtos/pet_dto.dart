import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pet.dart';

part 'pet_dto.freezed.dart';
part 'pet_dto.g.dart';

/// Wire shape of the API's PetResponse (camelCase JSON from /api/pets).
///
/// Only [id], [name], [gender] and [dateOfBirth] are guaranteed by the
/// backend; everything else is nullable to parse defensively.
@freezed
abstract class PetDto with _$PetDto {
  const factory PetDto({
    required int id,
    required String name,
    @Default('') String gender,
    DateTime? dateOfBirth,
    int? breedId,
    String? breedName,
    String? speciesName,
    String? pelage,
    String? microchipNumber,
    String? microchipLocation,
    String? sterilizationStatus,
    DateTime? sterilizationDate,
    DateTime? createdAt,
  }) = _PetDto;

  const PetDto._();

  factory PetDto.fromJson(Map<String, dynamic> json) =>
      _$PetDtoFromJson(json);

  /// Maps the DTO onto the domain entity. [dateOfBirth] is required by the
  /// domain; a missing value falls back to the epoch so a malformed record
  /// never crashes the routing gate.
  Pet toEntity() => Pet(
        id: id,
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth ?? DateTime.fromMillisecondsSinceEpoch(0),
        breedId: breedId,
        breedName: breedName,
        speciesName: speciesName,
        pelage: pelage,
        microchipNumber: microchipNumber,
        microchipLocation: microchipLocation,
        sterilizationStatus: sterilizationStatus,
        sterilizationDate: sterilizationDate,
        createdAt: createdAt,
      );
}
