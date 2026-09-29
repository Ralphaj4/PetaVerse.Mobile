// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginResponseDto {

 bool get requiresVerification; String? get accessToken; String? get refreshToken; String? get userId; String? get userCode; List<String> get roles; String? get mobileNumber; String? get devOtp;
/// Create a copy of LoginResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginResponseDtoCopyWith<LoginResponseDto> get copyWith => _$LoginResponseDtoCopyWithImpl<LoginResponseDto>(this as LoginResponseDto, _$identity);

  /// Serializes this LoginResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginResponseDto&&(identical(other.requiresVerification, requiresVerification) || other.requiresVerification == requiresVerification)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userCode, userCode) || other.userCode == userCode)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.devOtp, devOtp) || other.devOtp == devOtp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requiresVerification,accessToken,refreshToken,userId,userCode,const DeepCollectionEquality().hash(roles),mobileNumber,devOtp);

@override
String toString() {
  return 'LoginResponseDto(requiresVerification: $requiresVerification, accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, userCode: $userCode, roles: $roles, mobileNumber: $mobileNumber, devOtp: $devOtp)';
}


}

/// @nodoc
abstract mixin class $LoginResponseDtoCopyWith<$Res>  {
  factory $LoginResponseDtoCopyWith(LoginResponseDto value, $Res Function(LoginResponseDto) _then) = _$LoginResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool requiresVerification, String? accessToken, String? refreshToken, String? userId, String? userCode, List<String> roles, String? mobileNumber, String? devOtp
});




}
/// @nodoc
class _$LoginResponseDtoCopyWithImpl<$Res>
    implements $LoginResponseDtoCopyWith<$Res> {
  _$LoginResponseDtoCopyWithImpl(this._self, this._then);

  final LoginResponseDto _self;
  final $Res Function(LoginResponseDto) _then;

/// Create a copy of LoginResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requiresVerification = null,Object? accessToken = freezed,Object? refreshToken = freezed,Object? userId = freezed,Object? userCode = freezed,Object? roles = null,Object? mobileNumber = freezed,Object? devOtp = freezed,}) {
  return _then(_self.copyWith(
requiresVerification: null == requiresVerification ? _self.requiresVerification : requiresVerification // ignore: cast_nullable_to_non_nullable
as bool,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userCode: freezed == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String?,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,devOtp: freezed == devOtp ? _self.devOtp : devOtp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginResponseDto].
extension LoginResponseDtoPatterns on LoginResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _LoginResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _LoginResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool requiresVerification,  String? accessToken,  String? refreshToken,  String? userId,  String? userCode,  List<String> roles,  String? mobileNumber,  String? devOtp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginResponseDto() when $default != null:
return $default(_that.requiresVerification,_that.accessToken,_that.refreshToken,_that.userId,_that.userCode,_that.roles,_that.mobileNumber,_that.devOtp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool requiresVerification,  String? accessToken,  String? refreshToken,  String? userId,  String? userCode,  List<String> roles,  String? mobileNumber,  String? devOtp)  $default,) {final _that = this;
switch (_that) {
case _LoginResponseDto():
return $default(_that.requiresVerification,_that.accessToken,_that.refreshToken,_that.userId,_that.userCode,_that.roles,_that.mobileNumber,_that.devOtp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool requiresVerification,  String? accessToken,  String? refreshToken,  String? userId,  String? userCode,  List<String> roles,  String? mobileNumber,  String? devOtp)?  $default,) {final _that = this;
switch (_that) {
case _LoginResponseDto() when $default != null:
return $default(_that.requiresVerification,_that.accessToken,_that.refreshToken,_that.userId,_that.userCode,_that.roles,_that.mobileNumber,_that.devOtp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginResponseDto implements LoginResponseDto {
  const _LoginResponseDto({this.requiresVerification = false, this.accessToken, this.refreshToken, this.userId, this.userCode, final  List<String> roles = const <String>[], this.mobileNumber, this.devOtp}): _roles = roles;
  factory _LoginResponseDto.fromJson(Map<String, dynamic> json) => _$LoginResponseDtoFromJson(json);

@override@JsonKey() final  bool requiresVerification;
@override final  String? accessToken;
@override final  String? refreshToken;
@override final  String? userId;
@override final  String? userCode;
 final  List<String> _roles;
@override@JsonKey() List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

@override final  String? mobileNumber;
@override final  String? devOtp;

/// Create a copy of LoginResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginResponseDtoCopyWith<_LoginResponseDto> get copyWith => __$LoginResponseDtoCopyWithImpl<_LoginResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginResponseDto&&(identical(other.requiresVerification, requiresVerification) || other.requiresVerification == requiresVerification)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userCode, userCode) || other.userCode == userCode)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.devOtp, devOtp) || other.devOtp == devOtp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requiresVerification,accessToken,refreshToken,userId,userCode,const DeepCollectionEquality().hash(_roles),mobileNumber,devOtp);

@override
String toString() {
  return 'LoginResponseDto(requiresVerification: $requiresVerification, accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, userCode: $userCode, roles: $roles, mobileNumber: $mobileNumber, devOtp: $devOtp)';
}


}

/// @nodoc
abstract mixin class _$LoginResponseDtoCopyWith<$Res> implements $LoginResponseDtoCopyWith<$Res> {
  factory _$LoginResponseDtoCopyWith(_LoginResponseDto value, $Res Function(_LoginResponseDto) _then) = __$LoginResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool requiresVerification, String? accessToken, String? refreshToken, String? userId, String? userCode, List<String> roles, String? mobileNumber, String? devOtp
});




}
/// @nodoc
class __$LoginResponseDtoCopyWithImpl<$Res>
    implements _$LoginResponseDtoCopyWith<$Res> {
  __$LoginResponseDtoCopyWithImpl(this._self, this._then);

  final _LoginResponseDto _self;
  final $Res Function(_LoginResponseDto) _then;

/// Create a copy of LoginResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requiresVerification = null,Object? accessToken = freezed,Object? refreshToken = freezed,Object? userId = freezed,Object? userCode = freezed,Object? roles = null,Object? mobileNumber = freezed,Object? devOtp = freezed,}) {
  return _then(_LoginResponseDto(
requiresVerification: null == requiresVerification ? _self.requiresVerification : requiresVerification // ignore: cast_nullable_to_non_nullable
as bool,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userCode: freezed == userCode ? _self.userCode : userCode // ignore: cast_nullable_to_non_nullable
as String?,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,devOtp: freezed == devOtp ? _self.devOtp : devOtp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
