// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProviderCategoryDto _$ProviderCategoryDtoFromJson(Map<String, dynamic> json) =>
    _ProviderCategoryDto(
      id: (json['id'] as num).toInt(),
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProviderCategoryDtoToJson(
  _ProviderCategoryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'slug': instance.slug,
  'name': instance.name,
  'sortOrder': instance.sortOrder,
};
