// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetDto {

 int get id; String get name; String get gender; DateTime? get dateOfBirth; int? get breedId; String? get breedName; String? get speciesName; String? get pelage; String? get microchipNumber; String? get microchipLocation; String? get sterilizationStatus; DateTime? get sterilizationDate; DateTime? get createdAt;
/// Create a copy of PetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetDtoCopyWith<PetDto> get copyWith => _$PetDtoCopyWithImpl<PetDto>(this as PetDto, _$identity);

  /// Serializes this PetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.breedId, breedId) || other.breedId == breedId)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.pelage, pelage) || other.pelage == pelage)&&(identical(other.microchipNumber, microchipNumber) || other.microchipNumber == microchipNumber)&&(identical(other.microchipLocation, microchipLocation) || other.microchipLocation == microchipLocation)&&(identical(other.sterilizationStatus, sterilizationStatus) || other.sterilizationStatus == sterilizationStatus)&&(identical(other.sterilizationDate, sterilizationDate) || other.sterilizationDate == sterilizationDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,gender,dateOfBirth,breedId,breedName,speciesName,pelage,microchipNumber,microchipLocation,sterilizationStatus,sterilizationDate,createdAt);

@override
String toString() {
  return 'PetDto(id: $id, name: $name, gender: $gender, dateOfBirth: $dateOfBirth, breedId: $breedId, breedName: $breedName, speciesName: $speciesName, pelage: $pelage, microchipNumber: $microchipNumber, microchipLocation: $microchipLocation, sterilizationStatus: $sterilizationStatus, sterilizationDate: $sterilizationDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PetDtoCopyWith<$Res>  {
  factory $PetDtoCopyWith(PetDto value, $Res Function(PetDto) _then) = _$PetDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String gender, DateTime? dateOfBirth, int? breedId, String? breedName, String? speciesName, String? pelage, String? microchipNumber, String? microchipLocation, String? sterilizationStatus, DateTime? sterilizationDate, DateTime? createdAt
});




}
/// @nodoc
class _$PetDtoCopyWithImpl<$Res>
    implements $PetDtoCopyWith<$Res> {
  _$PetDtoCopyWithImpl(this._self, this._then);

  final PetDto _self;
  final $Res Function(PetDto) _then;

/// Create a copy of PetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? gender = null,Object? dateOfBirth = freezed,Object? breedId = freezed,Object? breedName = freezed,Object? speciesName = freezed,Object? pelage = freezed,Object? microchipNumber = freezed,Object? microchipLocation = freezed,Object? sterilizationStatus = freezed,Object? sterilizationDate = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,breedId: freezed == breedId ? _self.breedId : breedId // ignore: cast_nullable_to_non_nullable
as int?,breedName: freezed == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String?,speciesName: freezed == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String?,pelage: freezed == pelage ? _self.pelage : pelage // ignore: cast_nullable_to_non_nullable
as String?,microchipNumber: freezed == microchipNumber ? _self.microchipNumber : microchipNumber // ignore: cast_nullable_to_non_nullable
as String?,microchipLocation: freezed == microchipLocation ? _self.microchipLocation : microchipLocation // ignore: cast_nullable_to_non_nullable
as String?,sterilizationStatus: freezed == sterilizationStatus ? _self.sterilizationStatus : sterilizationStatus // ignore: cast_nullable_to_non_nullable
as String?,sterilizationDate: freezed == sterilizationDate ? _self.sterilizationDate : sterilizationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PetDto].
extension PetDtoPatterns on PetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PetDto value)  $default,){
final _that = this;
switch (_that) {
case _PetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PetDto value)?  $default,){
final _that = this;
switch (_that) {
case _PetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String gender,  DateTime? dateOfBirth,  int? breedId,  String? breedName,  String? speciesName,  String? pelage,  String? microchipNumber,  String? microchipLocation,  String? sterilizationStatus,  DateTime? sterilizationDate,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PetDto() when $default != null:
return $default(_that.id,_that.name,_that.gender,_that.dateOfBirth,_that.breedId,_that.breedName,_that.speciesName,_that.pelage,_that.microchipNumber,_that.microchipLocation,_that.sterilizationStatus,_that.sterilizationDate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String gender,  DateTime? dateOfBirth,  int? breedId,  String? breedName,  String? speciesName,  String? pelage,  String? microchipNumber,  String? microchipLocation,  String? sterilizationStatus,  DateTime? sterilizationDate,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _PetDto():
return $default(_that.id,_that.name,_that.gender,_that.dateOfBirth,_that.breedId,_that.breedName,_that.speciesName,_that.pelage,_that.microchipNumber,_that.microchipLocation,_that.sterilizationStatus,_that.sterilizationDate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String gender,  DateTime? dateOfBirth,  int? breedId,  String? breedName,  String? speciesName,  String? pelage,  String? microchipNumber,  String? microchipLocation,  String? sterilizationStatus,  DateTime? sterilizationDate,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PetDto() when $default != null:
return $default(_that.id,_that.name,_that.gender,_that.dateOfBirth,_that.breedId,_that.breedName,_that.speciesName,_that.pelage,_that.microchipNumber,_that.microchipLocation,_that.sterilizationStatus,_that.sterilizationDate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PetDto extends PetDto {
  const _PetDto({required this.id, required this.name, this.gender = '', this.dateOfBirth, this.breedId, this.breedName, this.speciesName, this.pelage, this.microchipNumber, this.microchipLocation, this.sterilizationStatus, this.sterilizationDate, this.createdAt}): super._();
  factory _PetDto.fromJson(Map<String, dynamic> json) => _$PetDtoFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey() final  String gender;
@override final  DateTime? dateOfBirth;
@override final  int? breedId;
@override final  String? breedName;
@override final  String? speciesName;
@override final  String? pelage;
@override final  String? microchipNumber;
@override final  String? microchipLocation;
@override final  String? sterilizationStatus;
@override final  DateTime? sterilizationDate;
@override final  DateTime? createdAt;

/// Create a copy of PetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetDtoCopyWith<_PetDto> get copyWith => __$PetDtoCopyWithImpl<_PetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.breedId, breedId) || other.breedId == breedId)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.pelage, pelage) || other.pelage == pelage)&&(identical(other.microchipNumber, microchipNumber) || other.microchipNumber == microchipNumber)&&(identical(other.microchipLocation, microchipLocation) || other.microchipLocation == microchipLocation)&&(identical(other.sterilizationStatus, sterilizationStatus) || other.sterilizationStatus == sterilizationStatus)&&(identical(other.sterilizationDate, sterilizationDate) || other.sterilizationDate == sterilizationDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,gender,dateOfBirth,breedId,breedName,speciesName,pelage,microchipNumber,microchipLocation,sterilizationStatus,sterilizationDate,createdAt);

@override
String toString() {
  return 'PetDto(id: $id, name: $name, gender: $gender, dateOfBirth: $dateOfBirth, breedId: $breedId, breedName: $breedName, speciesName: $speciesName, pelage: $pelage, microchipNumber: $microchipNumber, microchipLocation: $microchipLocation, sterilizationStatus: $sterilizationStatus, sterilizationDate: $sterilizationDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PetDtoCopyWith<$Res> implements $PetDtoCopyWith<$Res> {
  factory _$PetDtoCopyWith(_PetDto value, $Res Function(_PetDto) _then) = __$PetDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String gender, DateTime? dateOfBirth, int? breedId, String? breedName, String? speciesName, String? pelage, String? microchipNumber, String? microchipLocation, String? sterilizationStatus, DateTime? sterilizationDate, DateTime? createdAt
});




}
/// @nodoc
class __$PetDtoCopyWithImpl<$Res>
    implements _$PetDtoCopyWith<$Res> {
  __$PetDtoCopyWithImpl(this._self, this._then);

  final _PetDto _self;
  final $Res Function(_PetDto) _then;

/// Create a copy of PetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? gender = null,Object? dateOfBirth = freezed,Object? breedId = freezed,Object? breedName = freezed,Object? speciesName = freezed,Object? pelage = freezed,Object? microchipNumber = freezed,Object? microchipLocation = freezed,Object? sterilizationStatus = freezed,Object? sterilizationDate = freezed,Object? createdAt = freezed,}) {
  return _then(_PetDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,breedId: freezed == breedId ? _self.breedId : breedId // ignore: cast_nullable_to_non_nullable
as int?,breedName: freezed == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String?,speciesName: freezed == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String?,pelage: freezed == pelage ? _self.pelage : pelage // ignore: cast_nullable_to_non_nullable
as String?,microchipNumber: freezed == microchipNumber ? _self.microchipNumber : microchipNumber // ignore: cast_nullable_to_non_nullable
as String?,microchipLocation: freezed == microchipLocation ? _self.microchipLocation : microchipLocation // ignore: cast_nullable_to_non_nullable
as String?,sterilizationStatus: freezed == sterilizationStatus ? _self.sterilizationStatus : sterilizationStatus // ignore: cast_nullable_to_non_nullable
as String?,sterilizationDate: freezed == sterilizationDate ? _self.sterilizationDate : sterilizationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
