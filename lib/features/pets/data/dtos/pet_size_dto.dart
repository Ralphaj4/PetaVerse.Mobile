import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pet_size.dart';

part 'pet_size_dto.freezed.dart';
part 'pet_size_dto.g.dart';

/// Wire shape of the API's PetSize lookup (`{id, name, displayName}`, camelCase).
@freezed
abstract class PetSizeDto with _$PetSizeDto {
  const factory PetSizeDto({
    required int id,
    @Default('') String name,
    // Backend-derived PascalCase-split label. Nullable so an older response
    // without it still parses; falls back to [name] in [toEntity].
    String? displayName,
  }) = _PetSizeDto;

  const PetSizeDto._();

  factory PetSizeDto.fromJson(Map<String, dynamic> json) =>
      _$PetSizeDtoFromJson(json);

  PetSize toEntity() => PetSize(
        id: id,
        name: name,
        displayName: (displayName != null && displayName!.isNotEmpty)
            ? displayName!
            : name,
      );
}
