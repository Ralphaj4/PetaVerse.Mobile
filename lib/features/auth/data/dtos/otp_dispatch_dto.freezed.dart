// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_dispatch_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtpDispatchDto {

 String get message; bool get requiresVerification; String? get devOtp;
/// Create a copy of OtpDispatchDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpDispatchDtoCopyWith<OtpDispatchDto> get copyWith => _$OtpDispatchDtoCopyWithImpl<OtpDispatchDto>(this as OtpDispatchDto, _$identity);

  /// Serializes this OtpDispatchDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpDispatchDto&&(identical(other.message, message) || other.message == message)&&(identical(other.requiresVerification, requiresVerification) || other.requiresVerification == requiresVerification)&&(identical(other.devOtp, devOtp) || other.devOtp == devOtp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,requiresVerification,devOtp);

@override
String toString() {
  return 'OtpDispatchDto(message: $message, requiresVerification: $requiresVerification, devOtp: $devOtp)';
}


}

/// @nodoc
abstract mixin class $OtpDispatchDtoCopyWith<$Res>  {
  factory $OtpDispatchDtoCopyWith(OtpDispatchDto value, $Res Function(OtpDispatchDto) _then) = _$OtpDispatchDtoCopyWithImpl;
@useResult
$Res call({
 String message, bool requiresVerification, String? devOtp
});




}
/// @nodoc
class _$OtpDispatchDtoCopyWithImpl<$Res>
    implements $OtpDispatchDtoCopyWith<$Res> {
  _$OtpDispatchDtoCopyWithImpl(this._self, this._then);

  final OtpDispatchDto _self;
  final $Res Function(OtpDispatchDto) _then;

/// Create a copy of OtpDispatchDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? requiresVerification = null,Object? devOtp = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,requiresVerification: null == requiresVerification ? _self.requiresVerification : requiresVerification // ignore: cast_nullable_to_non_nullable
as bool,devOtp: freezed == devOtp ? _self.devOtp : devOtp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpDispatchDto].
extension OtpDispatchDtoPatterns on OtpDispatchDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpDispatchDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpDispatchDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpDispatchDto value)  $default,){
final _that = this;
switch (_that) {
case _OtpDispatchDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpDispatchDto value)?  $default,){
final _that = this;
switch (_that) {
case _OtpDispatchDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  bool requiresVerification,  String? devOtp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpDispatchDto() when $default != null:
return $default(_that.message,_that.requiresVerification,_that.devOtp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  bool requiresVerification,  String? devOtp)  $default,) {final _that = this;
switch (_that) {
case _OtpDispatchDto():
return $default(_that.message,_that.requiresVerification,_that.devOtp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  bool requiresVerification,  String? devOtp)?  $default,) {final _that = this;
switch (_that) {
case _OtpDispatchDto() when $default != null:
return $default(_that.message,_that.requiresVerification,_that.devOtp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtpDispatchDto implements OtpDispatchDto {
  const _OtpDispatchDto({this.message = '', this.requiresVerification = false, this.devOtp});
  factory _OtpDispatchDto.fromJson(Map<String, dynamic> json) => _$OtpDispatchDtoFromJson(json);

@override@JsonKey() final  String message;
@override@JsonKey() final  bool requiresVerification;
@override final  String? devOtp;

/// Create a copy of OtpDispatchDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpDispatchDtoCopyWith<_OtpDispatchDto> get copyWith => __$OtpDispatchDtoCopyWithImpl<_OtpDispatchDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpDispatchDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpDispatchDto&&(identical(other.message, message) || other.message == message)&&(identical(other.requiresVerification, requiresVerification) || other.requiresVerification == requiresVerification)&&(identical(other.devOtp, devOtp) || other.devOtp == devOtp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,requiresVerification,devOtp);

@override
String toString() {
  return 'OtpDispatchDto(message: $message, requiresVerification: $requiresVerification, devOtp: $devOtp)';
}


}

/// @nodoc
abstract mixin class _$OtpDispatchDtoCopyWith<$Res> implements $OtpDispatchDtoCopyWith<$Res> {
  factory _$OtpDispatchDtoCopyWith(_OtpDispatchDto value, $Res Function(_OtpDispatchDto) _then) = __$OtpDispatchDtoCopyWithImpl;
@override @useResult
$Res call({
 String message, bool requiresVerification, String? devOtp
});




}
/// @nodoc
class __$OtpDispatchDtoCopyWithImpl<$Res>
    implements _$OtpDispatchDtoCopyWith<$Res> {
  __$OtpDispatchDtoCopyWithImpl(this._self, this._then);

  final _OtpDispatchDto _self;
  final $Res Function(_OtpDispatchDto) _then;

/// Create a copy of OtpDispatchDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? requiresVerification = null,Object? devOtp = freezed,}) {
  return _then(_OtpDispatchDto(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,requiresVerification: null == requiresVerification ? _self.requiresVerification : requiresVerification // ignore: cast_nullable_to_non_nullable
as bool,devOtp: freezed == devOtp ? _self.devOtp : devOtp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
