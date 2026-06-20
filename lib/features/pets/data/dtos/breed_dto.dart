import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/breed.dart';

part 'breed_dto.freezed.dart';
part 'breed_dto.g.dart';

/// Wire shape of the API's BreedResponse (`{id, name, origin}`, camelCase).
@freezed
abstract class BreedDto with _$BreedDto {
  const factory BreedDto({
    required int id,
    @Default('') String name,
    String? origin,
  }) = _BreedDto;

  const BreedDto._();

  factory BreedDto.fromJson(Map<String, dynamic> json) =>
      _$BreedDtoFromJson(json);

  Breed toEntity() => Breed(id: id, name: name, origin: origin);
}
