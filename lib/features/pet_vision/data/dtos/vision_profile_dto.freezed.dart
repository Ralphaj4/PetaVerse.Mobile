// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vision_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VisionProfileDto {

 int get id; int get speciesId; String get speciesName; int get version; List<List<double>> get colorMatrix; double get brightness; double get contrast; double get saturation; String get description; String get funFact; DateTime get effectiveDate; bool get isActive;
/// Create a copy of VisionProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisionProfileDtoCopyWith<VisionProfileDto> get copyWith => _$VisionProfileDtoCopyWithImpl<VisionProfileDto>(this as VisionProfileDto, _$identity);

  /// Serializes this VisionProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisionProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.colorMatrix, colorMatrix)&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.contrast, contrast) || other.contrast == contrast)&&(identical(other.saturation, saturation) || other.saturation == saturation)&&(identical(other.description, description) || other.description == description)&&(identical(other.funFact, funFact) || other.funFact == funFact)&&(identical(other.effectiveDate, effectiveDate) || other.effectiveDate == effectiveDate)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,speciesId,speciesName,version,const DeepCollectionEquality().hash(colorMatrix),brightness,contrast,saturation,description,funFact,effectiveDate,isActive);

@override
String toString() {
  return 'VisionProfileDto(id: $id, speciesId: $speciesId, speciesName: $speciesName, version: $version, colorMatrix: $colorMatrix, brightness: $brightness, contrast: $contrast, saturation: $saturation, description: $description, funFact: $funFact, effectiveDate: $effectiveDate, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $VisionProfileDtoCopyWith<$Res>  {
  factory $VisionProfileDtoCopyWith(VisionProfileDto value, $Res Function(VisionProfileDto) _then) = _$VisionProfileDtoCopyWithImpl;
@useResult
$Res call({
 int id, int speciesId, String speciesName, int version, List<List<double>> colorMatrix, double brightness, double contrast, double saturation, String description, String funFact, DateTime effectiveDate, bool isActive
});




}
/// @nodoc
class _$VisionProfileDtoCopyWithImpl<$Res>
    implements $VisionProfileDtoCopyWith<$Res> {
  _$VisionProfileDtoCopyWithImpl(this._self, this._then);

  final VisionProfileDto _self;
  final $Res Function(VisionProfileDto) _then;

/// Create a copy of VisionProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? speciesId = null,Object? speciesName = null,Object? version = null,Object? colorMatrix = null,Object? brightness = null,Object? contrast = null,Object? saturation = null,Object? description = null,Object? funFact = null,Object? effectiveDate = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int,speciesName: null == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,colorMatrix: null == colorMatrix ? _self.colorMatrix : colorMatrix // ignore: cast_nullable_to_non_nullable
as List<List<double>>,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as double,contrast: null == contrast ? _self.contrast : contrast // ignore: cast_nullable_to_non_nullable
as double,saturation: null == saturation ? _self.saturation : saturation // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,funFact: null == funFact ? _self.funFact : funFact // ignore: cast_nullable_to_non_nullable
as String,effectiveDate: null == effectiveDate ? _self.effectiveDate : effectiveDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VisionProfileDto].
extension VisionProfileDtoPatterns on VisionProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisionProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisionProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisionProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _VisionProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisionProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _VisionProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int speciesId,  String speciesName,  int version,  List<List<double>> colorMatrix,  double brightness,  double contrast,  double saturation,  String description,  String funFact,  DateTime effectiveDate,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisionProfileDto() when $default != null:
return $default(_that.id,_that.speciesId,_that.speciesName,_that.version,_that.colorMatrix,_that.brightness,_that.contrast,_that.saturation,_that.description,_that.funFact,_that.effectiveDate,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int speciesId,  String speciesName,  int version,  List<List<double>> colorMatrix,  double brightness,  double contrast,  double saturation,  String description,  String funFact,  DateTime effectiveDate,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _VisionProfileDto():
return $default(_that.id,_that.speciesId,_that.speciesName,_that.version,_that.colorMatrix,_that.brightness,_that.contrast,_that.saturation,_that.description,_that.funFact,_that.effectiveDate,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int speciesId,  String speciesName,  int version,  List<List<double>> colorMatrix,  double brightness,  double contrast,  double saturation,  String description,  String funFact,  DateTime effectiveDate,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _VisionProfileDto() when $default != null:
return $default(_that.id,_that.speciesId,_that.speciesName,_that.version,_that.colorMatrix,_that.brightness,_that.contrast,_that.saturation,_that.description,_that.funFact,_that.effectiveDate,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VisionProfileDto implements VisionProfileDto {
  const _VisionProfileDto({required this.id, required this.speciesId, required this.speciesName, required this.version, required final  List<List<double>> colorMatrix, required this.brightness, required this.contrast, required this.saturation, required this.description, required this.funFact, required this.effectiveDate, required this.isActive}): _colorMatrix = colorMatrix;
  factory _VisionProfileDto.fromJson(Map<String, dynamic> json) => _$VisionProfileDtoFromJson(json);

@override final  int id;
@override final  int speciesId;
@override final  String speciesName;
@override final  int version;
 final  List<List<double>> _colorMatrix;
@override List<List<double>> get colorMatrix {
  if (_colorMatrix is EqualUnmodifiableListView) return _colorMatrix;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_colorMatrix);
}

@override final  double brightness;
@override final  double contrast;
@override final  double saturation;
@override final  String description;
@override final  String funFact;
@override final  DateTime effectiveDate;
@override final  bool isActive;

/// Create a copy of VisionProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisionProfileDtoCopyWith<_VisionProfileDto> get copyWith => __$VisionProfileDtoCopyWithImpl<_VisionProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisionProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisionProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._colorMatrix, _colorMatrix)&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.contrast, contrast) || other.contrast == contrast)&&(identical(other.saturation, saturation) || other.saturation == saturation)&&(identical(other.description, description) || other.description == description)&&(identical(other.funFact, funFact) || other.funFact == funFact)&&(identical(other.effectiveDate, effectiveDate) || other.effectiveDate == effectiveDate)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,speciesId,speciesName,version,const DeepCollectionEquality().hash(_colorMatrix),brightness,contrast,saturation,description,funFact,effectiveDate,isActive);

@override
String toString() {
  return 'VisionProfileDto(id: $id, speciesId: $speciesId, speciesName: $speciesName, version: $version, colorMatrix: $colorMatrix, brightness: $brightness, contrast: $contrast, saturation: $saturation, description: $description, funFact: $funFact, effectiveDate: $effectiveDate, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$VisionProfileDtoCopyWith<$Res> implements $VisionProfileDtoCopyWith<$Res> {
  factory _$VisionProfileDtoCopyWith(_VisionProfileDto value, $Res Function(_VisionProfileDto) _then) = __$VisionProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int speciesId, String speciesName, int version, List<List<double>> colorMatrix, double brightness, double contrast, double saturation, String description, String funFact, DateTime effectiveDate, bool isActive
});




}
/// @nodoc
class __$VisionProfileDtoCopyWithImpl<$Res>
    implements _$VisionProfileDtoCopyWith<$Res> {
  __$VisionProfileDtoCopyWithImpl(this._self, this._then);

  final _VisionProfileDto _self;
  final $Res Function(_VisionProfileDto) _then;

/// Create a copy of VisionProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? speciesId = null,Object? speciesName = null,Object? version = null,Object? colorMatrix = null,Object? brightness = null,Object? contrast = null,Object? saturation = null,Object? description = null,Object? funFact = null,Object? effectiveDate = null,Object? isActive = null,}) {
  return _then(_VisionProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int,speciesName: null == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,colorMatrix: null == colorMatrix ? _self._colorMatrix : colorMatrix // ignore: cast_nullable_to_non_nullable
as List<List<double>>,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as double,contrast: null == contrast ? _self.contrast : contrast // ignore: cast_nullable_to_non_nullable
as double,saturation: null == saturation ? _self.saturation : saturation // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,funFact: null == funFact ? _self.funFact : funFact // ignore: cast_nullable_to_non_nullable
as String,effectiveDate: null == effectiveDate ? _self.effectiveDate : effectiveDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
