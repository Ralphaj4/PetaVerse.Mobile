// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_category_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProviderCategoryDto {

 int get id; String get slug; String get name; int get sortOrder;
/// Create a copy of ProviderCategoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderCategoryDtoCopyWith<ProviderCategoryDto> get copyWith => _$ProviderCategoryDtoCopyWithImpl<ProviderCategoryDto>(this as ProviderCategoryDto, _$identity);

  /// Serializes this ProviderCategoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderCategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slug,name,sortOrder);

@override
String toString() {
  return 'ProviderCategoryDto(id: $id, slug: $slug, name: $name, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $ProviderCategoryDtoCopyWith<$Res>  {
  factory $ProviderCategoryDtoCopyWith(ProviderCategoryDto value, $Res Function(ProviderCategoryDto) _then) = _$ProviderCategoryDtoCopyWithImpl;
@useResult
$Res call({
 int id, String slug, String name, int sortOrder
});




}
/// @nodoc
class _$ProviderCategoryDtoCopyWithImpl<$Res>
    implements $ProviderCategoryDtoCopyWith<$Res> {
  _$ProviderCategoryDtoCopyWithImpl(this._self, this._then);

  final ProviderCategoryDto _self;
  final $Res Function(ProviderCategoryDto) _then;

/// Create a copy of ProviderCategoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderCategoryDto].
extension ProviderCategoryDtoPatterns on ProviderCategoryDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderCategoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderCategoryDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderCategoryDto value)  $default,){
final _that = this;
switch (_that) {
case _ProviderCategoryDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderCategoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderCategoryDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String slug,  String name,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderCategoryDto() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.sortOrder);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String slug,  String name,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _ProviderCategoryDto():
return $default(_that.id,_that.slug,_that.name,_that.sortOrder);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String slug,  String name,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _ProviderCategoryDto() when $default != null:
return $default(_that.id,_that.slug,_that.name,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderCategoryDto extends ProviderCategoryDto {
  const _ProviderCategoryDto({required this.id, this.slug = '', this.name = '', this.sortOrder = 0}): super._();
  factory _ProviderCategoryDto.fromJson(Map<String, dynamic> json) => _$ProviderCategoryDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String slug;
@override@JsonKey() final  String name;
@override@JsonKey() final  int sortOrder;

/// Create a copy of ProviderCategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderCategoryDtoCopyWith<_ProviderCategoryDto> get copyWith => __$ProviderCategoryDtoCopyWithImpl<_ProviderCategoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderCategoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderCategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slug,name,sortOrder);

@override
String toString() {
  return 'ProviderCategoryDto(id: $id, slug: $slug, name: $name, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$ProviderCategoryDtoCopyWith<$Res> implements $ProviderCategoryDtoCopyWith<$Res> {
  factory _$ProviderCategoryDtoCopyWith(_ProviderCategoryDto value, $Res Function(_ProviderCategoryDto) _then) = __$ProviderCategoryDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String slug, String name, int sortOrder
});




}
/// @nodoc
class __$ProviderCategoryDtoCopyWithImpl<$Res>
    implements _$ProviderCategoryDtoCopyWith<$Res> {
  __$ProviderCategoryDtoCopyWithImpl(this._self, this._then);

  final _ProviderCategoryDto _self;
  final $Res Function(_ProviderCategoryDto) _then;

/// Create a copy of ProviderCategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? name = null,Object? sortOrder = null,}) {
  return _then(_ProviderCategoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
