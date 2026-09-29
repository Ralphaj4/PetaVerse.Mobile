import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pet.dart';
import '../../domain/entities/pet_ref.dart';

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
    int? sizeId,
    String? sizeName,
    int? coatColorId,
    String? coatColorName,
    String? microchipNumber,
    String? microchipLocation,
    String? sterilizationStatus,
    DateTime? sterilizationDate,
    DateTime? createdAt,
    // Public CDN URL of the pet's avatar, or null when none is set/confirmed.
    String? avatarUrl,
    // True when the requesting user is this pet's primary owner (creator);
    // false for a co-owner. Gates primary-only UI (e.g. Invite Co-Owner).
    @Default(true) bool isPrimaryOwner,
    // True when the pet's species supports activity (walk) tracking.
    // Gates the home-screen walk banner.
    @Default(false) bool speciesSupportsActivityTracking,
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
        sizeId: sizeId,
        sizeName: sizeName,
        coatColorId: coatColorId,
        coatColorName: coatColorName,
        microchipNumber: microchipNumber,
        microchipLocation: microchipLocation,
        sterilizationStatus: sterilizationStatus,
        sterilizationDate: sterilizationDate,
        createdAt: createdAt,
        avatarUrl: avatarUrl,
        isPrimaryOwner: isPrimaryOwner,
        supportsActivityTracking: speciesSupportsActivityTracking,
      );

  /// Slim identity for the routing gate / current-pet pointer, carrying the
  /// avatar so the home hero can render it from a fetched list.
  PetRef toRef() => PetRef(
        id: id,
        name: name,
        imagePath: (avatarUrl != null && avatarUrl!.isNotEmpty)
            ? avatarUrl
            : null,
        supportsActivityTracking: speciesSupportsActivityTracking,
      );
}
