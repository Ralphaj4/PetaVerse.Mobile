// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'co_ownership_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PublicUserCardDto {

 String get id; String get userCode; String get firstName; String get lastName; String? get avatarUrl; bool get hasBeenInvited;
/// Create a copy of PublicUserCardDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicUserCardDtoCopyWith<PublicUserCardDto> get copyWith => _$PublicUserCardDtoCopyWithImpl<PublicUserCardDto>(this as PublicUserCardDto, _$identity);

  /// Serializes this PublicUserCardDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicUserCardDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userCode, userCode) || other.userCode == userCode)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.hasBeenInvited, hasBeenInvited) || other.hasBeenInvited == hasBeenInvited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userCode,firstName,lastName,avatarUrl,hasBeenInvited);

@override
String toString() {
  return 'PublicUserCardDto(id: $id, userCode: $userCode, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, hasBeenInvited: $hasBeenInvited)';
}


}

/// @nodoc
abstract mixin class $PublicUserCardDtoCopyWith<$Res>  {
  factory $PublicUserCardDtoCopyWith(PublicUserCardDto value, $Res Function(PublicUserCardDto) _then) = _$PublicUserCardDtoCopyWithImpl;
@useResult
$Res call({
 String id, String userCode, String firstName, String lastName, String? avatarUrl, bool hasBeenInvited
});




}
/// @nodoc
class _$PublicUserCardDtoCopyWithImpl<$Res>
    implements $PublicUserCardDtoCopyWith<$Res> {
  _$PublicUserCardDtoCopyWithImpl(this._self, this._then);

  final PublicUserCardDto _self;
  final $Res Function(PublicUserCardDto) _then;

/// Create a copy of PublicUserCardDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userCode = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,Object? hasBeenInvited = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userCode: null == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,hasBeenInvited: null == hasBeenInvited ? _self.hasBeenInvited : hasBeenInvited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicUserCardDto].
extension PublicUserCardDtoPatterns on PublicUserCardDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicUserCardDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicUserCardDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicUserCardDto value)  $default,){
final _that = this;
switch (_that) {
case _PublicUserCardDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicUserCardDto value)?  $default,){
final _that = this;
switch (_that) {
case _PublicUserCardDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userCode,  String firstName,  String lastName,  String? avatarUrl,  bool hasBeenInvited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicUserCardDto() when $default != null:
return $default(_that.id,_that.userCode,_that.firstName,_that.lastName,_that.avatarUrl,_that.hasBeenInvited);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userCode,  String firstName,  String lastName,  String? avatarUrl,  bool hasBeenInvited)  $default,) {final _that = this;
switch (_that) {
case _PublicUserCardDto():
return $default(_that.id,_that.userCode,_that.firstName,_that.lastName,_that.avatarUrl,_that.hasBeenInvited);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userCode,  String firstName,  String lastName,  String? avatarUrl,  bool hasBeenInvited)?  $default,) {final _that = this;
switch (_that) {
case _PublicUserCardDto() when $default != null:
return $default(_that.id,_that.userCode,_that.firstName,_that.lastName,_that.avatarUrl,_that.hasBeenInvited);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicUserCardDto extends PublicUserCardDto {
  const _PublicUserCardDto({required this.id, required this.userCode, this.firstName = '', this.lastName = '', this.avatarUrl, this.hasBeenInvited = false}): super._();
  factory _PublicUserCardDto.fromJson(Map<String, dynamic> json) => _$PublicUserCardDtoFromJson(json);

@override final  String id;
@override final  String userCode;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override final  String? avatarUrl;
@override@JsonKey() final  bool hasBeenInvited;

/// Create a copy of PublicUserCardDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicUserCardDtoCopyWith<_PublicUserCardDto> get copyWith => __$PublicUserCardDtoCopyWithImpl<_PublicUserCardDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicUserCardDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicUserCardDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userCode, userCode) || other.userCode == userCode)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.hasBeenInvited, hasBeenInvited) || other.hasBeenInvited == hasBeenInvited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userCode,firstName,lastName,avatarUrl,hasBeenInvited);

@override
String toString() {
  return 'PublicUserCardDto(id: $id, userCode: $userCode, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, hasBeenInvited: $hasBeenInvited)';
}


}

/// @nodoc
abstract mixin class _$PublicUserCardDtoCopyWith<$Res> implements $PublicUserCardDtoCopyWith<$Res> {
  factory _$PublicUserCardDtoCopyWith(_PublicUserCardDto value, $Res Function(_PublicUserCardDto) _then) = __$PublicUserCardDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String userCode, String firstName, String lastName, String? avatarUrl, bool hasBeenInvited
});




}
/// @nodoc
class __$PublicUserCardDtoCopyWithImpl<$Res>
    implements _$PublicUserCardDtoCopyWith<$Res> {
  __$PublicUserCardDtoCopyWithImpl(this._self, this._then);

  final _PublicUserCardDto _self;
  final $Res Function(_PublicUserCardDto) _then;

/// Create a copy of PublicUserCardDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userCode = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,Object? hasBeenInvited = null,}) {
  return _then(_PublicUserCardDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userCode: null == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,hasBeenInvited: null == hasBeenInvited ? _self.hasBeenInvited : hasBeenInvited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PetOwnerDto {

 String get id; String get userCode; String get firstName; String get lastName; String? get avatarUrl;// The owners endpoint names this `isPrimary` (not `isPrimaryOwner`).
@JsonKey(name: 'isPrimary') bool get isPrimaryOwner;
/// Create a copy of PetOwnerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetOwnerDtoCopyWith<PetOwnerDto> get copyWith => _$PetOwnerDtoCopyWithImpl<PetOwnerDto>(this as PetOwnerDto, _$identity);

  /// Serializes this PetOwnerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetOwnerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userCode, userCode) || other.userCode == userCode)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isPrimaryOwner, isPrimaryOwner) || other.isPrimaryOwner == isPrimaryOwner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userCode,firstName,lastName,avatarUrl,isPrimaryOwner);

@override
String toString() {
  return 'PetOwnerDto(id: $id, userCode: $userCode, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, isPrimaryOwner: $isPrimaryOwner)';
}


}

/// @nodoc
abstract mixin class $PetOwnerDtoCopyWith<$Res>  {
  factory $PetOwnerDtoCopyWith(PetOwnerDto value, $Res Function(PetOwnerDto) _then) = _$PetOwnerDtoCopyWithImpl;
@useResult
$Res call({
 String id, String userCode, String firstName, String lastName, String? avatarUrl,@JsonKey(name: 'isPrimary') bool isPrimaryOwner
});




}
/// @nodoc
class _$PetOwnerDtoCopyWithImpl<$Res>
    implements $PetOwnerDtoCopyWith<$Res> {
  _$PetOwnerDtoCopyWithImpl(this._self, this._then);

  final PetOwnerDto _self;
  final $Res Function(PetOwnerDto) _then;

/// Create a copy of PetOwnerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userCode = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,Object? isPrimaryOwner = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userCode: null == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isPrimaryOwner: null == isPrimaryOwner ? _self.isPrimaryOwner : isPrimaryOwner // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PetOwnerDto].
extension PetOwnerDtoPatterns on PetOwnerDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PetOwnerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PetOwnerDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PetOwnerDto value)  $default,){
final _that = this;
switch (_that) {
case _PetOwnerDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PetOwnerDto value)?  $default,){
final _that = this;
switch (_that) {
case _PetOwnerDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userCode,  String firstName,  String lastName,  String? avatarUrl, @JsonKey(name: 'isPrimary')  bool isPrimaryOwner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PetOwnerDto() when $default != null:
return $default(_that.id,_that.userCode,_that.firstName,_that.lastName,_that.avatarUrl,_that.isPrimaryOwner);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userCode,  String firstName,  String lastName,  String? avatarUrl, @JsonKey(name: 'isPrimary')  bool isPrimaryOwner)  $default,) {final _that = this;
switch (_that) {
case _PetOwnerDto():
return $default(_that.id,_that.userCode,_that.firstName,_that.lastName,_that.avatarUrl,_that.isPrimaryOwner);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userCode,  String firstName,  String lastName,  String? avatarUrl, @JsonKey(name: 'isPrimary')  bool isPrimaryOwner)?  $default,) {final _that = this;
switch (_that) {
case _PetOwnerDto() when $default != null:
return $default(_that.id,_that.userCode,_that.firstName,_that.lastName,_that.avatarUrl,_that.isPrimaryOwner);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PetOwnerDto extends PetOwnerDto {
  const _PetOwnerDto({required this.id, required this.userCode, this.firstName = '', this.lastName = '', this.avatarUrl, @JsonKey(name: 'isPrimary') this.isPrimaryOwner = false}): super._();
  factory _PetOwnerDto.fromJson(Map<String, dynamic> json) => _$PetOwnerDtoFromJson(json);

@override final  String id;
@override final  String userCode;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override final  String? avatarUrl;
// The owners endpoint names this `isPrimary` (not `isPrimaryOwner`).
@override@JsonKey(name: 'isPrimary') final  bool isPrimaryOwner;

/// Create a copy of PetOwnerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetOwnerDtoCopyWith<_PetOwnerDto> get copyWith => __$PetOwnerDtoCopyWithImpl<_PetOwnerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetOwnerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetOwnerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userCode, userCode) || other.userCode == userCode)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isPrimaryOwner, isPrimaryOwner) || other.isPrimaryOwner == isPrimaryOwner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userCode,firstName,lastName,avatarUrl,isPrimaryOwner);

@override
String toString() {
  return 'PetOwnerDto(id: $id, userCode: $userCode, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, isPrimaryOwner: $isPrimaryOwner)';
}


}

/// @nodoc
abstract mixin class _$PetOwnerDtoCopyWith<$Res> implements $PetOwnerDtoCopyWith<$Res> {
  factory _$PetOwnerDtoCopyWith(_PetOwnerDto value, $Res Function(_PetOwnerDto) _then) = __$PetOwnerDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String userCode, String firstName, String lastName, String? avatarUrl,@JsonKey(name: 'isPrimary') bool isPrimaryOwner
});




}
/// @nodoc
class __$PetOwnerDtoCopyWithImpl<$Res>
    implements _$PetOwnerDtoCopyWith<$Res> {
  __$PetOwnerDtoCopyWithImpl(this._self, this._then);

  final _PetOwnerDto _self;
  final $Res Function(_PetOwnerDto) _then;

/// Create a copy of PetOwnerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userCode = null,Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,Object? isPrimaryOwner = null,}) {
  return _then(_PetOwnerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userCode: null == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isPrimaryOwner: null == isPrimaryOwner ? _self.isPrimaryOwner : isPrimaryOwner // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SentCoOwnerInviteDto {

 int get id; CoOwnershipStatusJson get status; PublicUserCardDto get invitee; DateTime? get createdAt;
/// Create a copy of SentCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentCoOwnerInviteDtoCopyWith<SentCoOwnerInviteDto> get copyWith => _$SentCoOwnerInviteDtoCopyWithImpl<SentCoOwnerInviteDto>(this as SentCoOwnerInviteDto, _$identity);

  /// Serializes this SentCoOwnerInviteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentCoOwnerInviteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.invitee, invitee) || other.invitee == invitee)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,invitee,createdAt);

@override
String toString() {
  return 'SentCoOwnerInviteDto(id: $id, status: $status, invitee: $invitee, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SentCoOwnerInviteDtoCopyWith<$Res>  {
  factory $SentCoOwnerInviteDtoCopyWith(SentCoOwnerInviteDto value, $Res Function(SentCoOwnerInviteDto) _then) = _$SentCoOwnerInviteDtoCopyWithImpl;
@useResult
$Res call({
 int id, CoOwnershipStatusJson status, PublicUserCardDto invitee, DateTime? createdAt
});


$PublicUserCardDtoCopyWith<$Res> get invitee;

}
/// @nodoc
class _$SentCoOwnerInviteDtoCopyWithImpl<$Res>
    implements $SentCoOwnerInviteDtoCopyWith<$Res> {
  _$SentCoOwnerInviteDtoCopyWithImpl(this._self, this._then);

  final SentCoOwnerInviteDto _self;
  final $Res Function(SentCoOwnerInviteDto) _then;

/// Create a copy of SentCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? invitee = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CoOwnershipStatusJson,invitee: null == invitee ? _self.invitee : invitee // ignore: cast_nullable_to_non_nullable
as PublicUserCardDto,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SentCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicUserCardDtoCopyWith<$Res> get invitee {
  
  return $PublicUserCardDtoCopyWith<$Res>(_self.invitee, (value) {
    return _then(_self.copyWith(invitee: value));
  });
}
}


/// Adds pattern-matching-related methods to [SentCoOwnerInviteDto].
extension SentCoOwnerInviteDtoPatterns on SentCoOwnerInviteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentCoOwnerInviteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentCoOwnerInviteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentCoOwnerInviteDto value)  $default,){
final _that = this;
switch (_that) {
case _SentCoOwnerInviteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentCoOwnerInviteDto value)?  $default,){
final _that = this;
switch (_that) {
case _SentCoOwnerInviteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  CoOwnershipStatusJson status,  PublicUserCardDto invitee,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentCoOwnerInviteDto() when $default != null:
return $default(_that.id,_that.status,_that.invitee,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  CoOwnershipStatusJson status,  PublicUserCardDto invitee,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SentCoOwnerInviteDto():
return $default(_that.id,_that.status,_that.invitee,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  CoOwnershipStatusJson status,  PublicUserCardDto invitee,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SentCoOwnerInviteDto() when $default != null:
return $default(_that.id,_that.status,_that.invitee,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SentCoOwnerInviteDto extends SentCoOwnerInviteDto {
  const _SentCoOwnerInviteDto({required this.id, this.status = CoOwnershipStatusJson.pending, required this.invitee, this.createdAt}): super._();
  factory _SentCoOwnerInviteDto.fromJson(Map<String, dynamic> json) => _$SentCoOwnerInviteDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  CoOwnershipStatusJson status;
@override final  PublicUserCardDto invitee;
@override final  DateTime? createdAt;

/// Create a copy of SentCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentCoOwnerInviteDtoCopyWith<_SentCoOwnerInviteDto> get copyWith => __$SentCoOwnerInviteDtoCopyWithImpl<_SentCoOwnerInviteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SentCoOwnerInviteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentCoOwnerInviteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.invitee, invitee) || other.invitee == invitee)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,invitee,createdAt);

@override
String toString() {
  return 'SentCoOwnerInviteDto(id: $id, status: $status, invitee: $invitee, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SentCoOwnerInviteDtoCopyWith<$Res> implements $SentCoOwnerInviteDtoCopyWith<$Res> {
  factory _$SentCoOwnerInviteDtoCopyWith(_SentCoOwnerInviteDto value, $Res Function(_SentCoOwnerInviteDto) _then) = __$SentCoOwnerInviteDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, CoOwnershipStatusJson status, PublicUserCardDto invitee, DateTime? createdAt
});


@override $PublicUserCardDtoCopyWith<$Res> get invitee;

}
/// @nodoc
class __$SentCoOwnerInviteDtoCopyWithImpl<$Res>
    implements _$SentCoOwnerInviteDtoCopyWith<$Res> {
  __$SentCoOwnerInviteDtoCopyWithImpl(this._self, this._then);

  final _SentCoOwnerInviteDto _self;
  final $Res Function(_SentCoOwnerInviteDto) _then;

/// Create a copy of SentCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? invitee = null,Object? createdAt = freezed,}) {
  return _then(_SentCoOwnerInviteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CoOwnershipStatusJson,invitee: null == invitee ? _self.invitee : invitee // ignore: cast_nullable_to_non_nullable
as PublicUserCardDto,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SentCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicUserCardDtoCopyWith<$Res> get invitee {
  
  return $PublicUserCardDtoCopyWith<$Res>(_self.invitee, (value) {
    return _then(_self.copyWith(invitee: value));
  });
}
}


/// @nodoc
mixin _$IncomingCoOwnerInviteDto {

 int get id; CoOwnershipStatusJson get status; InvitePetDto get pet; InviteInviterDto get inviter; DateTime? get createdAt;
/// Create a copy of IncomingCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomingCoOwnerInviteDtoCopyWith<IncomingCoOwnerInviteDto> get copyWith => _$IncomingCoOwnerInviteDtoCopyWithImpl<IncomingCoOwnerInviteDto>(this as IncomingCoOwnerInviteDto, _$identity);

  /// Serializes this IncomingCoOwnerInviteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomingCoOwnerInviteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.inviter, inviter) || other.inviter == inviter)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,pet,inviter,createdAt);

@override
String toString() {
  return 'IncomingCoOwnerInviteDto(id: $id, status: $status, pet: $pet, inviter: $inviter, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $IncomingCoOwnerInviteDtoCopyWith<$Res>  {
  factory $IncomingCoOwnerInviteDtoCopyWith(IncomingCoOwnerInviteDto value, $Res Function(IncomingCoOwnerInviteDto) _then) = _$IncomingCoOwnerInviteDtoCopyWithImpl;
@useResult
$Res call({
 int id, CoOwnershipStatusJson status, InvitePetDto pet, InviteInviterDto inviter, DateTime? createdAt
});


$InvitePetDtoCopyWith<$Res> get pet;$InviteInviterDtoCopyWith<$Res> get inviter;

}
/// @nodoc
class _$IncomingCoOwnerInviteDtoCopyWithImpl<$Res>
    implements $IncomingCoOwnerInviteDtoCopyWith<$Res> {
  _$IncomingCoOwnerInviteDtoCopyWithImpl(this._self, this._then);

  final IncomingCoOwnerInviteDto _self;
  final $Res Function(IncomingCoOwnerInviteDto) _then;

/// Create a copy of IncomingCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? pet = null,Object? inviter = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CoOwnershipStatusJson,pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as InvitePetDto,inviter: null == inviter ? _self.inviter : inviter // ignore: cast_nullable_to_non_nullable
as InviteInviterDto,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of IncomingCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvitePetDtoCopyWith<$Res> get pet {
  
  return $InvitePetDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of IncomingCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InviteInviterDtoCopyWith<$Res> get inviter {
  
  return $InviteInviterDtoCopyWith<$Res>(_self.inviter, (value) {
    return _then(_self.copyWith(inviter: value));
  });
}
}


/// Adds pattern-matching-related methods to [IncomingCoOwnerInviteDto].
extension IncomingCoOwnerInviteDtoPatterns on IncomingCoOwnerInviteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomingCoOwnerInviteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomingCoOwnerInviteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomingCoOwnerInviteDto value)  $default,){
final _that = this;
switch (_that) {
case _IncomingCoOwnerInviteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomingCoOwnerInviteDto value)?  $default,){
final _that = this;
switch (_that) {
case _IncomingCoOwnerInviteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  CoOwnershipStatusJson status,  InvitePetDto pet,  InviteInviterDto inviter,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomingCoOwnerInviteDto() when $default != null:
return $default(_that.id,_that.status,_that.pet,_that.inviter,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  CoOwnershipStatusJson status,  InvitePetDto pet,  InviteInviterDto inviter,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _IncomingCoOwnerInviteDto():
return $default(_that.id,_that.status,_that.pet,_that.inviter,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  CoOwnershipStatusJson status,  InvitePetDto pet,  InviteInviterDto inviter,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _IncomingCoOwnerInviteDto() when $default != null:
return $default(_that.id,_that.status,_that.pet,_that.inviter,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IncomingCoOwnerInviteDto extends IncomingCoOwnerInviteDto {
  const _IncomingCoOwnerInviteDto({required this.id, this.status = CoOwnershipStatusJson.pending, required this.pet, required this.inviter, this.createdAt}): super._();
  factory _IncomingCoOwnerInviteDto.fromJson(Map<String, dynamic> json) => _$IncomingCoOwnerInviteDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  CoOwnershipStatusJson status;
@override final  InvitePetDto pet;
@override final  InviteInviterDto inviter;
@override final  DateTime? createdAt;

/// Create a copy of IncomingCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomingCoOwnerInviteDtoCopyWith<_IncomingCoOwnerInviteDto> get copyWith => __$IncomingCoOwnerInviteDtoCopyWithImpl<_IncomingCoOwnerInviteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncomingCoOwnerInviteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomingCoOwnerInviteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.inviter, inviter) || other.inviter == inviter)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,pet,inviter,createdAt);

@override
String toString() {
  return 'IncomingCoOwnerInviteDto(id: $id, status: $status, pet: $pet, inviter: $inviter, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$IncomingCoOwnerInviteDtoCopyWith<$Res> implements $IncomingCoOwnerInviteDtoCopyWith<$Res> {
  factory _$IncomingCoOwnerInviteDtoCopyWith(_IncomingCoOwnerInviteDto value, $Res Function(_IncomingCoOwnerInviteDto) _then) = __$IncomingCoOwnerInviteDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, CoOwnershipStatusJson status, InvitePetDto pet, InviteInviterDto inviter, DateTime? createdAt
});


@override $InvitePetDtoCopyWith<$Res> get pet;@override $InviteInviterDtoCopyWith<$Res> get inviter;

}
/// @nodoc
class __$IncomingCoOwnerInviteDtoCopyWithImpl<$Res>
    implements _$IncomingCoOwnerInviteDtoCopyWith<$Res> {
  __$IncomingCoOwnerInviteDtoCopyWithImpl(this._self, this._then);

  final _IncomingCoOwnerInviteDto _self;
  final $Res Function(_IncomingCoOwnerInviteDto) _then;

/// Create a copy of IncomingCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? pet = null,Object? inviter = null,Object? createdAt = freezed,}) {
  return _then(_IncomingCoOwnerInviteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CoOwnershipStatusJson,pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as InvitePetDto,inviter: null == inviter ? _self.inviter : inviter // ignore: cast_nullable_to_non_nullable
as InviteInviterDto,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of IncomingCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvitePetDtoCopyWith<$Res> get pet {
  
  return $InvitePetDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of IncomingCoOwnerInviteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InviteInviterDtoCopyWith<$Res> get inviter {
  
  return $InviteInviterDtoCopyWith<$Res>(_self.inviter, (value) {
    return _then(_self.copyWith(inviter: value));
  });
}
}


/// @nodoc
mixin _$InvitePetDto {

 int get id; String get name; String get speciesName; String? get breedName; String? get avatarUrl;
/// Create a copy of InvitePetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitePetDtoCopyWith<InvitePetDto> get copyWith => _$InvitePetDtoCopyWithImpl<InvitePetDto>(this as InvitePetDto, _$identity);

  /// Serializes this InvitePetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitePetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,speciesName,breedName,avatarUrl);

@override
String toString() {
  return 'InvitePetDto(id: $id, name: $name, speciesName: $speciesName, breedName: $breedName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $InvitePetDtoCopyWith<$Res>  {
  factory $InvitePetDtoCopyWith(InvitePetDto value, $Res Function(InvitePetDto) _then) = _$InvitePetDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String speciesName, String? breedName, String? avatarUrl
});




}
/// @nodoc
class _$InvitePetDtoCopyWithImpl<$Res>
    implements $InvitePetDtoCopyWith<$Res> {
  _$InvitePetDtoCopyWithImpl(this._self, this._then);

  final InvitePetDto _self;
  final $Res Function(InvitePetDto) _then;

/// Create a copy of InvitePetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? speciesName = null,Object? breedName = freezed,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,speciesName: null == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String,breedName: freezed == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InvitePetDto].
extension InvitePetDtoPatterns on InvitePetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvitePetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvitePetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvitePetDto value)  $default,){
final _that = this;
switch (_that) {
case _InvitePetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvitePetDto value)?  $default,){
final _that = this;
switch (_that) {
case _InvitePetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String speciesName,  String? breedName,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvitePetDto() when $default != null:
return $default(_that.id,_that.name,_that.speciesName,_that.breedName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String speciesName,  String? breedName,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _InvitePetDto():
return $default(_that.id,_that.name,_that.speciesName,_that.breedName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String speciesName,  String? breedName,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _InvitePetDto() when $default != null:
return $default(_that.id,_that.name,_that.speciesName,_that.breedName,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvitePetDto extends InvitePetDto {
  const _InvitePetDto({required this.id, this.name = '', this.speciesName = '', this.breedName, this.avatarUrl}): super._();
  factory _InvitePetDto.fromJson(Map<String, dynamic> json) => _$InvitePetDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String speciesName;
@override final  String? breedName;
@override final  String? avatarUrl;

/// Create a copy of InvitePetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitePetDtoCopyWith<_InvitePetDto> get copyWith => __$InvitePetDtoCopyWithImpl<_InvitePetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvitePetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvitePetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,speciesName,breedName,avatarUrl);

@override
String toString() {
  return 'InvitePetDto(id: $id, name: $name, speciesName: $speciesName, breedName: $breedName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$InvitePetDtoCopyWith<$Res> implements $InvitePetDtoCopyWith<$Res> {
  factory _$InvitePetDtoCopyWith(_InvitePetDto value, $Res Function(_InvitePetDto) _then) = __$InvitePetDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String speciesName, String? breedName, String? avatarUrl
});




}
/// @nodoc
class __$InvitePetDtoCopyWithImpl<$Res>
    implements _$InvitePetDtoCopyWith<$Res> {
  __$InvitePetDtoCopyWithImpl(this._self, this._then);

  final _InvitePetDto _self;
  final $Res Function(_InvitePetDto) _then;

/// Create a copy of InvitePetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? speciesName = null,Object? breedName = freezed,Object? avatarUrl = freezed,}) {
  return _then(_InvitePetDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,speciesName: null == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String,breedName: freezed == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$InviteInviterDto {

 String get firstName; String get lastName; String? get avatarUrl;
/// Create a copy of InviteInviterDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteInviterDtoCopyWith<InviteInviterDto> get copyWith => _$InviteInviterDtoCopyWithImpl<InviteInviterDto>(this as InviteInviterDto, _$identity);

  /// Serializes this InviteInviterDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteInviterDto&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,avatarUrl);

@override
String toString() {
  return 'InviteInviterDto(firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $InviteInviterDtoCopyWith<$Res>  {
  factory $InviteInviterDtoCopyWith(InviteInviterDto value, $Res Function(InviteInviterDto) _then) = _$InviteInviterDtoCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String? avatarUrl
});




}
/// @nodoc
class _$InviteInviterDtoCopyWithImpl<$Res>
    implements $InviteInviterDtoCopyWith<$Res> {
  _$InviteInviterDtoCopyWithImpl(this._self, this._then);

  final InviteInviterDto _self;
  final $Res Function(InviteInviterDto) _then;

/// Create a copy of InviteInviterDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteInviterDto].
extension InviteInviterDtoPatterns on InviteInviterDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteInviterDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteInviterDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteInviterDto value)  $default,){
final _that = this;
switch (_that) {
case _InviteInviterDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteInviterDto value)?  $default,){
final _that = this;
switch (_that) {
case _InviteInviterDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteInviterDto() when $default != null:
return $default(_that.firstName,_that.lastName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _InviteInviterDto():
return $default(_that.firstName,_that.lastName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _InviteInviterDto() when $default != null:
return $default(_that.firstName,_that.lastName,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteInviterDto extends InviteInviterDto {
  const _InviteInviterDto({this.firstName = '', this.lastName = '', this.avatarUrl}): super._();
  factory _InviteInviterDto.fromJson(Map<String, dynamic> json) => _$InviteInviterDtoFromJson(json);

@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override final  String? avatarUrl;

/// Create a copy of InviteInviterDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteInviterDtoCopyWith<_InviteInviterDto> get copyWith => __$InviteInviterDtoCopyWithImpl<_InviteInviterDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteInviterDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteInviterDto&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,avatarUrl);

@override
String toString() {
  return 'InviteInviterDto(firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$InviteInviterDtoCopyWith<$Res> implements $InviteInviterDtoCopyWith<$Res> {
  factory _$InviteInviterDtoCopyWith(_InviteInviterDto value, $Res Function(_InviteInviterDto) _then) = __$InviteInviterDtoCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String? avatarUrl
});




}
/// @nodoc
class __$InviteInviterDtoCopyWithImpl<$Res>
    implements _$InviteInviterDtoCopyWith<$Res> {
  __$InviteInviterDtoCopyWithImpl(this._self, this._then);

  final _InviteInviterDto _self;
  final $Res Function(_InviteInviterDto) _then;

/// Create a copy of InviteInviterDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? avatarUrl = freezed,}) {
  return _then(_InviteInviterDto(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
