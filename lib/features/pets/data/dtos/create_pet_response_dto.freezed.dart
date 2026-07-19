// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_pet_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatePetResponseDto {

 int get id; String get name; String get imagePath;// Parsed if the backend includes it so a just-created activity pet shows
// the walk banner immediately; otherwise the next reconcile fills it in.
 bool get speciesSupportsActivityTracking;
/// Create a copy of CreatePetResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePetResponseDtoCopyWith<CreatePetResponseDto> get copyWith => _$CreatePetResponseDtoCopyWithImpl<CreatePetResponseDto>(this as CreatePetResponseDto, _$identity);

  /// Serializes this CreatePetResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePetResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.speciesSupportsActivityTracking, speciesSupportsActivityTracking) || other.speciesSupportsActivityTracking == speciesSupportsActivityTracking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imagePath,speciesSupportsActivityTracking);

@override
String toString() {
  return 'CreatePetResponseDto(id: $id, name: $name, imagePath: $imagePath, speciesSupportsActivityTracking: $speciesSupportsActivityTracking)';
}


}

/// @nodoc
abstract mixin class $CreatePetResponseDtoCopyWith<$Res>  {
  factory $CreatePetResponseDtoCopyWith(CreatePetResponseDto value, $Res Function(CreatePetResponseDto) _then) = _$CreatePetResponseDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String imagePath, bool speciesSupportsActivityTracking
});




}
/// @nodoc
class _$CreatePetResponseDtoCopyWithImpl<$Res>
    implements $CreatePetResponseDtoCopyWith<$Res> {
  _$CreatePetResponseDtoCopyWithImpl(this._self, this._then);

  final CreatePetResponseDto _self;
  final $Res Function(CreatePetResponseDto) _then;

/// Create a copy of CreatePetResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imagePath = null,Object? speciesSupportsActivityTracking = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,speciesSupportsActivityTracking: null == speciesSupportsActivityTracking ? _self.speciesSupportsActivityTracking : speciesSupportsActivityTracking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePetResponseDto].
extension CreatePetResponseDtoPatterns on CreatePetResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePetResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePetResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePetResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CreatePetResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePetResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePetResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String imagePath,  bool speciesSupportsActivityTracking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePetResponseDto() when $default != null:
return $default(_that.id,_that.name,_that.imagePath,_that.speciesSupportsActivityTracking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String imagePath,  bool speciesSupportsActivityTracking)  $default,) {final _that = this;
switch (_that) {
case _CreatePetResponseDto():
return $default(_that.id,_that.name,_that.imagePath,_that.speciesSupportsActivityTracking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String imagePath,  bool speciesSupportsActivityTracking)?  $default,) {final _that = this;
switch (_that) {
case _CreatePetResponseDto() when $default != null:
return $default(_that.id,_that.name,_that.imagePath,_that.speciesSupportsActivityTracking);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePetResponseDto extends CreatePetResponseDto {
  const _CreatePetResponseDto({required this.id, this.name = '', this.imagePath = '', this.speciesSupportsActivityTracking = false}): super._();
  factory _CreatePetResponseDto.fromJson(Map<String, dynamic> json) => _$CreatePetResponseDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String imagePath;
// Parsed if the backend includes it so a just-created activity pet shows
// the walk banner immediately; otherwise the next reconcile fills it in.
@override@JsonKey() final  bool speciesSupportsActivityTracking;

/// Create a copy of CreatePetResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePetResponseDtoCopyWith<_CreatePetResponseDto> get copyWith => __$CreatePetResponseDtoCopyWithImpl<_CreatePetResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePetResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePetResponseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.speciesSupportsActivityTracking, speciesSupportsActivityTracking) || other.speciesSupportsActivityTracking == speciesSupportsActivityTracking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imagePath,speciesSupportsActivityTracking);

@override
String toString() {
  return 'CreatePetResponseDto(id: $id, name: $name, imagePath: $imagePath, speciesSupportsActivityTracking: $speciesSupportsActivityTracking)';
}


}

/// @nodoc
abstract mixin class _$CreatePetResponseDtoCopyWith<$Res> implements $CreatePetResponseDtoCopyWith<$Res> {
  factory _$CreatePetResponseDtoCopyWith(_CreatePetResponseDto value, $Res Function(_CreatePetResponseDto) _then) = __$CreatePetResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String imagePath, bool speciesSupportsActivityTracking
});




}
/// @nodoc
class __$CreatePetResponseDtoCopyWithImpl<$Res>
    implements _$CreatePetResponseDtoCopyWith<$Res> {
  __$CreatePetResponseDtoCopyWithImpl(this._self, this._then);

  final _CreatePetResponseDto _self;
  final $Res Function(_CreatePetResponseDto) _then;

/// Create a copy of CreatePetResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imagePath = null,Object? speciesSupportsActivityTracking = null,}) {
  return _then(_CreatePetResponseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,speciesSupportsActivityTracking: null == speciesSupportsActivityTracking ? _self.speciesSupportsActivityTracking : speciesSupportsActivityTracking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
