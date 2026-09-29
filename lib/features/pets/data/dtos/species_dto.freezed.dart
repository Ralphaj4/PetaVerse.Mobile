// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'species_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpeciesDto {

 int get id; String get name;
/// Create a copy of SpeciesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeciesDtoCopyWith<SpeciesDto> get copyWith => _$SpeciesDtoCopyWithImpl<SpeciesDto>(this as SpeciesDto, _$identity);

  /// Serializes this SpeciesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeciesDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'SpeciesDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $SpeciesDtoCopyWith<$Res>  {
  factory $SpeciesDtoCopyWith(SpeciesDto value, $Res Function(SpeciesDto) _then) = _$SpeciesDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class _$SpeciesDtoCopyWithImpl<$Res>
    implements $SpeciesDtoCopyWith<$Res> {
  _$SpeciesDtoCopyWithImpl(this._self, this._then);

  final SpeciesDto _self;
  final $Res Function(SpeciesDto) _then;

/// Create a copy of SpeciesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeciesDto].
extension SpeciesDtoPatterns on SpeciesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeciesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeciesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeciesDto value)  $default,){
final _that = this;
switch (_that) {
case _SpeciesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeciesDto value)?  $default,){
final _that = this;
switch (_that) {
case _SpeciesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeciesDto() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name)  $default,) {final _that = this;
switch (_that) {
case _SpeciesDto():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _SpeciesDto() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpeciesDto extends SpeciesDto {
  const _SpeciesDto({required this.id, this.name = ''}): super._();
  factory _SpeciesDto.fromJson(Map<String, dynamic> json) => _$SpeciesDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;

/// Create a copy of SpeciesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeciesDtoCopyWith<_SpeciesDto> get copyWith => __$SpeciesDtoCopyWithImpl<_SpeciesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpeciesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeciesDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'SpeciesDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$SpeciesDtoCopyWith<$Res> implements $SpeciesDtoCopyWith<$Res> {
  factory _$SpeciesDtoCopyWith(_SpeciesDto value, $Res Function(_SpeciesDto) _then) = __$SpeciesDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class __$SpeciesDtoCopyWithImpl<$Res>
    implements _$SpeciesDtoCopyWith<$Res> {
  __$SpeciesDtoCopyWithImpl(this._self, this._then);

  final _SpeciesDto _self;
  final $Res Function(_SpeciesDto) _then;

/// Create a copy of SpeciesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_SpeciesDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
