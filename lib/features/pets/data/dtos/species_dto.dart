import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/species.dart';

part 'species_dto.freezed.dart';
part 'species_dto.g.dart';

/// Wire shape of the API's SpeciesResponse (`{id, name}`, camelCase).
@freezed
abstract class SpeciesDto with _$SpeciesDto {
  const factory SpeciesDto({
    required int id,
    @Default('') String name,
  }) = _SpeciesDto;

  const SpeciesDto._();

  factory SpeciesDto.fromJson(Map<String, dynamic> json) =>
      _$SpeciesDtoFromJson(json);

  Species toEntity() => Species(id: id, name: name);
}
