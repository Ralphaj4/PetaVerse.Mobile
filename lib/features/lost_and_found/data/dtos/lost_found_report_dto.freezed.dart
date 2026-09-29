// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lost_found_report_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LostFoundReportDto {

 int get id; ReportTypeJson get type; String get petName; String get speciesName; String? get breedName; String get description; String get lastSeenAddress; double get latitude; double get longitude; String? get imageUrl; ReportStatusJson get status; DateTime? get createdAt; String? get reporterName; String? get reporterPhone;// The linked pet, when the report references one of the user's pets.
 int? get petId;// True when the current user owns this report (can edit/delete it).
 bool get isOwner;// Reward offered for a Lost pet (0–999); null when none / Found.
 int? get reward;
/// Create a copy of LostFoundReportDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LostFoundReportDtoCopyWith<LostFoundReportDto> get copyWith => _$LostFoundReportDtoCopyWithImpl<LostFoundReportDto>(this as LostFoundReportDto, _$identity);

  /// Serializes this LostFoundReportDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LostFoundReportDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.description, description) || other.description == description)&&(identical(other.lastSeenAddress, lastSeenAddress) || other.lastSeenAddress == lastSeenAddress)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reporterName, reporterName) || other.reporterName == reporterName)&&(identical(other.reporterPhone, reporterPhone) || other.reporterPhone == reporterPhone)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner)&&(identical(other.reward, reward) || other.reward == reward));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,petName,speciesName,breedName,description,lastSeenAddress,latitude,longitude,imageUrl,status,createdAt,reporterName,reporterPhone,petId,isOwner,reward);

@override
String toString() {
  return 'LostFoundReportDto(id: $id, type: $type, petName: $petName, speciesName: $speciesName, breedName: $breedName, description: $description, lastSeenAddress: $lastSeenAddress, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, status: $status, createdAt: $createdAt, reporterName: $reporterName, reporterPhone: $reporterPhone, petId: $petId, isOwner: $isOwner, reward: $reward)';
}


}

/// @nodoc
abstract mixin class $LostFoundReportDtoCopyWith<$Res>  {
  factory $LostFoundReportDtoCopyWith(LostFoundReportDto value, $Res Function(LostFoundReportDto) _then) = _$LostFoundReportDtoCopyWithImpl;
@useResult
$Res call({
 int id, ReportTypeJson type, String petName, String speciesName, String? breedName, String description, String lastSeenAddress, double latitude, double longitude, String? imageUrl, ReportStatusJson status, DateTime? createdAt, String? reporterName, String? reporterPhone, int? petId, bool isOwner, int? reward
});




}
/// @nodoc
class _$LostFoundReportDtoCopyWithImpl<$Res>
    implements $LostFoundReportDtoCopyWith<$Res> {
  _$LostFoundReportDtoCopyWithImpl(this._self, this._then);

  final LostFoundReportDto _self;
  final $Res Function(LostFoundReportDto) _then;

/// Create a copy of LostFoundReportDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? petName = null,Object? speciesName = null,Object? breedName = freezed,Object? description = null,Object? lastSeenAddress = null,Object? latitude = null,Object? longitude = null,Object? imageUrl = freezed,Object? status = null,Object? createdAt = freezed,Object? reporterName = freezed,Object? reporterPhone = freezed,Object? petId = freezed,Object? isOwner = null,Object? reward = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReportTypeJson,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,speciesName: null == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String,breedName: freezed == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,lastSeenAddress: null == lastSeenAddress ? _self.lastSeenAddress : lastSeenAddress // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportStatusJson,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reporterName: freezed == reporterName ? _self.reporterName : reporterName // ignore: cast_nullable_to_non_nullable
as String?,reporterPhone: freezed == reporterPhone ? _self.reporterPhone : reporterPhone // ignore: cast_nullable_to_non_nullable
as String?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,reward: freezed == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [LostFoundReportDto].
extension LostFoundReportDtoPatterns on LostFoundReportDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LostFoundReportDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LostFoundReportDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LostFoundReportDto value)  $default,){
final _that = this;
switch (_that) {
case _LostFoundReportDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LostFoundReportDto value)?  $default,){
final _that = this;
switch (_that) {
case _LostFoundReportDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  ReportTypeJson type,  String petName,  String speciesName,  String? breedName,  String description,  String lastSeenAddress,  double latitude,  double longitude,  String? imageUrl,  ReportStatusJson status,  DateTime? createdAt,  String? reporterName,  String? reporterPhone,  int? petId,  bool isOwner,  int? reward)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LostFoundReportDto() when $default != null:
return $default(_that.id,_that.type,_that.petName,_that.speciesName,_that.breedName,_that.description,_that.lastSeenAddress,_that.latitude,_that.longitude,_that.imageUrl,_that.status,_that.createdAt,_that.reporterName,_that.reporterPhone,_that.petId,_that.isOwner,_that.reward);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  ReportTypeJson type,  String petName,  String speciesName,  String? breedName,  String description,  String lastSeenAddress,  double latitude,  double longitude,  String? imageUrl,  ReportStatusJson status,  DateTime? createdAt,  String? reporterName,  String? reporterPhone,  int? petId,  bool isOwner,  int? reward)  $default,) {final _that = this;
switch (_that) {
case _LostFoundReportDto():
return $default(_that.id,_that.type,_that.petName,_that.speciesName,_that.breedName,_that.description,_that.lastSeenAddress,_that.latitude,_that.longitude,_that.imageUrl,_that.status,_that.createdAt,_that.reporterName,_that.reporterPhone,_that.petId,_that.isOwner,_that.reward);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  ReportTypeJson type,  String petName,  String speciesName,  String? breedName,  String description,  String lastSeenAddress,  double latitude,  double longitude,  String? imageUrl,  ReportStatusJson status,  DateTime? createdAt,  String? reporterName,  String? reporterPhone,  int? petId,  bool isOwner,  int? reward)?  $default,) {final _that = this;
switch (_that) {
case _LostFoundReportDto() when $default != null:
return $default(_that.id,_that.type,_that.petName,_that.speciesName,_that.breedName,_that.description,_that.lastSeenAddress,_that.latitude,_that.longitude,_that.imageUrl,_that.status,_that.createdAt,_that.reporterName,_that.reporterPhone,_that.petId,_that.isOwner,_that.reward);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LostFoundReportDto extends LostFoundReportDto {
  const _LostFoundReportDto({required this.id, this.type = ReportTypeJson.lost, this.petName = '', this.speciesName = '', this.breedName, this.description = '', this.lastSeenAddress = '', this.latitude = 0, this.longitude = 0, this.imageUrl, this.status = ReportStatusJson.active, this.createdAt, this.reporterName, this.reporterPhone, this.petId, this.isOwner = false, this.reward}): super._();
  factory _LostFoundReportDto.fromJson(Map<String, dynamic> json) => _$LostFoundReportDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  ReportTypeJson type;
@override@JsonKey() final  String petName;
@override@JsonKey() final  String speciesName;
@override final  String? breedName;
@override@JsonKey() final  String description;
@override@JsonKey() final  String lastSeenAddress;
@override@JsonKey() final  double latitude;
@override@JsonKey() final  double longitude;
@override final  String? imageUrl;
@override@JsonKey() final  ReportStatusJson status;
@override final  DateTime? createdAt;
@override final  String? reporterName;
@override final  String? reporterPhone;
// The linked pet, when the report references one of the user's pets.
@override final  int? petId;
// True when the current user owns this report (can edit/delete it).
@override@JsonKey() final  bool isOwner;
// Reward offered for a Lost pet (0–999); null when none / Found.
@override final  int? reward;

/// Create a copy of LostFoundReportDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LostFoundReportDtoCopyWith<_LostFoundReportDto> get copyWith => __$LostFoundReportDtoCopyWithImpl<_LostFoundReportDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LostFoundReportDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LostFoundReportDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.speciesName, speciesName) || other.speciesName == speciesName)&&(identical(other.breedName, breedName) || other.breedName == breedName)&&(identical(other.description, description) || other.description == description)&&(identical(other.lastSeenAddress, lastSeenAddress) || other.lastSeenAddress == lastSeenAddress)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reporterName, reporterName) || other.reporterName == reporterName)&&(identical(other.reporterPhone, reporterPhone) || other.reporterPhone == reporterPhone)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner)&&(identical(other.reward, reward) || other.reward == reward));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,petName,speciesName,breedName,description,lastSeenAddress,latitude,longitude,imageUrl,status,createdAt,reporterName,reporterPhone,petId,isOwner,reward);

@override
String toString() {
  return 'LostFoundReportDto(id: $id, type: $type, petName: $petName, speciesName: $speciesName, breedName: $breedName, description: $description, lastSeenAddress: $lastSeenAddress, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, status: $status, createdAt: $createdAt, reporterName: $reporterName, reporterPhone: $reporterPhone, petId: $petId, isOwner: $isOwner, reward: $reward)';
}


}

/// @nodoc
abstract mixin class _$LostFoundReportDtoCopyWith<$Res> implements $LostFoundReportDtoCopyWith<$Res> {
  factory _$LostFoundReportDtoCopyWith(_LostFoundReportDto value, $Res Function(_LostFoundReportDto) _then) = __$LostFoundReportDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, ReportTypeJson type, String petName, String speciesName, String? breedName, String description, String lastSeenAddress, double latitude, double longitude, String? imageUrl, ReportStatusJson status, DateTime? createdAt, String? reporterName, String? reporterPhone, int? petId, bool isOwner, int? reward
});




}
/// @nodoc
class __$LostFoundReportDtoCopyWithImpl<$Res>
    implements _$LostFoundReportDtoCopyWith<$Res> {
  __$LostFoundReportDtoCopyWithImpl(this._self, this._then);

  final _LostFoundReportDto _self;
  final $Res Function(_LostFoundReportDto) _then;

/// Create a copy of LostFoundReportDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? petName = null,Object? speciesName = null,Object? breedName = freezed,Object? description = null,Object? lastSeenAddress = null,Object? latitude = null,Object? longitude = null,Object? imageUrl = freezed,Object? status = null,Object? createdAt = freezed,Object? reporterName = freezed,Object? reporterPhone = freezed,Object? petId = freezed,Object? isOwner = null,Object? reward = freezed,}) {
  return _then(_LostFoundReportDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReportTypeJson,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,speciesName: null == speciesName ? _self.speciesName : speciesName // ignore: cast_nullable_to_non_nullable
as String,breedName: freezed == breedName ? _self.breedName : breedName // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,lastSeenAddress: null == lastSeenAddress ? _self.lastSeenAddress : lastSeenAddress // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportStatusJson,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reporterName: freezed == reporterName ? _self.reporterName : reporterName // ignore: cast_nullable_to_non_nullable
as String?,reporterPhone: freezed == reporterPhone ? _self.reporterPhone : reporterPhone // ignore: cast_nullable_to_non_nullable
as String?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,reward: freezed == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
