// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adoption_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdoptionPetDto {

// Null for a shelter/stray listing (no pet exists yet).
 int? get id; String get name; int? get speciesId; String? get speciesName; String? get breedName; String? get gender; DateTime? get dateOfBirth; String? get avatarUrl;
/// Create a copy of AdoptionPetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdoptionPetDtoCopyWith<AdoptionPetDto> get copyWith => _$AdoptionPetDtoCopyWithImpl<AdoptionPetDto>(this as AdoptionPetDto, _$identity);

  /// Serializes this AdoptionPetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdoptionPetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,speciesId,speciesName,breedName,gender,dateOfBirth,avatarUrl);

@override
String toString() {
  return 'AdoptionPetDto(id: $id, name: $name, speciesId: $speciesId, speciesName: $speciesName, breedName: $breedName, gender: $gender, dateOfBirth: $dateOfBirth, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $AdoptionPetDtoCopyWith<$Res>  {
  factory $AdoptionPetDtoCopyWith(AdoptionPetDto value, $Res Function(AdoptionPetDto) _then) = _$AdoptionPetDtoCopyWithImpl;
@useResult
$Res call({
 int? id, String name, int? speciesId, String? speciesName, String? breedName, String? gender, DateTime? dateOfBirth, String? avatarUrl
});




}
/// @nodoc
class _$AdoptionPetDtoCopyWithImpl<$Res>
    implements $AdoptionPetDtoCopyWith<$Res> {
  _$AdoptionPetDtoCopyWithImpl(this._self, this._then);

  final AdoptionPetDto _self;
  final $Res Function(AdoptionPetDto) _then;

/// Create a copy of AdoptionPetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? speciesId = freezed,Object? speciesName = freezed,Object? breedName = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int?,speciesName: freezed == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String?,breedName: freezed == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdoptionPetDto].
extension AdoptionPetDtoPatterns on AdoptionPetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdoptionPetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdoptionPetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdoptionPetDto value)  $default,){
final _that = this;
switch (_that) {
case _AdoptionPetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdoptionPetDto value)?  $default,){
final _that = this;
switch (_that) {
case _AdoptionPetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  int? speciesId,  String? speciesName,  String? breedName,  String? gender,  DateTime? dateOfBirth,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdoptionPetDto() when $default != null:
return $default(_that.id,_that.name,_that.speciesId,_that.speciesName,_that.breedName,_that.gender,_that.dateOfBirth,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  int? speciesId,  String? speciesName,  String? breedName,  String? gender,  DateTime? dateOfBirth,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _AdoptionPetDto():
return $default(_that.id,_that.name,_that.speciesId,_that.speciesName,_that.breedName,_that.gender,_that.dateOfBirth,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  int? speciesId,  String? speciesName,  String? breedName,  String? gender,  DateTime? dateOfBirth,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _AdoptionPetDto() when $default != null:
return $default(_that.id,_that.name,_that.speciesId,_that.speciesName,_that.breedName,_that.gender,_that.dateOfBirth,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdoptionPetDto extends AdoptionPetDto {
  const _AdoptionPetDto({this.id, this.name = '', this.speciesId, this.speciesName, this.breedName, this.gender, this.dateOfBirth, this.avatarUrl}): super._();
  factory _AdoptionPetDto.fromJson(Map<String, dynamic> json) => _$AdoptionPetDtoFromJson(json);

// Null for a shelter/stray listing (no pet exists yet).
@override final  int? id;
@override@JsonKey() final  String name;
@override final  int? speciesId;
@override final  String? speciesName;
@override final  String? breedName;
@override final  String? gender;
@override final  DateTime? dateOfBirth;
@override final  String? avatarUrl;

/// Create a copy of AdoptionPetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdoptionPetDtoCopyWith<_AdoptionPetDto> get copyWith => __$AdoptionPetDtoCopyWithImpl<_AdoptionPetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdoptionPetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdoptionPetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,speciesId,speciesName,breedName,gender,dateOfBirth,avatarUrl);

@override
String toString() {
  return 'AdoptionPetDto(id: $id, name: $name, speciesId: $speciesId, speciesName: $speciesName, breedName: $breedName, gender: $gender, dateOfBirth: $dateOfBirth, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$AdoptionPetDtoCopyWith<$Res> implements $AdoptionPetDtoCopyWith<$Res> {
  factory _$AdoptionPetDtoCopyWith(_AdoptionPetDto value, $Res Function(_AdoptionPetDto) _then) = __$AdoptionPetDtoCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, int? speciesId, String? speciesName, String? breedName, String? gender, DateTime? dateOfBirth, String? avatarUrl
});




}
/// @nodoc
class __$AdoptionPetDtoCopyWithImpl<$Res>
    implements _$AdoptionPetDtoCopyWith<$Res> {
  __$AdoptionPetDtoCopyWithImpl(this._self, this._then);

  final _AdoptionPetDto _self;
  final $Res Function(_AdoptionPetDto) _then;

/// Create a copy of AdoptionPetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? speciesId = freezed,Object? speciesName = freezed,Object? breedName = freezed,Object? gender = freezed,Object? dateOfBirth = freezed,Object? avatarUrl = freezed,}) {
  return _then(_AdoptionPetDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,speciesId: freezed == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as int?,speciesName: freezed == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String?,breedName: freezed == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AdoptionUserDto {

 String get id; String get firstName; String get lastName; String? get avatarUrl;
/// Create a copy of AdoptionUserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdoptionUserDtoCopyWith<AdoptionUserDto> get copyWith => _$AdoptionUserDtoCopyWithImpl<AdoptionUserDto>(this as AdoptionUserDto, _$identity);

  /// Serializes this AdoptionUserDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdoptionUserDto&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,avatarUrl);

@override
String toString() {
  return 'AdoptionUserDto(id: $id, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $AdoptionUserDtoCopyWith<$Res>  {
  factory $AdoptionUserDtoCopyWith(AdoptionUserDto value, $Res Function(AdoptionUserDto) _then) = _$AdoptionUserDtoCopyWithImpl;
@useResult
$Res call({
 String id, String firstName, String lastName, String? avatarUrl
});




}
/// @nodoc
class _$AdoptionUserDtoCopyWithImpl<$Res>
    implements $AdoptionUserDtoCopyWith<$Res> {
  _$AdoptionUserDtoCopyWithImpl(this._self, this._then);

  final AdoptionUserDto _self;
  final $Res Function(AdoptionUserDto) _then;

/// Create a copy of AdoptionUserDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdoptionUserDto].
extension AdoptionUserDtoPatterns on AdoptionUserDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdoptionUserDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdoptionUserDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdoptionUserDto value)  $default,){
final _that = this;
switch (_that) {
case _AdoptionUserDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdoptionUserDto value)?  $default,){
final _that = this;
switch (_that) {
case _AdoptionUserDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdoptionUserDto() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _AdoptionUserDto():
return $default(_that.id,_that.firstName,_that.lastName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstName,  String lastName,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _AdoptionUserDto() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdoptionUserDto extends AdoptionUserDto {
  const _AdoptionUserDto({required this.id, this.firstName = '', this.lastName = '', this.avatarUrl}): super._();
  factory _AdoptionUserDto.fromJson(Map<String, dynamic> json) => _$AdoptionUserDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override final  String? avatarUrl;

/// Create a copy of AdoptionUserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdoptionUserDtoCopyWith<_AdoptionUserDto> get copyWith => __$AdoptionUserDtoCopyWithImpl<_AdoptionUserDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdoptionUserDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdoptionUserDto&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,avatarUrl);

@override
String toString() {
  return 'AdoptionUserDto(id: $id, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$AdoptionUserDtoCopyWith<$Res> implements $AdoptionUserDtoCopyWith<$Res> {
  factory _$AdoptionUserDtoCopyWith(_AdoptionUserDto value, $Res Function(_AdoptionUserDto) _then) = __$AdoptionUserDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String firstName, String lastName, String? avatarUrl
});




}
/// @nodoc
class __$AdoptionUserDtoCopyWithImpl<$Res>
    implements _$AdoptionUserDtoCopyWith<$Res> {
  __$AdoptionUserDtoCopyWithImpl(this._self, this._then);

  final _AdoptionUserDto _self;
  final $Res Function(_AdoptionUserDto) _then;

/// Create a copy of AdoptionUserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,}) {
  return _then(_AdoptionUserDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AdoptionListingDto {

 int get id; int? get statusId; AdoptionPetDto get pet; AdoptionUserDto get lister; String? get description; String? get locationLabel; double? get latitude; double? get longitude; bool get vaccinated; bool get neutered; bool get goodWithKids; int get applicantCount; bool get isOwnListing; bool get hasApplied; bool get isShelter; DateTime? get createdAt;
/// Create a copy of AdoptionListingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdoptionListingDtoCopyWith<AdoptionListingDto> get copyWith => _$AdoptionListingDtoCopyWithImpl<AdoptionListingDto>(this as AdoptionListingDto, _$identity);

  /// Serializes this AdoptionListingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdoptionListingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.lister, lister) || other.lister == lister)&&(identical(other.description, description) || other.description == description)&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.vaccinated, vaccinated) || other.vaccinated == vaccinated)&&(identical(other.neutered, neutered) || other.neutered == neutered)&&(identical(other.goodWithKids, goodWithKids) || other.goodWithKids == goodWithKids)&&(identical(other.applicantCount, applicantCount) || other.applicantCount == applicantCount)&&(identical(other.isOwnListing, isOwnListing) || other.isOwnListing == isOwnListing)&&(identical(other.hasApplied, hasApplied) || other.hasApplied == hasApplied)&&(identical(other.isShelter, isShelter) || other.isShelter == isShelter)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,statusId,pet,lister,description,locationLabel,latitude,longitude,vaccinated,neutered,goodWithKids,applicantCount,isOwnListing,hasApplied,isShelter,createdAt);

@override
String toString() {
  return 'AdoptionListingDto(id: $id, statusId: $statusId, pet: $pet, lister: $lister, description: $description, locationLabel: $locationLabel, latitude: $latitude, longitude: $longitude, vaccinated: $vaccinated, neutered: $neutered, goodWithKids: $goodWithKids, applicantCount: $applicantCount, isOwnListing: $isOwnListing, hasApplied: $hasApplied, isShelter: $isShelter, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AdoptionListingDtoCopyWith<$Res>  {
  factory $AdoptionListingDtoCopyWith(AdoptionListingDto value, $Res Function(AdoptionListingDto) _then) = _$AdoptionListingDtoCopyWithImpl;
@useResult
$Res call({
 int id, int? statusId, AdoptionPetDto pet, AdoptionUserDto lister, String? description, String? locationLabel, double? latitude, double? longitude, bool vaccinated, bool neutered, bool goodWithKids, int applicantCount, bool isOwnListing, bool hasApplied, bool isShelter, DateTime? createdAt
});


$AdoptionPetDtoCopyWith<$Res> get pet;$AdoptionUserDtoCopyWith<$Res> get lister;

}
/// @nodoc
class _$AdoptionListingDtoCopyWithImpl<$Res>
    implements $AdoptionListingDtoCopyWith<$Res> {
  _$AdoptionListingDtoCopyWithImpl(this._self, this._then);

  final AdoptionListingDto _self;
  final $Res Function(AdoptionListingDto) _then;

/// Create a copy of AdoptionListingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? statusId = freezed,Object? pet = null,Object? lister = null,Object? description = freezed,Object? locationLabel = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? vaccinated = null,Object? neutered = null,Object? goodWithKids = null,Object? applicantCount = null,Object? isOwnListing = null,Object? hasApplied = null,Object? isShelter = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int?,pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as AdoptionPetDto,lister: null == lister ? _self.lister : lister // ignore: cast_nullable_to_non_nullable
as AdoptionUserDto,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,locationLabel: freezed == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,vaccinated: null == vaccinated ? _self.vaccinated : vaccinated // ignore: cast_nullable_to_non_nullable
as bool,neutered: null == neutered ? _self.neutered : neutered // ignore: cast_nullable_to_non_nullable
as bool,goodWithKids: null == goodWithKids ? _self.goodWithKids : goodWithKids // ignore: cast_nullable_to_non_nullable
as bool,applicantCount: null == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int,isOwnListing: null == isOwnListing ? _self.isOwnListing : isOwnListing // ignore: cast_nullable_to_non_nullable
as bool,hasApplied: null == hasApplied ? _self.hasApplied : hasApplied // ignore: cast_nullable_to_non_nullable
as bool,isShelter: null == isShelter ? _self.isShelter : isShelter // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of AdoptionListingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionPetDtoCopyWith<$Res> get pet {
  
  return $AdoptionPetDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of AdoptionListingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionUserDtoCopyWith<$Res> get lister {
  
  return $AdoptionUserDtoCopyWith<$Res>(_self.lister, (value) {
    return _then(_self.copyWith(lister: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdoptionListingDto].
extension AdoptionListingDtoPatterns on AdoptionListingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdoptionListingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdoptionListingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdoptionListingDto value)  $default,){
final _that = this;
switch (_that) {
case _AdoptionListingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdoptionListingDto value)?  $default,){
final _that = this;
switch (_that) {
case _AdoptionListingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? statusId,  AdoptionPetDto pet,  AdoptionUserDto lister,  String? description,  String? locationLabel,  double? latitude,  double? longitude,  bool vaccinated,  bool neutered,  bool goodWithKids,  int applicantCount,  bool isOwnListing,  bool hasApplied,  bool isShelter,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdoptionListingDto() when $default != null:
return $default(_that.id,_that.statusId,_that.pet,_that.lister,_that.description,_that.locationLabel,_that.latitude,_that.longitude,_that.vaccinated,_that.neutered,_that.goodWithKids,_that.applicantCount,_that.isOwnListing,_that.hasApplied,_that.isShelter,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? statusId,  AdoptionPetDto pet,  AdoptionUserDto lister,  String? description,  String? locationLabel,  double? latitude,  double? longitude,  bool vaccinated,  bool neutered,  bool goodWithKids,  int applicantCount,  bool isOwnListing,  bool hasApplied,  bool isShelter,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AdoptionListingDto():
return $default(_that.id,_that.statusId,_that.pet,_that.lister,_that.description,_that.locationLabel,_that.latitude,_that.longitude,_that.vaccinated,_that.neutered,_that.goodWithKids,_that.applicantCount,_that.isOwnListing,_that.hasApplied,_that.isShelter,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? statusId,  AdoptionPetDto pet,  AdoptionUserDto lister,  String? description,  String? locationLabel,  double? latitude,  double? longitude,  bool vaccinated,  bool neutered,  bool goodWithKids,  int applicantCount,  bool isOwnListing,  bool hasApplied,  bool isShelter,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AdoptionListingDto() when $default != null:
return $default(_that.id,_that.statusId,_that.pet,_that.lister,_that.description,_that.locationLabel,_that.latitude,_that.longitude,_that.vaccinated,_that.neutered,_that.goodWithKids,_that.applicantCount,_that.isOwnListing,_that.hasApplied,_that.isShelter,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdoptionListingDto extends AdoptionListingDto {
  const _AdoptionListingDto({required this.id, this.statusId, required this.pet, required this.lister, this.description, this.locationLabel, this.latitude, this.longitude, this.vaccinated = false, this.neutered = false, this.goodWithKids = false, this.applicantCount = 0, this.isOwnListing = false, this.hasApplied = false, this.isShelter = false, this.createdAt}): super._();
  factory _AdoptionListingDto.fromJson(Map<String, dynamic> json) => _$AdoptionListingDtoFromJson(json);

@override final  int id;
@override final  int? statusId;
@override final  AdoptionPetDto pet;
@override final  AdoptionUserDto lister;
@override final  String? description;
@override final  String? locationLabel;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey() final  bool vaccinated;
@override@JsonKey() final  bool neutered;
@override@JsonKey() final  bool goodWithKids;
@override@JsonKey() final  int applicantCount;
@override@JsonKey() final  bool isOwnListing;
@override@JsonKey() final  bool hasApplied;
@override@JsonKey() final  bool isShelter;
@override final  DateTime? createdAt;

/// Create a copy of AdoptionListingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdoptionListingDtoCopyWith<_AdoptionListingDto> get copyWith => __$AdoptionListingDtoCopyWithImpl<_AdoptionListingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdoptionListingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdoptionListingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.lister, lister) || other.lister == lister)&&(identical(other.description, description) || other.description == description)&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.vaccinated, vaccinated) || other.vaccinated == vaccinated)&&(identical(other.neutered, neutered) || other.neutered == neutered)&&(identical(other.goodWithKids, goodWithKids) || other.goodWithKids == goodWithKids)&&(identical(other.applicantCount, applicantCount) || other.applicantCount == applicantCount)&&(identical(other.isOwnListing, isOwnListing) || other.isOwnListing == isOwnListing)&&(identical(other.hasApplied, hasApplied) || other.hasApplied == hasApplied)&&(identical(other.isShelter, isShelter) || other.isShelter == isShelter)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,statusId,pet,lister,description,locationLabel,latitude,longitude,vaccinated,neutered,goodWithKids,applicantCount,isOwnListing,hasApplied,isShelter,createdAt);

@override
String toString() {
  return 'AdoptionListingDto(id: $id, statusId: $statusId, pet: $pet, lister: $lister, description: $description, locationLabel: $locationLabel, latitude: $latitude, longitude: $longitude, vaccinated: $vaccinated, neutered: $neutered, goodWithKids: $goodWithKids, applicantCount: $applicantCount, isOwnListing: $isOwnListing, hasApplied: $hasApplied, isShelter: $isShelter, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AdoptionListingDtoCopyWith<$Res> implements $AdoptionListingDtoCopyWith<$Res> {
  factory _$AdoptionListingDtoCopyWith(_AdoptionListingDto value, $Res Function(_AdoptionListingDto) _then) = __$AdoptionListingDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int? statusId, AdoptionPetDto pet, AdoptionUserDto lister, String? description, String? locationLabel, double? latitude, double? longitude, bool vaccinated, bool neutered, bool goodWithKids, int applicantCount, bool isOwnListing, bool hasApplied, bool isShelter, DateTime? createdAt
});


@override $AdoptionPetDtoCopyWith<$Res> get pet;@override $AdoptionUserDtoCopyWith<$Res> get lister;

}
/// @nodoc
class __$AdoptionListingDtoCopyWithImpl<$Res>
    implements _$AdoptionListingDtoCopyWith<$Res> {
  __$AdoptionListingDtoCopyWithImpl(this._self, this._then);

  final _AdoptionListingDto _self;
  final $Res Function(_AdoptionListingDto) _then;

/// Create a copy of AdoptionListingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? statusId = freezed,Object? pet = null,Object? lister = null,Object? description = freezed,Object? locationLabel = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? vaccinated = null,Object? neutered = null,Object? goodWithKids = null,Object? applicantCount = null,Object? isOwnListing = null,Object? hasApplied = null,Object? isShelter = null,Object? createdAt = freezed,}) {
  return _then(_AdoptionListingDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int?,pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as AdoptionPetDto,lister: null == lister ? _self.lister : lister // ignore: cast_nullable_to_non_nullable
as AdoptionUserDto,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,locationLabel: freezed == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,vaccinated: null == vaccinated ? _self.vaccinated : vaccinated // ignore: cast_nullable_to_non_nullable
as bool,neutered: null == neutered ? _self.neutered : neutered // ignore: cast_nullable_to_non_nullable
as bool,goodWithKids: null == goodWithKids ? _self.goodWithKids : goodWithKids // ignore: cast_nullable_to_non_nullable
as bool,applicantCount: null == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int,isOwnListing: null == isOwnListing ? _self.isOwnListing : isOwnListing // ignore: cast_nullable_to_non_nullable
as bool,hasApplied: null == hasApplied ? _self.hasApplied : hasApplied // ignore: cast_nullable_to_non_nullable
as bool,isShelter: null == isShelter ? _self.isShelter : isShelter // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of AdoptionListingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionPetDtoCopyWith<$Res> get pet {
  
  return $AdoptionPetDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of AdoptionListingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionUserDtoCopyWith<$Res> get lister {
  
  return $AdoptionUserDtoCopyWith<$Res>(_self.lister, (value) {
    return _then(_self.copyWith(lister: value));
  });
}
}


/// @nodoc
mixin _$AdoptionListingPageDto {

 List<AdoptionListingDto> get items; int get page; int get pageSize; int get totalCount; int get totalPages;
/// Create a copy of AdoptionListingPageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdoptionListingPageDtoCopyWith<AdoptionListingPageDto> get copyWith => _$AdoptionListingPageDtoCopyWithImpl<AdoptionListingPageDto>(this as AdoptionListingPageDto, _$identity);

  /// Serializes this AdoptionListingPageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdoptionListingPageDto&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),page,pageSize,totalCount,totalPages);

@override
String toString() {
  return 'AdoptionListingPageDto(items: $items, page: $page, pageSize: $pageSize, totalCount: $totalCount, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $AdoptionListingPageDtoCopyWith<$Res>  {
  factory $AdoptionListingPageDtoCopyWith(AdoptionListingPageDto value, $Res Function(AdoptionListingPageDto) _then) = _$AdoptionListingPageDtoCopyWithImpl;
@useResult
$Res call({
 List<AdoptionListingDto> items, int page, int pageSize, int totalCount, int totalPages
});




}
/// @nodoc
class _$AdoptionListingPageDtoCopyWithImpl<$Res>
    implements $AdoptionListingPageDtoCopyWith<$Res> {
  _$AdoptionListingPageDtoCopyWithImpl(this._self, this._then);

  final AdoptionListingPageDto _self;
  final $Res Function(AdoptionListingPageDto) _then;

/// Create a copy of AdoptionListingPageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? totalCount = null,Object? totalPages = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AdoptionListingDto>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AdoptionListingPageDto].
extension AdoptionListingPageDtoPatterns on AdoptionListingPageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdoptionListingPageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdoptionListingPageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdoptionListingPageDto value)  $default,){
final _that = this;
switch (_that) {
case _AdoptionListingPageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdoptionListingPageDto value)?  $default,){
final _that = this;
switch (_that) {
case _AdoptionListingPageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AdoptionListingDto> items,  int page,  int pageSize,  int totalCount,  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdoptionListingPageDto() when $default != null:
return $default(_that.items,_that.page,_that.pageSize,_that.totalCount,_that.totalPages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AdoptionListingDto> items,  int page,  int pageSize,  int totalCount,  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _AdoptionListingPageDto():
return $default(_that.items,_that.page,_that.pageSize,_that.totalCount,_that.totalPages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AdoptionListingDto> items,  int page,  int pageSize,  int totalCount,  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _AdoptionListingPageDto() when $default != null:
return $default(_that.items,_that.page,_that.pageSize,_that.totalCount,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdoptionListingPageDto extends AdoptionListingPageDto {
  const _AdoptionListingPageDto({final  List<AdoptionListingDto> items = const <AdoptionListingDto>[], this.page = 1, this.pageSize = 20, this.totalCount = 0, this.totalPages = 1}): _items = items,super._();
  factory _AdoptionListingPageDto.fromJson(Map<String, dynamic> json) => _$AdoptionListingPageDtoFromJson(json);

 final  List<AdoptionListingDto> _items;
@override@JsonKey() List<AdoptionListingDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int totalPages;

/// Create a copy of AdoptionListingPageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdoptionListingPageDtoCopyWith<_AdoptionListingPageDto> get copyWith => __$AdoptionListingPageDtoCopyWithImpl<_AdoptionListingPageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdoptionListingPageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdoptionListingPageDto&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,pageSize,totalCount,totalPages);

@override
String toString() {
  return 'AdoptionListingPageDto(items: $items, page: $page, pageSize: $pageSize, totalCount: $totalCount, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$AdoptionListingPageDtoCopyWith<$Res> implements $AdoptionListingPageDtoCopyWith<$Res> {
  factory _$AdoptionListingPageDtoCopyWith(_AdoptionListingPageDto value, $Res Function(_AdoptionListingPageDto) _then) = __$AdoptionListingPageDtoCopyWithImpl;
@override @useResult
$Res call({
 List<AdoptionListingDto> items, int page, int pageSize, int totalCount, int totalPages
});




}
/// @nodoc
class __$AdoptionListingPageDtoCopyWithImpl<$Res>
    implements _$AdoptionListingPageDtoCopyWith<$Res> {
  __$AdoptionListingPageDtoCopyWithImpl(this._self, this._then);

  final _AdoptionListingPageDto _self;
  final $Res Function(_AdoptionListingPageDto) _then;

/// Create a copy of AdoptionListingPageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? totalCount = null,Object? totalPages = null,}) {
  return _then(_AdoptionListingPageDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AdoptionListingDto>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AdoptionRequestDto {

 int get id; int? get statusId; AdoptionUserDto get requester; DateTime? get requestedAt; bool get isShelter; DateTime? get listerConfirmedAt; DateTime? get adopterConfirmedAt;
/// Create a copy of AdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdoptionRequestDtoCopyWith<AdoptionRequestDto> get copyWith => _$AdoptionRequestDtoCopyWithImpl<AdoptionRequestDto>(this as AdoptionRequestDto, _$identity);

  /// Serializes this AdoptionRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdoptionRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.isShelter, isShelter) || other.isShelter == isShelter)&&(identical(other.listerConfirmedAt, listerConfirmedAt) || other.listerConfirmedAt == listerConfirmedAt)&&(identical(other.adopterConfirmedAt, adopterConfirmedAt) || other.adopterConfirmedAt == adopterConfirmedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,statusId,requester,requestedAt,isShelter,listerConfirmedAt,adopterConfirmedAt);

@override
String toString() {
  return 'AdoptionRequestDto(id: $id, statusId: $statusId, requester: $requester, requestedAt: $requestedAt, isShelter: $isShelter, listerConfirmedAt: $listerConfirmedAt, adopterConfirmedAt: $adopterConfirmedAt)';
}


}

/// @nodoc
abstract mixin class $AdoptionRequestDtoCopyWith<$Res>  {
  factory $AdoptionRequestDtoCopyWith(AdoptionRequestDto value, $Res Function(AdoptionRequestDto) _then) = _$AdoptionRequestDtoCopyWithImpl;
@useResult
$Res call({
 int id, int? statusId, AdoptionUserDto requester, DateTime? requestedAt, bool isShelter, DateTime? listerConfirmedAt, DateTime? adopterConfirmedAt
});


$AdoptionUserDtoCopyWith<$Res> get requester;

}
/// @nodoc
class _$AdoptionRequestDtoCopyWithImpl<$Res>
    implements $AdoptionRequestDtoCopyWith<$Res> {
  _$AdoptionRequestDtoCopyWithImpl(this._self, this._then);

  final AdoptionRequestDto _self;
  final $Res Function(AdoptionRequestDto) _then;

/// Create a copy of AdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? statusId = freezed,Object? requester = null,Object? requestedAt = freezed,Object? isShelter = null,Object? listerConfirmedAt = freezed,Object? adopterConfirmedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int?,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as AdoptionUserDto,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isShelter: null == isShelter ? _self.isShelter : isShelter // ignore: cast_nullable_to_non_nullable
as bool,listerConfirmedAt: freezed == listerConfirmedAt ? _self.listerConfirmedAt : listerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adopterConfirmedAt: freezed == adopterConfirmedAt ? _self.adopterConfirmedAt : adopterConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of AdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionUserDtoCopyWith<$Res> get requester {
  
  return $AdoptionUserDtoCopyWith<$Res>(_self.requester, (value) {
    return _then(_self.copyWith(requester: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdoptionRequestDto].
extension AdoptionRequestDtoPatterns on AdoptionRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdoptionRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdoptionRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdoptionRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _AdoptionRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdoptionRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _AdoptionRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? statusId,  AdoptionUserDto requester,  DateTime? requestedAt,  bool isShelter,  DateTime? listerConfirmedAt,  DateTime? adopterConfirmedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdoptionRequestDto() when $default != null:
return $default(_that.id,_that.statusId,_that.requester,_that.requestedAt,_that.isShelter,_that.listerConfirmedAt,_that.adopterConfirmedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? statusId,  AdoptionUserDto requester,  DateTime? requestedAt,  bool isShelter,  DateTime? listerConfirmedAt,  DateTime? adopterConfirmedAt)  $default,) {final _that = this;
switch (_that) {
case _AdoptionRequestDto():
return $default(_that.id,_that.statusId,_that.requester,_that.requestedAt,_that.isShelter,_that.listerConfirmedAt,_that.adopterConfirmedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? statusId,  AdoptionUserDto requester,  DateTime? requestedAt,  bool isShelter,  DateTime? listerConfirmedAt,  DateTime? adopterConfirmedAt)?  $default,) {final _that = this;
switch (_that) {
case _AdoptionRequestDto() when $default != null:
return $default(_that.id,_that.statusId,_that.requester,_that.requestedAt,_that.isShelter,_that.listerConfirmedAt,_that.adopterConfirmedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdoptionRequestDto extends AdoptionRequestDto {
  const _AdoptionRequestDto({required this.id, this.statusId, required this.requester, this.requestedAt, this.isShelter = false, this.listerConfirmedAt, this.adopterConfirmedAt}): super._();
  factory _AdoptionRequestDto.fromJson(Map<String, dynamic> json) => _$AdoptionRequestDtoFromJson(json);

@override final  int id;
@override final  int? statusId;
@override final  AdoptionUserDto requester;
@override final  DateTime? requestedAt;
@override@JsonKey() final  bool isShelter;
@override final  DateTime? listerConfirmedAt;
@override final  DateTime? adopterConfirmedAt;

/// Create a copy of AdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdoptionRequestDtoCopyWith<_AdoptionRequestDto> get copyWith => __$AdoptionRequestDtoCopyWithImpl<_AdoptionRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdoptionRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdoptionRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.isShelter, isShelter) || other.isShelter == isShelter)&&(identical(other.listerConfirmedAt, listerConfirmedAt) || other.listerConfirmedAt == listerConfirmedAt)&&(identical(other.adopterConfirmedAt, adopterConfirmedAt) || other.adopterConfirmedAt == adopterConfirmedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,statusId,requester,requestedAt,isShelter,listerConfirmedAt,adopterConfirmedAt);

@override
String toString() {
  return 'AdoptionRequestDto(id: $id, statusId: $statusId, requester: $requester, requestedAt: $requestedAt, isShelter: $isShelter, listerConfirmedAt: $listerConfirmedAt, adopterConfirmedAt: $adopterConfirmedAt)';
}


}

/// @nodoc
abstract mixin class _$AdoptionRequestDtoCopyWith<$Res> implements $AdoptionRequestDtoCopyWith<$Res> {
  factory _$AdoptionRequestDtoCopyWith(_AdoptionRequestDto value, $Res Function(_AdoptionRequestDto) _then) = __$AdoptionRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int? statusId, AdoptionUserDto requester, DateTime? requestedAt, bool isShelter, DateTime? listerConfirmedAt, DateTime? adopterConfirmedAt
});


@override $AdoptionUserDtoCopyWith<$Res> get requester;

}
/// @nodoc
class __$AdoptionRequestDtoCopyWithImpl<$Res>
    implements _$AdoptionRequestDtoCopyWith<$Res> {
  __$AdoptionRequestDtoCopyWithImpl(this._self, this._then);

  final _AdoptionRequestDto _self;
  final $Res Function(_AdoptionRequestDto) _then;

/// Create a copy of AdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? statusId = freezed,Object? requester = null,Object? requestedAt = freezed,Object? isShelter = null,Object? listerConfirmedAt = freezed,Object? adopterConfirmedAt = freezed,}) {
  return _then(_AdoptionRequestDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int?,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as AdoptionUserDto,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isShelter: null == isShelter ? _self.isShelter : isShelter // ignore: cast_nullable_to_non_nullable
as bool,listerConfirmedAt: freezed == listerConfirmedAt ? _self.listerConfirmedAt : listerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adopterConfirmedAt: freezed == adopterConfirmedAt ? _self.adopterConfirmedAt : adopterConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of AdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionUserDtoCopyWith<$Res> get requester {
  
  return $AdoptionUserDtoCopyWith<$Res>(_self.requester, (value) {
    return _then(_self.copyWith(requester: value));
  });
}
}


/// @nodoc
mixin _$MyRequestListingDto {

 int get id; int? get statusId; bool get isShelter;
/// Create a copy of MyRequestListingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyRequestListingDtoCopyWith<MyRequestListingDto> get copyWith => _$MyRequestListingDtoCopyWithImpl<MyRequestListingDto>(this as MyRequestListingDto, _$identity);

  /// Serializes this MyRequestListingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyRequestListingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.isShelter, isShelter) || other.isShelter == isShelter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,statusId,isShelter);

@override
String toString() {
  return 'MyRequestListingDto(id: $id, statusId: $statusId, isShelter: $isShelter)';
}


}

/// @nodoc
abstract mixin class $MyRequestListingDtoCopyWith<$Res>  {
  factory $MyRequestListingDtoCopyWith(MyRequestListingDto value, $Res Function(MyRequestListingDto) _then) = _$MyRequestListingDtoCopyWithImpl;
@useResult
$Res call({
 int id, int? statusId, bool isShelter
});




}
/// @nodoc
class _$MyRequestListingDtoCopyWithImpl<$Res>
    implements $MyRequestListingDtoCopyWith<$Res> {
  _$MyRequestListingDtoCopyWithImpl(this._self, this._then);

  final MyRequestListingDto _self;
  final $Res Function(MyRequestListingDto) _then;

/// Create a copy of MyRequestListingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? statusId = freezed,Object? isShelter = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int?,isShelter: null == isShelter ? _self.isShelter : isShelter // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MyRequestListingDto].
extension MyRequestListingDtoPatterns on MyRequestListingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyRequestListingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyRequestListingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyRequestListingDto value)  $default,){
final _that = this;
switch (_that) {
case _MyRequestListingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyRequestListingDto value)?  $default,){
final _that = this;
switch (_that) {
case _MyRequestListingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? statusId,  bool isShelter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyRequestListingDto() when $default != null:
return $default(_that.id,_that.statusId,_that.isShelter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? statusId,  bool isShelter)  $default,) {final _that = this;
switch (_that) {
case _MyRequestListingDto():
return $default(_that.id,_that.statusId,_that.isShelter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? statusId,  bool isShelter)?  $default,) {final _that = this;
switch (_that) {
case _MyRequestListingDto() when $default != null:
return $default(_that.id,_that.statusId,_that.isShelter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyRequestListingDto extends MyRequestListingDto {
  const _MyRequestListingDto({required this.id, this.statusId, this.isShelter = false}): super._();
  factory _MyRequestListingDto.fromJson(Map<String, dynamic> json) => _$MyRequestListingDtoFromJson(json);

@override final  int id;
@override final  int? statusId;
@override@JsonKey() final  bool isShelter;

/// Create a copy of MyRequestListingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyRequestListingDtoCopyWith<_MyRequestListingDto> get copyWith => __$MyRequestListingDtoCopyWithImpl<_MyRequestListingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyRequestListingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyRequestListingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.isShelter, isShelter) || other.isShelter == isShelter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,statusId,isShelter);

@override
String toString() {
  return 'MyRequestListingDto(id: $id, statusId: $statusId, isShelter: $isShelter)';
}


}

/// @nodoc
abstract mixin class _$MyRequestListingDtoCopyWith<$Res> implements $MyRequestListingDtoCopyWith<$Res> {
  factory _$MyRequestListingDtoCopyWith(_MyRequestListingDto value, $Res Function(_MyRequestListingDto) _then) = __$MyRequestListingDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int? statusId, bool isShelter
});




}
/// @nodoc
class __$MyRequestListingDtoCopyWithImpl<$Res>
    implements _$MyRequestListingDtoCopyWith<$Res> {
  __$MyRequestListingDtoCopyWithImpl(this._self, this._then);

  final _MyRequestListingDto _self;
  final $Res Function(_MyRequestListingDto) _then;

/// Create a copy of MyRequestListingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? statusId = freezed,Object? isShelter = null,}) {
  return _then(_MyRequestListingDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int?,isShelter: null == isShelter ? _self.isShelter : isShelter // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MyAdoptionRequestDto {

 int get id; int? get statusId; MyRequestListingDto get listing; AdoptionPetDto get pet; AdoptionUserDto get lister; DateTime? get requestedAt; DateTime? get listerConfirmedAt; DateTime? get adopterConfirmedAt;
/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyAdoptionRequestDtoCopyWith<MyAdoptionRequestDto> get copyWith => _$MyAdoptionRequestDtoCopyWithImpl<MyAdoptionRequestDto>(this as MyAdoptionRequestDto, _$identity);

  /// Serializes this MyAdoptionRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyAdoptionRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.listing, listing) || other.listing == listing)&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.lister, lister) || other.lister == lister)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.listerConfirmedAt, listerConfirmedAt) || other.listerConfirmedAt == listerConfirmedAt)&&(identical(other.adopterConfirmedAt, adopterConfirmedAt) || other.adopterConfirmedAt == adopterConfirmedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,statusId,listing,pet,lister,requestedAt,listerConfirmedAt,adopterConfirmedAt);

@override
String toString() {
  return 'MyAdoptionRequestDto(id: $id, statusId: $statusId, listing: $listing, pet: $pet, lister: $lister, requestedAt: $requestedAt, listerConfirmedAt: $listerConfirmedAt, adopterConfirmedAt: $adopterConfirmedAt)';
}


}

/// @nodoc
abstract mixin class $MyAdoptionRequestDtoCopyWith<$Res>  {
  factory $MyAdoptionRequestDtoCopyWith(MyAdoptionRequestDto value, $Res Function(MyAdoptionRequestDto) _then) = _$MyAdoptionRequestDtoCopyWithImpl;
@useResult
$Res call({
 int id, int? statusId, MyRequestListingDto listing, AdoptionPetDto pet, AdoptionUserDto lister, DateTime? requestedAt, DateTime? listerConfirmedAt, DateTime? adopterConfirmedAt
});


$MyRequestListingDtoCopyWith<$Res> get listing;$AdoptionPetDtoCopyWith<$Res> get pet;$AdoptionUserDtoCopyWith<$Res> get lister;

}
/// @nodoc
class _$MyAdoptionRequestDtoCopyWithImpl<$Res>
    implements $MyAdoptionRequestDtoCopyWith<$Res> {
  _$MyAdoptionRequestDtoCopyWithImpl(this._self, this._then);

  final MyAdoptionRequestDto _self;
  final $Res Function(MyAdoptionRequestDto) _then;

/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? statusId = freezed,Object? listing = null,Object? pet = null,Object? lister = null,Object? requestedAt = freezed,Object? listerConfirmedAt = freezed,Object? adopterConfirmedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int?,listing: null == listing ? _self.listing : listing // ignore: cast_nullable_to_non_nullable
as MyRequestListingDto,pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as AdoptionPetDto,lister: null == lister ? _self.lister : lister // ignore: cast_nullable_to_non_nullable
as AdoptionUserDto,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listerConfirmedAt: freezed == listerConfirmedAt ? _self.listerConfirmedAt : listerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adopterConfirmedAt: freezed == adopterConfirmedAt ? _self.adopterConfirmedAt : adopterConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyRequestListingDtoCopyWith<$Res> get listing {
  
  return $MyRequestListingDtoCopyWith<$Res>(_self.listing, (value) {
    return _then(_self.copyWith(listing: value));
  });
}/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionPetDtoCopyWith<$Res> get pet {
  
  return $AdoptionPetDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionUserDtoCopyWith<$Res> get lister {
  
  return $AdoptionUserDtoCopyWith<$Res>(_self.lister, (value) {
    return _then(_self.copyWith(lister: value));
  });
}
}


/// Adds pattern-matching-related methods to [MyAdoptionRequestDto].
extension MyAdoptionRequestDtoPatterns on MyAdoptionRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyAdoptionRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyAdoptionRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyAdoptionRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _MyAdoptionRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyAdoptionRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _MyAdoptionRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? statusId,  MyRequestListingDto listing,  AdoptionPetDto pet,  AdoptionUserDto lister,  DateTime? requestedAt,  DateTime? listerConfirmedAt,  DateTime? adopterConfirmedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyAdoptionRequestDto() when $default != null:
return $default(_that.id,_that.statusId,_that.listing,_that.pet,_that.lister,_that.requestedAt,_that.listerConfirmedAt,_that.adopterConfirmedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? statusId,  MyRequestListingDto listing,  AdoptionPetDto pet,  AdoptionUserDto lister,  DateTime? requestedAt,  DateTime? listerConfirmedAt,  DateTime? adopterConfirmedAt)  $default,) {final _that = this;
switch (_that) {
case _MyAdoptionRequestDto():
return $default(_that.id,_that.statusId,_that.listing,_that.pet,_that.lister,_that.requestedAt,_that.listerConfirmedAt,_that.adopterConfirmedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? statusId,  MyRequestListingDto listing,  AdoptionPetDto pet,  AdoptionUserDto lister,  DateTime? requestedAt,  DateTime? listerConfirmedAt,  DateTime? adopterConfirmedAt)?  $default,) {final _that = this;
switch (_that) {
case _MyAdoptionRequestDto() when $default != null:
return $default(_that.id,_that.statusId,_that.listing,_that.pet,_that.lister,_that.requestedAt,_that.listerConfirmedAt,_that.adopterConfirmedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyAdoptionRequestDto extends MyAdoptionRequestDto {
  const _MyAdoptionRequestDto({required this.id, this.statusId, required this.listing, required this.pet, required this.lister, this.requestedAt, this.listerConfirmedAt, this.adopterConfirmedAt}): super._();
  factory _MyAdoptionRequestDto.fromJson(Map<String, dynamic> json) => _$MyAdoptionRequestDtoFromJson(json);

@override final  int id;
@override final  int? statusId;
@override final  MyRequestListingDto listing;
@override final  AdoptionPetDto pet;
@override final  AdoptionUserDto lister;
@override final  DateTime? requestedAt;
@override final  DateTime? listerConfirmedAt;
@override final  DateTime? adopterConfirmedAt;

/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyAdoptionRequestDtoCopyWith<_MyAdoptionRequestDto> get copyWith => __$MyAdoptionRequestDtoCopyWithImpl<_MyAdoptionRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyAdoptionRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyAdoptionRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.listing, listing) || other.listing == listing)&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.lister, lister) || other.lister == lister)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.listerConfirmedAt, listerConfirmedAt) || other.listerConfirmedAt == listerConfirmedAt)&&(identical(other.adopterConfirmedAt, adopterConfirmedAt) || other.adopterConfirmedAt == adopterConfirmedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,statusId,listing,pet,lister,requestedAt,listerConfirmedAt,adopterConfirmedAt);

@override
String toString() {
  return 'MyAdoptionRequestDto(id: $id, statusId: $statusId, listing: $listing, pet: $pet, lister: $lister, requestedAt: $requestedAt, listerConfirmedAt: $listerConfirmedAt, adopterConfirmedAt: $adopterConfirmedAt)';
}


}

/// @nodoc
abstract mixin class _$MyAdoptionRequestDtoCopyWith<$Res> implements $MyAdoptionRequestDtoCopyWith<$Res> {
  factory _$MyAdoptionRequestDtoCopyWith(_MyAdoptionRequestDto value, $Res Function(_MyAdoptionRequestDto) _then) = __$MyAdoptionRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int? statusId, MyRequestListingDto listing, AdoptionPetDto pet, AdoptionUserDto lister, DateTime? requestedAt, DateTime? listerConfirmedAt, DateTime? adopterConfirmedAt
});


@override $MyRequestListingDtoCopyWith<$Res> get listing;@override $AdoptionPetDtoCopyWith<$Res> get pet;@override $AdoptionUserDtoCopyWith<$Res> get lister;

}
/// @nodoc
class __$MyAdoptionRequestDtoCopyWithImpl<$Res>
    implements _$MyAdoptionRequestDtoCopyWith<$Res> {
  __$MyAdoptionRequestDtoCopyWithImpl(this._self, this._then);

  final _MyAdoptionRequestDto _self;
  final $Res Function(_MyAdoptionRequestDto) _then;

/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? statusId = freezed,Object? listing = null,Object? pet = null,Object? lister = null,Object? requestedAt = freezed,Object? listerConfirmedAt = freezed,Object? adopterConfirmedAt = freezed,}) {
  return _then(_MyAdoptionRequestDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as int?,listing: null == listing ? _self.listing : listing // ignore: cast_nullable_to_non_nullable
as MyRequestListingDto,pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as AdoptionPetDto,lister: null == lister ? _self.lister : lister // ignore: cast_nullable_to_non_nullable
as AdoptionUserDto,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listerConfirmedAt: freezed == listerConfirmedAt ? _self.listerConfirmedAt : listerConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adopterConfirmedAt: freezed == adopterConfirmedAt ? _self.adopterConfirmedAt : adopterConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyRequestListingDtoCopyWith<$Res> get listing {
  
  return $MyRequestListingDtoCopyWith<$Res>(_self.listing, (value) {
    return _then(_self.copyWith(listing: value));
  });
}/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionPetDtoCopyWith<$Res> get pet {
  
  return $AdoptionPetDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of MyAdoptionRequestDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdoptionUserDtoCopyWith<$Res> get lister {
  
  return $AdoptionUserDtoCopyWith<$Res>(_self.lister, (value) {
    return _then(_self.copyWith(lister: value));
  });
}
}

// dart format on
