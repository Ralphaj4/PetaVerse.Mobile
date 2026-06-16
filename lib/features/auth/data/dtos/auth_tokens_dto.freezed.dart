// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_tokens_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthTokensDto {

 String get accessToken; String get refreshToken; String get userId; List<String> get roles;
/// Create a copy of AuthTokensDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthTokensDtoCopyWith<AuthTokensDto> get copyWith => _$AuthTokensDtoCopyWithImpl<AuthTokensDto>(this as AuthTokensDto, _$identity);

  /// Serializes this AuthTokensDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthTokensDto&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.roles, roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,userId,const DeepCollectionEquality().hash(roles));

@override
String toString() {
  return 'AuthTokensDto(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, roles: $roles)';
}


}

/// @nodoc
abstract mixin class $AuthTokensDtoCopyWith<$Res>  {
  factory $AuthTokensDtoCopyWith(AuthTokensDto value, $Res Function(AuthTokensDto) _then) = _$AuthTokensDtoCopyWithImpl;
@useResult
$Res call({
 String accessToken, String refreshToken, String userId, List<String> roles
});




}
/// @nodoc
class _$AuthTokensDtoCopyWithImpl<$Res>
    implements $AuthTokensDtoCopyWith<$Res> {
  _$AuthTokensDtoCopyWithImpl(this._self, this._then);

  final AuthTokensDto _self;
  final $Res Function(AuthTokensDto) _then;

/// Create a copy of AuthTokensDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,Object? userId = null,Object? roles = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthTokensDto].
extension AuthTokensDtoPatterns on AuthTokensDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthTokensDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthTokensDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthTokensDto value)  $default,){
final _that = this;
switch (_that) {
case _AuthTokensDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthTokensDto value)?  $default,){
final _that = this;
switch (_that) {
case _AuthTokensDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken,  String userId,  List<String> roles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthTokensDto() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.userId,_that.roles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken,  String userId,  List<String> roles)  $default,) {final _that = this;
switch (_that) {
case _AuthTokensDto():
return $default(_that.accessToken,_that.refreshToken,_that.userId,_that.roles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  String refreshToken,  String userId,  List<String> roles)?  $default,) {final _that = this;
switch (_that) {
case _AuthTokensDto() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.userId,_that.roles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthTokensDto implements AuthTokensDto {
  const _AuthTokensDto({required this.accessToken, required this.refreshToken, this.userId = '', final  List<String> roles = const <String>[]}): _roles = roles;
  factory _AuthTokensDto.fromJson(Map<String, dynamic> json) => _$AuthTokensDtoFromJson(json);

@override final  String accessToken;
@override final  String refreshToken;
@override@JsonKey() final  String userId;
 final  List<String> _roles;
@override@JsonKey() List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}


/// Create a copy of AuthTokensDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthTokensDtoCopyWith<_AuthTokensDto> get copyWith => __$AuthTokensDtoCopyWithImpl<_AuthTokensDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthTokensDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthTokensDto&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._roles, _roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,userId,const DeepCollectionEquality().hash(_roles));

@override
String toString() {
  return 'AuthTokensDto(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, roles: $roles)';
}


}

/// @nodoc
abstract mixin class _$AuthTokensDtoCopyWith<$Res> implements $AuthTokensDtoCopyWith<$Res> {
  factory _$AuthTokensDtoCopyWith(_AuthTokensDto value, $Res Function(_AuthTokensDto) _then) = __$AuthTokensDtoCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, String refreshToken, String userId, List<String> roles
});




}
/// @nodoc
class __$AuthTokensDtoCopyWithImpl<$Res>
    implements _$AuthTokensDtoCopyWith<$Res> {
  __$AuthTokensDtoCopyWithImpl(this._self, this._then);

  final _AuthTokensDto _self;
  final $Res Function(_AuthTokensDto) _then;

/// Create a copy of AuthTokensDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? userId = null,Object? roles = null,}) {
  return _then(_AuthTokensDto(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
