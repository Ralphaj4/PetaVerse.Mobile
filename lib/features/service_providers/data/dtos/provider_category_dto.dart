import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/provider_category_ref.dart';

part 'provider_category_dto.freezed.dart';
part 'provider_category_dto.g.dart';

/// Wire shape of one row from `GET /api/service-providers/categories`.
@freezed
abstract class ProviderCategoryDto with _$ProviderCategoryDto {
  const factory ProviderCategoryDto({
    required int id,
    @Default('') String slug,
    @Default('') String name,
    @Default(0) int sortOrder,
  }) = _ProviderCategoryDto;

  const ProviderCategoryDto._();

  factory ProviderCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$ProviderCategoryDtoFromJson(json);

  ProviderCategoryRef toEntity() => ProviderCategoryRef(
        id: id,
        slug: slug,
        name: name,
        sortOrder: sortOrder,
      );
}
