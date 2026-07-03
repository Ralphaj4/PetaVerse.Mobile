// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lost_found_dashboard_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapPinDto {

 int get id; ReportTypeJson get type; double get latitude; double get longitude;
/// Create a copy of MapPinDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapPinDtoCopyWith<MapPinDto> get copyWith => _$MapPinDtoCopyWithImpl<MapPinDto>(this as MapPinDto, _$identity);

  /// Serializes this MapPinDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapPinDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,latitude,longitude);

@override
String toString() {
  return 'MapPinDto(id: $id, type: $type, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $MapPinDtoCopyWith<$Res>  {
  factory $MapPinDtoCopyWith(MapPinDto value, $Res Function(MapPinDto) _then) = _$MapPinDtoCopyWithImpl;
@useResult
$Res call({
 int id, ReportTypeJson type, double latitude, double longitude
});




}
/// @nodoc
class _$MapPinDtoCopyWithImpl<$Res>
    implements $MapPinDtoCopyWith<$Res> {
  _$MapPinDtoCopyWithImpl(this._self, this._then);

  final MapPinDto _self;
  final $Res Function(MapPinDto) _then;

/// Create a copy of MapPinDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReportTypeJson,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MapPinDto].
extension MapPinDtoPatterns on MapPinDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapPinDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapPinDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapPinDto value)  $default,){
final _that = this;
switch (_that) {
case _MapPinDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapPinDto value)?  $default,){
final _that = this;
switch (_that) {
case _MapPinDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  ReportTypeJson type,  double latitude,  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapPinDto() when $default != null:
return $default(_that.id,_that.type,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  ReportTypeJson type,  double latitude,  double longitude)  $default,) {final _that = this;
switch (_that) {
case _MapPinDto():
return $default(_that.id,_that.type,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  ReportTypeJson type,  double latitude,  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _MapPinDto() when $default != null:
return $default(_that.id,_that.type,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapPinDto extends MapPinDto {
  const _MapPinDto({required this.id, this.type = ReportTypeJson.lost, this.latitude = 0, this.longitude = 0}): super._();
  factory _MapPinDto.fromJson(Map<String, dynamic> json) => _$MapPinDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  ReportTypeJson type;
@override@JsonKey() final  double latitude;
@override@JsonKey() final  double longitude;

/// Create a copy of MapPinDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapPinDtoCopyWith<_MapPinDto> get copyWith => __$MapPinDtoCopyWithImpl<_MapPinDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapPinDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapPinDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,latitude,longitude);

@override
String toString() {
  return 'MapPinDto(id: $id, type: $type, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$MapPinDtoCopyWith<$Res> implements $MapPinDtoCopyWith<$Res> {
  factory _$MapPinDtoCopyWith(_MapPinDto value, $Res Function(_MapPinDto) _then) = __$MapPinDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, ReportTypeJson type, double latitude, double longitude
});




}
/// @nodoc
class __$MapPinDtoCopyWithImpl<$Res>
    implements _$MapPinDtoCopyWith<$Res> {
  __$MapPinDtoCopyWithImpl(this._self, this._then);

  final _MapPinDto _self;
  final $Res Function(_MapPinDto) _then;

/// Create a copy of MapPinDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_MapPinDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReportTypeJson,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$VolunteerInfoDto {

 bool get isVolunteer; int get activeVolunteerCount;
/// Create a copy of VolunteerInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VolunteerInfoDtoCopyWith<VolunteerInfoDto> get copyWith => _$VolunteerInfoDtoCopyWithImpl<VolunteerInfoDto>(this as VolunteerInfoDto, _$identity);

  /// Serializes this VolunteerInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VolunteerInfoDto&&(identical(other.isVolunteer, isVolunteer) || other.isVolunteer == isVolunteer)&&(identical(other.activeVolunteerCount, activeVolunteerCount) || other.activeVolunteerCount == activeVolunteerCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isVolunteer,activeVolunteerCount);

@override
String toString() {
  return 'VolunteerInfoDto(isVolunteer: $isVolunteer, activeVolunteerCount: $activeVolunteerCount)';
}


}

/// @nodoc
abstract mixin class $VolunteerInfoDtoCopyWith<$Res>  {
  factory $VolunteerInfoDtoCopyWith(VolunteerInfoDto value, $Res Function(VolunteerInfoDto) _then) = _$VolunteerInfoDtoCopyWithImpl;
@useResult
$Res call({
 bool isVolunteer, int activeVolunteerCount
});




}
/// @nodoc
class _$VolunteerInfoDtoCopyWithImpl<$Res>
    implements $VolunteerInfoDtoCopyWith<$Res> {
  _$VolunteerInfoDtoCopyWithImpl(this._self, this._then);

  final VolunteerInfoDto _self;
  final $Res Function(VolunteerInfoDto) _then;

/// Create a copy of VolunteerInfoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isVolunteer = null,Object? activeVolunteerCount = null,}) {
  return _then(_self.copyWith(
isVolunteer: null == isVolunteer ? _self.isVolunteer : isVolunteer // ignore: cast_nullable_to_non_nullable
as bool,activeVolunteerCount: null == activeVolunteerCount ? _self.activeVolunteerCount : activeVolunteerCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VolunteerInfoDto].
extension VolunteerInfoDtoPatterns on VolunteerInfoDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VolunteerInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VolunteerInfoDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VolunteerInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _VolunteerInfoDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VolunteerInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _VolunteerInfoDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isVolunteer,  int activeVolunteerCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VolunteerInfoDto() when $default != null:
return $default(_that.isVolunteer,_that.activeVolunteerCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isVolunteer,  int activeVolunteerCount)  $default,) {final _that = this;
switch (_that) {
case _VolunteerInfoDto():
return $default(_that.isVolunteer,_that.activeVolunteerCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isVolunteer,  int activeVolunteerCount)?  $default,) {final _that = this;
switch (_that) {
case _VolunteerInfoDto() when $default != null:
return $default(_that.isVolunteer,_that.activeVolunteerCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VolunteerInfoDto extends VolunteerInfoDto {
  const _VolunteerInfoDto({this.isVolunteer = false, this.activeVolunteerCount = 0}): super._();
  factory _VolunteerInfoDto.fromJson(Map<String, dynamic> json) => _$VolunteerInfoDtoFromJson(json);

@override@JsonKey() final  bool isVolunteer;
@override@JsonKey() final  int activeVolunteerCount;

/// Create a copy of VolunteerInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VolunteerInfoDtoCopyWith<_VolunteerInfoDto> get copyWith => __$VolunteerInfoDtoCopyWithImpl<_VolunteerInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VolunteerInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VolunteerInfoDto&&(identical(other.isVolunteer, isVolunteer) || other.isVolunteer == isVolunteer)&&(identical(other.activeVolunteerCount, activeVolunteerCount) || other.activeVolunteerCount == activeVolunteerCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isVolunteer,activeVolunteerCount);

@override
String toString() {
  return 'VolunteerInfoDto(isVolunteer: $isVolunteer, activeVolunteerCount: $activeVolunteerCount)';
}


}

/// @nodoc
abstract mixin class _$VolunteerInfoDtoCopyWith<$Res> implements $VolunteerInfoDtoCopyWith<$Res> {
  factory _$VolunteerInfoDtoCopyWith(_VolunteerInfoDto value, $Res Function(_VolunteerInfoDto) _then) = __$VolunteerInfoDtoCopyWithImpl;
@override @useResult
$Res call({
 bool isVolunteer, int activeVolunteerCount
});




}
/// @nodoc
class __$VolunteerInfoDtoCopyWithImpl<$Res>
    implements _$VolunteerInfoDtoCopyWith<$Res> {
  __$VolunteerInfoDtoCopyWithImpl(this._self, this._then);

  final _VolunteerInfoDto _self;
  final $Res Function(_VolunteerInfoDto) _then;

/// Create a copy of VolunteerInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isVolunteer = null,Object? activeVolunteerCount = null,}) {
  return _then(_VolunteerInfoDto(
isVolunteer: null == isVolunteer ? _self.isVolunteer : isVolunteer // ignore: cast_nullable_to_non_nullable
as bool,activeVolunteerCount: null == activeVolunteerCount ? _self.activeVolunteerCount : activeVolunteerCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LostFoundDashboardDto {

 int get activeAlertCount; double get radiusKm; List<MapPinDto> get mapPins; List<LostFoundReportDto> get recentAlerts; VolunteerInfoDto get volunteerInfo;
/// Create a copy of LostFoundDashboardDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LostFoundDashboardDtoCopyWith<LostFoundDashboardDto> get copyWith => _$LostFoundDashboardDtoCopyWithImpl<LostFoundDashboardDto>(this as LostFoundDashboardDto, _$identity);

  /// Serializes this LostFoundDashboardDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LostFoundDashboardDto&&(identical(other.activeAlertCount, activeAlertCount) || other.activeAlertCount == activeAlertCount)&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&const DeepCollectionEquality().equals(other.mapPins, mapPins)&&const DeepCollectionEquality().equals(other.recentAlerts, recentAlerts)&&(identical(other.volunteerInfo, volunteerInfo) || other.volunteerInfo == volunteerInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeAlertCount,radiusKm,const DeepCollectionEquality().hash(mapPins),const DeepCollectionEquality().hash(recentAlerts),volunteerInfo);

@override
String toString() {
  return 'LostFoundDashboardDto(activeAlertCount: $activeAlertCount, radiusKm: $radiusKm, mapPins: $mapPins, recentAlerts: $recentAlerts, volunteerInfo: $volunteerInfo)';
}


}

/// @nodoc
abstract mixin class $LostFoundDashboardDtoCopyWith<$Res>  {
  factory $LostFoundDashboardDtoCopyWith(LostFoundDashboardDto value, $Res Function(LostFoundDashboardDto) _then) = _$LostFoundDashboardDtoCopyWithImpl;
@useResult
$Res call({
 int activeAlertCount, double radiusKm, List<MapPinDto> mapPins, List<LostFoundReportDto> recentAlerts, VolunteerInfoDto volunteerInfo
});


$VolunteerInfoDtoCopyWith<$Res> get volunteerInfo;

}
/// @nodoc
class _$LostFoundDashboardDtoCopyWithImpl<$Res>
    implements $LostFoundDashboardDtoCopyWith<$Res> {
  _$LostFoundDashboardDtoCopyWithImpl(this._self, this._then);

  final LostFoundDashboardDto _self;
  final $Res Function(LostFoundDashboardDto) _then;

/// Create a copy of LostFoundDashboardDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeAlertCount = null,Object? radiusKm = null,Object? mapPins = null,Object? recentAlerts = null,Object? volunteerInfo = null,}) {
  return _then(_self.copyWith(
activeAlertCount: null == activeAlertCount ? _self.activeAlertCount : activeAlertCount // ignore: cast_nullable_to_non_nullable
as int,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as double,mapPins: null == mapPins ? _self.mapPins : mapPins // ignore: cast_nullable_to_non_nullable
as List<MapPinDto>,recentAlerts: null == recentAlerts ? _self.recentAlerts : recentAlerts // ignore: cast_nullable_to_non_nullable
as List<LostFoundReportDto>,volunteerInfo: null == volunteerInfo ? _self.volunteerInfo : volunteerInfo // ignore: cast_nullable_to_non_nullable
as VolunteerInfoDto,
  ));
}
/// Create a copy of LostFoundDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VolunteerInfoDtoCopyWith<$Res> get volunteerInfo {
  
  return $VolunteerInfoDtoCopyWith<$Res>(_self.volunteerInfo, (value) {
    return _then(_self.copyWith(volunteerInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [LostFoundDashboardDto].
extension LostFoundDashboardDtoPatterns on LostFoundDashboardDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LostFoundDashboardDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LostFoundDashboardDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LostFoundDashboardDto value)  $default,){
final _that = this;
switch (_that) {
case _LostFoundDashboardDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LostFoundDashboardDto value)?  $default,){
final _that = this;
switch (_that) {
case _LostFoundDashboardDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activeAlertCount,  double radiusKm,  List<MapPinDto> mapPins,  List<LostFoundReportDto> recentAlerts,  VolunteerInfoDto volunteerInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LostFoundDashboardDto() when $default != null:
return $default(_that.activeAlertCount,_that.radiusKm,_that.mapPins,_that.recentAlerts,_that.volunteerInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activeAlertCount,  double radiusKm,  List<MapPinDto> mapPins,  List<LostFoundReportDto> recentAlerts,  VolunteerInfoDto volunteerInfo)  $default,) {final _that = this;
switch (_that) {
case _LostFoundDashboardDto():
return $default(_that.activeAlertCount,_that.radiusKm,_that.mapPins,_that.recentAlerts,_that.volunteerInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activeAlertCount,  double radiusKm,  List<MapPinDto> mapPins,  List<LostFoundReportDto> recentAlerts,  VolunteerInfoDto volunteerInfo)?  $default,) {final _that = this;
switch (_that) {
case _LostFoundDashboardDto() when $default != null:
return $default(_that.activeAlertCount,_that.radiusKm,_that.mapPins,_that.recentAlerts,_that.volunteerInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LostFoundDashboardDto extends LostFoundDashboardDto {
  const _LostFoundDashboardDto({this.activeAlertCount = 0, this.radiusKm = 10, final  List<MapPinDto> mapPins = const <MapPinDto>[], final  List<LostFoundReportDto> recentAlerts = const <LostFoundReportDto>[], this.volunteerInfo = const VolunteerInfoDto()}): _mapPins = mapPins,_recentAlerts = recentAlerts,super._();
  factory _LostFoundDashboardDto.fromJson(Map<String, dynamic> json) => _$LostFoundDashboardDtoFromJson(json);

@override@JsonKey() final  int activeAlertCount;
@override@JsonKey() final  double radiusKm;
 final  List<MapPinDto> _mapPins;
@override@JsonKey() List<MapPinDto> get mapPins {
  if (_mapPins is EqualUnmodifiableListView) return _mapPins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mapPins);
}

 final  List<LostFoundReportDto> _recentAlerts;
@override@JsonKey() List<LostFoundReportDto> get recentAlerts {
  if (_recentAlerts is EqualUnmodifiableListView) return _recentAlerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentAlerts);
}

@override@JsonKey() final  VolunteerInfoDto volunteerInfo;

/// Create a copy of LostFoundDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LostFoundDashboardDtoCopyWith<_LostFoundDashboardDto> get copyWith => __$LostFoundDashboardDtoCopyWithImpl<_LostFoundDashboardDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LostFoundDashboardDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LostFoundDashboardDto&&(identical(other.activeAlertCount, activeAlertCount) || other.activeAlertCount == activeAlertCount)&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&const DeepCollectionEquality().equals(other._mapPins, _mapPins)&&const DeepCollectionEquality().equals(other._recentAlerts, _recentAlerts)&&(identical(other.volunteerInfo, volunteerInfo) || other.volunteerInfo == volunteerInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeAlertCount,radiusKm,const DeepCollectionEquality().hash(_mapPins),const DeepCollectionEquality().hash(_recentAlerts),volunteerInfo);

@override
String toString() {
  return 'LostFoundDashboardDto(activeAlertCount: $activeAlertCount, radiusKm: $radiusKm, mapPins: $mapPins, recentAlerts: $recentAlerts, volunteerInfo: $volunteerInfo)';
}


}

/// @nodoc
abstract mixin class _$LostFoundDashboardDtoCopyWith<$Res> implements $LostFoundDashboardDtoCopyWith<$Res> {
  factory _$LostFoundDashboardDtoCopyWith(_LostFoundDashboardDto value, $Res Function(_LostFoundDashboardDto) _then) = __$LostFoundDashboardDtoCopyWithImpl;
@override @useResult
$Res call({
 int activeAlertCount, double radiusKm, List<MapPinDto> mapPins, List<LostFoundReportDto> recentAlerts, VolunteerInfoDto volunteerInfo
});


@override $VolunteerInfoDtoCopyWith<$Res> get volunteerInfo;

}
/// @nodoc
class __$LostFoundDashboardDtoCopyWithImpl<$Res>
    implements _$LostFoundDashboardDtoCopyWith<$Res> {
  __$LostFoundDashboardDtoCopyWithImpl(this._self, this._then);

  final _LostFoundDashboardDto _self;
  final $Res Function(_LostFoundDashboardDto) _then;

/// Create a copy of LostFoundDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeAlertCount = null,Object? radiusKm = null,Object? mapPins = null,Object? recentAlerts = null,Object? volunteerInfo = null,}) {
  return _then(_LostFoundDashboardDto(
activeAlertCount: null == activeAlertCount ? _self.activeAlertCount : activeAlertCount // ignore: cast_nullable_to_non_nullable
as int,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as double,mapPins: null == mapPins ? _self._mapPins : mapPins // ignore: cast_nullable_to_non_nullable
as List<MapPinDto>,recentAlerts: null == recentAlerts ? _self._recentAlerts : recentAlerts // ignore: cast_nullable_to_non_nullable
as List<LostFoundReportDto>,volunteerInfo: null == volunteerInfo ? _self.volunteerInfo : volunteerInfo // ignore: cast_nullable_to_non_nullable
as VolunteerInfoDto,
  ));
}

/// Create a copy of LostFoundDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VolunteerInfoDtoCopyWith<$Res> get volunteerInfo {
  
  return $VolunteerInfoDtoCopyWith<$Res>(_self.volunteerInfo, (value) {
    return _then(_self.copyWith(volunteerInfo: value));
  });
}
}

// dart format on
