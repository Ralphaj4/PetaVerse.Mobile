// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_provider_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceProviderDetailDto {

 int get id; String get name; String? get description; String? get photoUrl; bool get isVerified; double get rating; int get reviewCount; List<int> get categoryIds; int get primaryCategoryId; List<int> get serviceIds; List<int> get supportedSpecies; bool get servesAllSpecies; List<ProviderSpecializationDto> get specializations; List<ProviderBranchDto> get branches; List<ProviderHoursDto> get hours; bool get isOpen; String? get hoursLabel; List<String> get badges; int? get myStars;
/// Create a copy of ServiceProviderDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceProviderDetailDtoCopyWith<ServiceProviderDetailDto> get copyWith => _$ServiceProviderDetailDtoCopyWithImpl<ServiceProviderDetailDto>(this as ServiceProviderDetailDto, _$identity);

  /// Serializes this ServiceProviderDetailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceProviderDetailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&(identical(other.primaryCategoryId, primaryCategoryId) || other.primaryCategoryId == primaryCategoryId)&&const DeepCollectionEquality().equals(other.serviceIds, serviceIds)&&const DeepCollectionEquality().equals(other.supportedSpecies, supportedSpecies)&&(identical(other.servesAllSpecies, servesAllSpecies) || other.servesAllSpecies == servesAllSpecies)&&const DeepCollectionEquality().equals(other.specializations, specializations)&&const DeepCollectionEquality().equals(other.branches, branches)&&const DeepCollectionEquality().equals(other.hours, hours)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.hoursLabel, hoursLabel) || other.hoursLabel == hoursLabel)&&const DeepCollectionEquality().equals(other.badges, badges)&&(identical(other.myStars, myStars) || other.myStars == myStars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,photoUrl,isVerified,rating,reviewCount,const DeepCollectionEquality().hash(categoryIds),primaryCategoryId,const DeepCollectionEquality().hash(serviceIds),const DeepCollectionEquality().hash(supportedSpecies),servesAllSpecies,const DeepCollectionEquality().hash(specializations),const DeepCollectionEquality().hash(branches),const DeepCollectionEquality().hash(hours),isOpen,hoursLabel,const DeepCollectionEquality().hash(badges),myStars]);

@override
String toString() {
  return 'ServiceProviderDetailDto(id: $id, name: $name, description: $description, photoUrl: $photoUrl, isVerified: $isVerified, rating: $rating, reviewCount: $reviewCount, categoryIds: $categoryIds, primaryCategoryId: $primaryCategoryId, serviceIds: $serviceIds, supportedSpecies: $supportedSpecies, servesAllSpecies: $servesAllSpecies, specializations: $specializations, branches: $branches, hours: $hours, isOpen: $isOpen, hoursLabel: $hoursLabel, badges: $badges, myStars: $myStars)';
}


}

/// @nodoc
abstract mixin class $ServiceProviderDetailDtoCopyWith<$Res>  {
  factory $ServiceProviderDetailDtoCopyWith(ServiceProviderDetailDto value, $Res Function(ServiceProviderDetailDto) _then) = _$ServiceProviderDetailDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, String? photoUrl, bool isVerified, double rating, int reviewCount, List<int> categoryIds, int primaryCategoryId, List<int> serviceIds, List<int> supportedSpecies, bool servesAllSpecies, List<ProviderSpecializationDto> specializations, List<ProviderBranchDto> branches, List<ProviderHoursDto> hours, bool isOpen, String? hoursLabel, List<String> badges, int? myStars
});




}
/// @nodoc
class _$ServiceProviderDetailDtoCopyWithImpl<$Res>
    implements $ServiceProviderDetailDtoCopyWith<$Res> {
  _$ServiceProviderDetailDtoCopyWithImpl(this._self, this._then);

  final ServiceProviderDetailDto _self;
  final $Res Function(ServiceProviderDetailDto) _then;

/// Create a copy of ServiceProviderDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? photoUrl = freezed,Object? isVerified = null,Object? rating = null,Object? reviewCount = null,Object? categoryIds = null,Object? primaryCategoryId = null,Object? serviceIds = null,Object? supportedSpecies = null,Object? servesAllSpecies = null,Object? specializations = null,Object? branches = null,Object? hours = null,Object? isOpen = null,Object? hoursLabel = freezed,Object? badges = null,Object? myStars = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<int>,primaryCategoryId: null == primaryCategoryId ? _self.primaryCategoryId : primaryCategoryId // ignore: cast_nullable_to_non_nullable
as int,serviceIds: null == serviceIds ? _self.serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<int>,supportedSpecies: null == supportedSpecies ? _self.supportedSpecies : supportedSpecies // ignore: cast_nullable_to_non_nullable
as List<int>,servesAllSpecies: null == servesAllSpecies ? _self.servesAllSpecies : servesAllSpecies // ignore: cast_nullable_to_non_nullable
as bool,specializations: null == specializations ? _self.specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<ProviderSpecializationDto>,branches: null == branches ? _self.branches : branches // ignore: cast_nullable_to_non_nullable
as List<ProviderBranchDto>,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as List<ProviderHoursDto>,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,hoursLabel: freezed == hoursLabel ? _self.hoursLabel : hoursLabel // ignore: cast_nullable_to_non_nullable
as String?,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,myStars: freezed == myStars ? _self.myStars : myStars // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceProviderDetailDto].
extension ServiceProviderDetailDtoPatterns on ServiceProviderDetailDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceProviderDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceProviderDetailDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceProviderDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _ServiceProviderDetailDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceProviderDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceProviderDetailDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  String? photoUrl,  bool isVerified,  double rating,  int reviewCount,  List<int> categoryIds,  int primaryCategoryId,  List<int> serviceIds,  List<int> supportedSpecies,  bool servesAllSpecies,  List<ProviderSpecializationDto> specializations,  List<ProviderBranchDto> branches,  List<ProviderHoursDto> hours,  bool isOpen,  String? hoursLabel,  List<String> badges,  int? myStars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceProviderDetailDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.photoUrl,_that.isVerified,_that.rating,_that.reviewCount,_that.categoryIds,_that.primaryCategoryId,_that.serviceIds,_that.supportedSpecies,_that.servesAllSpecies,_that.specializations,_that.branches,_that.hours,_that.isOpen,_that.hoursLabel,_that.badges,_that.myStars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  String? photoUrl,  bool isVerified,  double rating,  int reviewCount,  List<int> categoryIds,  int primaryCategoryId,  List<int> serviceIds,  List<int> supportedSpecies,  bool servesAllSpecies,  List<ProviderSpecializationDto> specializations,  List<ProviderBranchDto> branches,  List<ProviderHoursDto> hours,  bool isOpen,  String? hoursLabel,  List<String> badges,  int? myStars)  $default,) {final _that = this;
switch (_that) {
case _ServiceProviderDetailDto():
return $default(_that.id,_that.name,_that.description,_that.photoUrl,_that.isVerified,_that.rating,_that.reviewCount,_that.categoryIds,_that.primaryCategoryId,_that.serviceIds,_that.supportedSpecies,_that.servesAllSpecies,_that.specializations,_that.branches,_that.hours,_that.isOpen,_that.hoursLabel,_that.badges,_that.myStars);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  String? photoUrl,  bool isVerified,  double rating,  int reviewCount,  List<int> categoryIds,  int primaryCategoryId,  List<int> serviceIds,  List<int> supportedSpecies,  bool servesAllSpecies,  List<ProviderSpecializationDto> specializations,  List<ProviderBranchDto> branches,  List<ProviderHoursDto> hours,  bool isOpen,  String? hoursLabel,  List<String> badges,  int? myStars)?  $default,) {final _that = this;
switch (_that) {
case _ServiceProviderDetailDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.photoUrl,_that.isVerified,_that.rating,_that.reviewCount,_that.categoryIds,_that.primaryCategoryId,_that.serviceIds,_that.supportedSpecies,_that.servesAllSpecies,_that.specializations,_that.branches,_that.hours,_that.isOpen,_that.hoursLabel,_that.badges,_that.myStars);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceProviderDetailDto extends ServiceProviderDetailDto {
  const _ServiceProviderDetailDto({required this.id, this.name = '', this.description, this.photoUrl, this.isVerified = false, this.rating = 0, this.reviewCount = 0, final  List<int> categoryIds = const <int>[], this.primaryCategoryId = 0, final  List<int> serviceIds = const <int>[], final  List<int> supportedSpecies = const <int>[], this.servesAllSpecies = false, final  List<ProviderSpecializationDto> specializations = const <ProviderSpecializationDto>[], final  List<ProviderBranchDto> branches = const <ProviderBranchDto>[], final  List<ProviderHoursDto> hours = const <ProviderHoursDto>[], this.isOpen = false, this.hoursLabel, final  List<String> badges = const <String>[], this.myStars}): _categoryIds = categoryIds,_serviceIds = serviceIds,_supportedSpecies = supportedSpecies,_specializations = specializations,_branches = branches,_hours = hours,_badges = badges,super._();
  factory _ServiceProviderDetailDto.fromJson(Map<String, dynamic> json) => _$ServiceProviderDetailDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? description;
@override final  String? photoUrl;
@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
 final  List<int> _categoryIds;
@override@JsonKey() List<int> get categoryIds {
  if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryIds);
}

@override@JsonKey() final  int primaryCategoryId;
 final  List<int> _serviceIds;
@override@JsonKey() List<int> get serviceIds {
  if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceIds);
}

 final  List<int> _supportedSpecies;
@override@JsonKey() List<int> get supportedSpecies {
  if (_supportedSpecies is EqualUnmodifiableListView) return _supportedSpecies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportedSpecies);
}

@override@JsonKey() final  bool servesAllSpecies;
 final  List<ProviderSpecializationDto> _specializations;
@override@JsonKey() List<ProviderSpecializationDto> get specializations {
  if (_specializations is EqualUnmodifiableListView) return _specializations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specializations);
}

 final  List<ProviderBranchDto> _branches;
@override@JsonKey() List<ProviderBranchDto> get branches {
  if (_branches is EqualUnmodifiableListView) return _branches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_branches);
}

 final  List<ProviderHoursDto> _hours;
@override@JsonKey() List<ProviderHoursDto> get hours {
  if (_hours is EqualUnmodifiableListView) return _hours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hours);
}

@override@JsonKey() final  bool isOpen;
@override final  String? hoursLabel;
 final  List<String> _badges;
@override@JsonKey() List<String> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

@override final  int? myStars;

/// Create a copy of ServiceProviderDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceProviderDetailDtoCopyWith<_ServiceProviderDetailDto> get copyWith => __$ServiceProviderDetailDtoCopyWithImpl<_ServiceProviderDetailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceProviderDetailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceProviderDetailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&(identical(other.primaryCategoryId, primaryCategoryId) || other.primaryCategoryId == primaryCategoryId)&&const DeepCollectionEquality().equals(other._serviceIds, _serviceIds)&&const DeepCollectionEquality().equals(other._supportedSpecies, _supportedSpecies)&&(identical(other.servesAllSpecies, servesAllSpecies) || other.servesAllSpecies == servesAllSpecies)&&const DeepCollectionEquality().equals(other._specializations, _specializations)&&const DeepCollectionEquality().equals(other._branches, _branches)&&const DeepCollectionEquality().equals(other._hours, _hours)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.hoursLabel, hoursLabel) || other.hoursLabel == hoursLabel)&&const DeepCollectionEquality().equals(other._badges, _badges)&&(identical(other.myStars, myStars) || other.myStars == myStars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,photoUrl,isVerified,rating,reviewCount,const DeepCollectionEquality().hash(_categoryIds),primaryCategoryId,const DeepCollectionEquality().hash(_serviceIds),const DeepCollectionEquality().hash(_supportedSpecies),servesAllSpecies,const DeepCollectionEquality().hash(_specializations),const DeepCollectionEquality().hash(_branches),const DeepCollectionEquality().hash(_hours),isOpen,hoursLabel,const DeepCollectionEquality().hash(_badges),myStars]);

@override
String toString() {
  return 'ServiceProviderDetailDto(id: $id, name: $name, description: $description, photoUrl: $photoUrl, isVerified: $isVerified, rating: $rating, reviewCount: $reviewCount, categoryIds: $categoryIds, primaryCategoryId: $primaryCategoryId, serviceIds: $serviceIds, supportedSpecies: $supportedSpecies, servesAllSpecies: $servesAllSpecies, specializations: $specializations, branches: $branches, hours: $hours, isOpen: $isOpen, hoursLabel: $hoursLabel, badges: $badges, myStars: $myStars)';
}


}

/// @nodoc
abstract mixin class _$ServiceProviderDetailDtoCopyWith<$Res> implements $ServiceProviderDetailDtoCopyWith<$Res> {
  factory _$ServiceProviderDetailDtoCopyWith(_ServiceProviderDetailDto value, $Res Function(_ServiceProviderDetailDto) _then) = __$ServiceProviderDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, String? photoUrl, bool isVerified, double rating, int reviewCount, List<int> categoryIds, int primaryCategoryId, List<int> serviceIds, List<int> supportedSpecies, bool servesAllSpecies, List<ProviderSpecializationDto> specializations, List<ProviderBranchDto> branches, List<ProviderHoursDto> hours, bool isOpen, String? hoursLabel, List<String> badges, int? myStars
});




}
/// @nodoc
class __$ServiceProviderDetailDtoCopyWithImpl<$Res>
    implements _$ServiceProviderDetailDtoCopyWith<$Res> {
  __$ServiceProviderDetailDtoCopyWithImpl(this._self, this._then);

  final _ServiceProviderDetailDto _self;
  final $Res Function(_ServiceProviderDetailDto) _then;

/// Create a copy of ServiceProviderDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? photoUrl = freezed,Object? isVerified = null,Object? rating = null,Object? reviewCount = null,Object? categoryIds = null,Object? primaryCategoryId = null,Object? serviceIds = null,Object? supportedSpecies = null,Object? servesAllSpecies = null,Object? specializations = null,Object? branches = null,Object? hours = null,Object? isOpen = null,Object? hoursLabel = freezed,Object? badges = null,Object? myStars = freezed,}) {
  return _then(_ServiceProviderDetailDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<int>,primaryCategoryId: null == primaryCategoryId ? _self.primaryCategoryId : primaryCategoryId // ignore: cast_nullable_to_non_nullable
as int,serviceIds: null == serviceIds ? _self._serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<int>,supportedSpecies: null == supportedSpecies ? _self._supportedSpecies : supportedSpecies // ignore: cast_nullable_to_non_nullable
as List<int>,servesAllSpecies: null == servesAllSpecies ? _self.servesAllSpecies : servesAllSpecies // ignore: cast_nullable_to_non_nullable
as bool,specializations: null == specializations ? _self._specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<ProviderSpecializationDto>,branches: null == branches ? _self._branches : branches // ignore: cast_nullable_to_non_nullable
as List<ProviderBranchDto>,hours: null == hours ? _self._hours : hours // ignore: cast_nullable_to_non_nullable
as List<ProviderHoursDto>,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,hoursLabel: freezed == hoursLabel ? _self.hoursLabel : hoursLabel // ignore: cast_nullable_to_non_nullable
as String?,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,myStars: freezed == myStars ? _self.myStars : myStars // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ProviderBranchDto {

 int get id; String get address; double get latitude; double get longitude; String? get phone; String? get whatsApp; String? get emergency; String? get website; String? get instagram; String? get email; double? get distanceKm;
/// Create a copy of ProviderBranchDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderBranchDtoCopyWith<ProviderBranchDto> get copyWith => _$ProviderBranchDtoCopyWithImpl<ProviderBranchDto>(this as ProviderBranchDto, _$identity);

  /// Serializes this ProviderBranchDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderBranchDto&&(identical(other.id, id) || other.id == id)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsApp, whatsApp) || other.whatsApp == whatsApp)&&(identical(other.emergency, emergency) || other.emergency == emergency)&&(identical(other.website, website) || other.website == website)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.email, email) || other.email == email)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,address,latitude,longitude,phone,whatsApp,emergency,website,instagram,email,distanceKm);

@override
String toString() {
  return 'ProviderBranchDto(id: $id, address: $address, latitude: $latitude, longitude: $longitude, phone: $phone, whatsApp: $whatsApp, emergency: $emergency, website: $website, instagram: $instagram, email: $email, distanceKm: $distanceKm)';
}


}

/// @nodoc
abstract mixin class $ProviderBranchDtoCopyWith<$Res>  {
  factory $ProviderBranchDtoCopyWith(ProviderBranchDto value, $Res Function(ProviderBranchDto) _then) = _$ProviderBranchDtoCopyWithImpl;
@useResult
$Res call({
 int id, String address, double latitude, double longitude, String? phone, String? whatsApp, String? emergency, String? website, String? instagram, String? email, double? distanceKm
});




}
/// @nodoc
class _$ProviderBranchDtoCopyWithImpl<$Res>
    implements $ProviderBranchDtoCopyWith<$Res> {
  _$ProviderBranchDtoCopyWithImpl(this._self, this._then);

  final ProviderBranchDto _self;
  final $Res Function(ProviderBranchDto) _then;

/// Create a copy of ProviderBranchDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? phone = freezed,Object? whatsApp = freezed,Object? emergency = freezed,Object? website = freezed,Object? instagram = freezed,Object? email = freezed,Object? distanceKm = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,whatsApp: freezed == whatsApp ? _self.whatsApp : whatsApp // ignore: cast_nullable_to_non_nullable
as String?,emergency: freezed == emergency ? _self.emergency : emergency // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderBranchDto].
extension ProviderBranchDtoPatterns on ProviderBranchDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderBranchDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderBranchDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderBranchDto value)  $default,){
final _that = this;
switch (_that) {
case _ProviderBranchDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderBranchDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderBranchDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String address,  double latitude,  double longitude,  String? phone,  String? whatsApp,  String? emergency,  String? website,  String? instagram,  String? email,  double? distanceKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderBranchDto() when $default != null:
return $default(_that.id,_that.address,_that.latitude,_that.longitude,_that.phone,_that.whatsApp,_that.emergency,_that.website,_that.instagram,_that.email,_that.distanceKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String address,  double latitude,  double longitude,  String? phone,  String? whatsApp,  String? emergency,  String? website,  String? instagram,  String? email,  double? distanceKm)  $default,) {final _that = this;
switch (_that) {
case _ProviderBranchDto():
return $default(_that.id,_that.address,_that.latitude,_that.longitude,_that.phone,_that.whatsApp,_that.emergency,_that.website,_that.instagram,_that.email,_that.distanceKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String address,  double latitude,  double longitude,  String? phone,  String? whatsApp,  String? emergency,  String? website,  String? instagram,  String? email,  double? distanceKm)?  $default,) {final _that = this;
switch (_that) {
case _ProviderBranchDto() when $default != null:
return $default(_that.id,_that.address,_that.latitude,_that.longitude,_that.phone,_that.whatsApp,_that.emergency,_that.website,_that.instagram,_that.email,_that.distanceKm);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderBranchDto extends ProviderBranchDto {
  const _ProviderBranchDto({required this.id, this.address = '', this.latitude = 0, this.longitude = 0, this.phone, this.whatsApp, this.emergency, this.website, this.instagram, this.email, this.distanceKm}): super._();
  factory _ProviderBranchDto.fromJson(Map<String, dynamic> json) => _$ProviderBranchDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String address;
@override@JsonKey() final  double latitude;
@override@JsonKey() final  double longitude;
@override final  String? phone;
@override final  String? whatsApp;
@override final  String? emergency;
@override final  String? website;
@override final  String? instagram;
@override final  String? email;
@override final  double? distanceKm;

/// Create a copy of ProviderBranchDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderBranchDtoCopyWith<_ProviderBranchDto> get copyWith => __$ProviderBranchDtoCopyWithImpl<_ProviderBranchDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderBranchDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderBranchDto&&(identical(other.id, id) || other.id == id)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsApp, whatsApp) || other.whatsApp == whatsApp)&&(identical(other.emergency, emergency) || other.emergency == emergency)&&(identical(other.website, website) || other.website == website)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.email, email) || other.email == email)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,address,latitude,longitude,phone,whatsApp,emergency,website,instagram,email,distanceKm);

@override
String toString() {
  return 'ProviderBranchDto(id: $id, address: $address, latitude: $latitude, longitude: $longitude, phone: $phone, whatsApp: $whatsApp, emergency: $emergency, website: $website, instagram: $instagram, email: $email, distanceKm: $distanceKm)';
}


}

/// @nodoc
abstract mixin class _$ProviderBranchDtoCopyWith<$Res> implements $ProviderBranchDtoCopyWith<$Res> {
  factory _$ProviderBranchDtoCopyWith(_ProviderBranchDto value, $Res Function(_ProviderBranchDto) _then) = __$ProviderBranchDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String address, double latitude, double longitude, String? phone, String? whatsApp, String? emergency, String? website, String? instagram, String? email, double? distanceKm
});




}
/// @nodoc
class __$ProviderBranchDtoCopyWithImpl<$Res>
    implements _$ProviderBranchDtoCopyWith<$Res> {
  __$ProviderBranchDtoCopyWithImpl(this._self, this._then);

  final _ProviderBranchDto _self;
  final $Res Function(_ProviderBranchDto) _then;

/// Create a copy of ProviderBranchDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? phone = freezed,Object? whatsApp = freezed,Object? emergency = freezed,Object? website = freezed,Object? instagram = freezed,Object? email = freezed,Object? distanceKm = freezed,}) {
  return _then(_ProviderBranchDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,whatsApp: freezed == whatsApp ? _self.whatsApp : whatsApp // ignore: cast_nullable_to_non_nullable
as String?,emergency: freezed == emergency ? _self.emergency : emergency // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$ProviderHoursDto {

 int get dayOfWeek; String get startTime; String get endTime;
/// Create a copy of ProviderHoursDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderHoursDtoCopyWith<ProviderHoursDto> get copyWith => _$ProviderHoursDtoCopyWithImpl<ProviderHoursDto>(this as ProviderHoursDto, _$identity);

  /// Serializes this ProviderHoursDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderHoursDto&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,startTime,endTime);

@override
String toString() {
  return 'ProviderHoursDto(dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $ProviderHoursDtoCopyWith<$Res>  {
  factory $ProviderHoursDtoCopyWith(ProviderHoursDto value, $Res Function(ProviderHoursDto) _then) = _$ProviderHoursDtoCopyWithImpl;
@useResult
$Res call({
 int dayOfWeek, String startTime, String endTime
});




}
/// @nodoc
class _$ProviderHoursDtoCopyWithImpl<$Res>
    implements $ProviderHoursDtoCopyWith<$Res> {
  _$ProviderHoursDtoCopyWithImpl(this._self, this._then);

  final ProviderHoursDto _self;
  final $Res Function(ProviderHoursDto) _then;

/// Create a copy of ProviderHoursDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_self.copyWith(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderHoursDto].
extension ProviderHoursDtoPatterns on ProviderHoursDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderHoursDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderHoursDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderHoursDto value)  $default,){
final _that = this;
switch (_that) {
case _ProviderHoursDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderHoursDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderHoursDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dayOfWeek,  String startTime,  String endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderHoursDto() when $default != null:
return $default(_that.dayOfWeek,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dayOfWeek,  String startTime,  String endTime)  $default,) {final _that = this;
switch (_that) {
case _ProviderHoursDto():
return $default(_that.dayOfWeek,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dayOfWeek,  String startTime,  String endTime)?  $default,) {final _that = this;
switch (_that) {
case _ProviderHoursDto() when $default != null:
return $default(_that.dayOfWeek,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderHoursDto extends ProviderHoursDto {
  const _ProviderHoursDto({this.dayOfWeek = 0, this.startTime = '', this.endTime = ''}): super._();
  factory _ProviderHoursDto.fromJson(Map<String, dynamic> json) => _$ProviderHoursDtoFromJson(json);

@override@JsonKey() final  int dayOfWeek;
@override@JsonKey() final  String startTime;
@override@JsonKey() final  String endTime;

/// Create a copy of ProviderHoursDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderHoursDtoCopyWith<_ProviderHoursDto> get copyWith => __$ProviderHoursDtoCopyWithImpl<_ProviderHoursDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderHoursDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderHoursDto&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,startTime,endTime);

@override
String toString() {
  return 'ProviderHoursDto(dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$ProviderHoursDtoCopyWith<$Res> implements $ProviderHoursDtoCopyWith<$Res> {
  factory _$ProviderHoursDtoCopyWith(_ProviderHoursDto value, $Res Function(_ProviderHoursDto) _then) = __$ProviderHoursDtoCopyWithImpl;
@override @useResult
$Res call({
 int dayOfWeek, String startTime, String endTime
});




}
/// @nodoc
class __$ProviderHoursDtoCopyWithImpl<$Res>
    implements _$ProviderHoursDtoCopyWith<$Res> {
  __$ProviderHoursDtoCopyWithImpl(this._self, this._then);

  final _ProviderHoursDto _self;
  final $Res Function(_ProviderHoursDto) _then;

/// Create a copy of ProviderHoursDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,}) {
  return _then(_ProviderHoursDto(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProviderSpecializationDto {

@JsonKey(name: 'specializationId') int get id; String get name; String? get otherName;
/// Create a copy of ProviderSpecializationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderSpecializationDtoCopyWith<ProviderSpecializationDto> get copyWith => _$ProviderSpecializationDtoCopyWithImpl<ProviderSpecializationDto>(this as ProviderSpecializationDto, _$identity);

  /// Serializes this ProviderSpecializationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderSpecializationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.otherName, otherName) || other.otherName == otherName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,otherName);

@override
String toString() {
  return 'ProviderSpecializationDto(id: $id, name: $name, otherName: $otherName)';
}


}

/// @nodoc
abstract mixin class $ProviderSpecializationDtoCopyWith<$Res>  {
  factory $ProviderSpecializationDtoCopyWith(ProviderSpecializationDto value, $Res Function(ProviderSpecializationDto) _then) = _$ProviderSpecializationDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'specializationId') int id, String name, String? otherName
});




}
/// @nodoc
class _$ProviderSpecializationDtoCopyWithImpl<$Res>
    implements $ProviderSpecializationDtoCopyWith<$Res> {
  _$ProviderSpecializationDtoCopyWithImpl(this._self, this._then);

  final ProviderSpecializationDto _self;
  final $Res Function(ProviderSpecializationDto) _then;

/// Create a copy of ProviderSpecializationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? otherName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,otherName: freezed == otherName ? _self.otherName : otherName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderSpecializationDto].
extension ProviderSpecializationDtoPatterns on ProviderSpecializationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderSpecializationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderSpecializationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderSpecializationDto value)  $default,){
final _that = this;
switch (_that) {
case _ProviderSpecializationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderSpecializationDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderSpecializationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'specializationId')  int id,  String name,  String? otherName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderSpecializationDto() when $default != null:
return $default(_that.id,_that.name,_that.otherName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'specializationId')  int id,  String name,  String? otherName)  $default,) {final _that = this;
switch (_that) {
case _ProviderSpecializationDto():
return $default(_that.id,_that.name,_that.otherName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'specializationId')  int id,  String name,  String? otherName)?  $default,) {final _that = this;
switch (_that) {
case _ProviderSpecializationDto() when $default != null:
return $default(_that.id,_that.name,_that.otherName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderSpecializationDto extends ProviderSpecializationDto {
  const _ProviderSpecializationDto({@JsonKey(name: 'specializationId') required this.id, this.name = '', this.otherName}): super._();
  factory _ProviderSpecializationDto.fromJson(Map<String, dynamic> json) => _$ProviderSpecializationDtoFromJson(json);

@override@JsonKey(name: 'specializationId') final  int id;
@override@JsonKey() final  String name;
@override final  String? otherName;

/// Create a copy of ProviderSpecializationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderSpecializationDtoCopyWith<_ProviderSpecializationDto> get copyWith => __$ProviderSpecializationDtoCopyWithImpl<_ProviderSpecializationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderSpecializationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderSpecializationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.otherName, otherName) || other.otherName == otherName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,otherName);

@override
String toString() {
  return 'ProviderSpecializationDto(id: $id, name: $name, otherName: $otherName)';
}


}

/// @nodoc
abstract mixin class _$ProviderSpecializationDtoCopyWith<$Res> implements $ProviderSpecializationDtoCopyWith<$Res> {
  factory _$ProviderSpecializationDtoCopyWith(_ProviderSpecializationDto value, $Res Function(_ProviderSpecializationDto) _then) = __$ProviderSpecializationDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'specializationId') int id, String name, String? otherName
});




}
/// @nodoc
class __$ProviderSpecializationDtoCopyWithImpl<$Res>
    implements _$ProviderSpecializationDtoCopyWith<$Res> {
  __$ProviderSpecializationDtoCopyWithImpl(this._self, this._then);

  final _ProviderSpecializationDto _self;
  final $Res Function(_ProviderSpecializationDto) _then;

/// Create a copy of ProviderSpecializationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? otherName = freezed,}) {
  return _then(_ProviderSpecializationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,otherName: freezed == otherName ? _self.otherName : otherName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProviderRatingDto {

 double get rating; int get reviewCount; int get myStars;
/// Create a copy of ProviderRatingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderRatingDtoCopyWith<ProviderRatingDto> get copyWith => _$ProviderRatingDtoCopyWithImpl<ProviderRatingDto>(this as ProviderRatingDto, _$identity);

  /// Serializes this ProviderRatingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderRatingDto&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.myStars, myStars) || other.myStars == myStars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,reviewCount,myStars);

@override
String toString() {
  return 'ProviderRatingDto(rating: $rating, reviewCount: $reviewCount, myStars: $myStars)';
}


}

/// @nodoc
abstract mixin class $ProviderRatingDtoCopyWith<$Res>  {
  factory $ProviderRatingDtoCopyWith(ProviderRatingDto value, $Res Function(ProviderRatingDto) _then) = _$ProviderRatingDtoCopyWithImpl;
@useResult
$Res call({
 double rating, int reviewCount, int myStars
});




}
/// @nodoc
class _$ProviderRatingDtoCopyWithImpl<$Res>
    implements $ProviderRatingDtoCopyWith<$Res> {
  _$ProviderRatingDtoCopyWithImpl(this._self, this._then);

  final ProviderRatingDto _self;
  final $Res Function(ProviderRatingDto) _then;

/// Create a copy of ProviderRatingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? reviewCount = null,Object? myStars = null,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,myStars: null == myStars ? _self.myStars : myStars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderRatingDto].
extension ProviderRatingDtoPatterns on ProviderRatingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderRatingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderRatingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderRatingDto value)  $default,){
final _that = this;
switch (_that) {
case _ProviderRatingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderRatingDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderRatingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double rating,  int reviewCount,  int myStars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderRatingDto() when $default != null:
return $default(_that.rating,_that.reviewCount,_that.myStars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double rating,  int reviewCount,  int myStars)  $default,) {final _that = this;
switch (_that) {
case _ProviderRatingDto():
return $default(_that.rating,_that.reviewCount,_that.myStars);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double rating,  int reviewCount,  int myStars)?  $default,) {final _that = this;
switch (_that) {
case _ProviderRatingDto() when $default != null:
return $default(_that.rating,_that.reviewCount,_that.myStars);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProviderRatingDto extends ProviderRatingDto {
  const _ProviderRatingDto({this.rating = 0, this.reviewCount = 0, this.myStars = 0}): super._();
  factory _ProviderRatingDto.fromJson(Map<String, dynamic> json) => _$ProviderRatingDtoFromJson(json);

@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
@override@JsonKey() final  int myStars;

/// Create a copy of ProviderRatingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderRatingDtoCopyWith<_ProviderRatingDto> get copyWith => __$ProviderRatingDtoCopyWithImpl<_ProviderRatingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProviderRatingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderRatingDto&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.myStars, myStars) || other.myStars == myStars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,reviewCount,myStars);

@override
String toString() {
  return 'ProviderRatingDto(rating: $rating, reviewCount: $reviewCount, myStars: $myStars)';
}


}

/// @nodoc
abstract mixin class _$ProviderRatingDtoCopyWith<$Res> implements $ProviderRatingDtoCopyWith<$Res> {
  factory _$ProviderRatingDtoCopyWith(_ProviderRatingDto value, $Res Function(_ProviderRatingDto) _then) = __$ProviderRatingDtoCopyWithImpl;
@override @useResult
$Res call({
 double rating, int reviewCount, int myStars
});




}
/// @nodoc
class __$ProviderRatingDtoCopyWithImpl<$Res>
    implements _$ProviderRatingDtoCopyWith<$Res> {
  __$ProviderRatingDtoCopyWithImpl(this._self, this._then);

  final _ProviderRatingDto _self;
  final $Res Function(_ProviderRatingDto) _then;

/// Create a copy of ProviderRatingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? reviewCount = null,Object? myStars = null,}) {
  return _then(_ProviderRatingDto(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,myStars: null == myStars ? _self.myStars : myStars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
