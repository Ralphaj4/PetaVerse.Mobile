import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/coat_color.dart';

part 'coat_color_dto.freezed.dart';
part 'coat_color_dto.g.dart';

/// Wire shape of the API's CoatColor lookup (`{id, name, displayName}`, camelCase).
@freezed
abstract class CoatColorDto with _$CoatColorDto {
  const factory CoatColorDto({
    required int id,
    @Default('') String name,
    // Backend-derived PascalCase-split label. Nullable so an older response
    // without it still parses; falls back to [name] in [toEntity].
    String? displayName,
  }) = _CoatColorDto;

  const CoatColorDto._();

  factory CoatColorDto.fromJson(Map<String, dynamic> json) =>
      _$CoatColorDtoFromJson(json);

  CoatColor toEntity() => CoatColor(
        id: id,
        name: name,
        displayName: (displayName != null && displayName!.isNotEmpty)
            ? displayName!
            : name,
      );
}
