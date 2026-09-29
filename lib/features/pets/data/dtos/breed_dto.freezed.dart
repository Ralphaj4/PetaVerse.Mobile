// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'breed_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BreedDto {

 int get id; String get name; String? get origin;
/// Create a copy of BreedDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BreedDtoCopyWith<BreedDto> get copyWith => _$BreedDtoCopyWithImpl<BreedDto>(this as BreedDto, _$identity);

  /// Serializes this BreedDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BreedDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.origin, origin) || other.origin == origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,origin);

@override
String toString() {
  return 'BreedDto(id: $id, name: $name, origin: $origin)';
}


}

/// @nodoc
abstract mixin class $BreedDtoCopyWith<$Res>  {
  factory $BreedDtoCopyWith(BreedDto value, $Res Function(BreedDto) _then) = _$BreedDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? origin
});




}
/// @nodoc
class _$BreedDtoCopyWithImpl<$Res>
    implements $BreedDtoCopyWith<$Res> {
  _$BreedDtoCopyWithImpl(this._self, this._then);

  final BreedDto _self;
  final $Res Function(BreedDto) _then;

/// Create a copy of BreedDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? origin = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BreedDto].
extension BreedDtoPatterns on BreedDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BreedDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BreedDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BreedDto value)  $default,){
final _that = this;
switch (_that) {
case _BreedDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BreedDto value)?  $default,){
final _that = this;
switch (_that) {
case _BreedDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? origin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BreedDto() when $default != null:
return $default(_that.id,_that.name,_that.origin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? origin)  $default,) {final _that = this;
switch (_that) {
case _BreedDto():
return $default(_that.id,_that.name,_that.origin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? origin)?  $default,) {final _that = this;
switch (_that) {
case _BreedDto() when $default != null:
return $default(_that.id,_that.name,_that.origin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BreedDto extends BreedDto {
  const _BreedDto({required this.id, this.name = '', this.origin}): super._();
  factory _BreedDto.fromJson(Map<String, dynamic> json) => _$BreedDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? origin;

/// Create a copy of BreedDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BreedDtoCopyWith<_BreedDto> get copyWith => __$BreedDtoCopyWithImpl<_BreedDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BreedDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BreedDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.origin, origin) || other.origin == origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,origin);

@override
String toString() {
  return 'BreedDto(id: $id, name: $name, origin: $origin)';
}


}

/// @nodoc
abstract mixin class _$BreedDtoCopyWith<$Res> implements $BreedDtoCopyWith<$Res> {
  factory _$BreedDtoCopyWith(_BreedDto value, $Res Function(_BreedDto) _then) = __$BreedDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? origin
});




}
/// @nodoc
class __$BreedDtoCopyWithImpl<$Res>
    implements _$BreedDtoCopyWith<$Res> {
  __$BreedDtoCopyWithImpl(this._self, this._then);

  final _BreedDto _self;
  final $Res Function(_BreedDto) _then;

/// Create a copy of BreedDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? origin = freezed,}) {
  return _then(_BreedDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
