// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_provider_search_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceProviderSearchDto {

 List<ServiceProviderItemDto> get items; int get totalInViewport; bool get hasMore; bool get tooZoomedOut;
/// Create a copy of ServiceProviderSearchDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceProviderSearchDtoCopyWith<ServiceProviderSearchDto> get copyWith => _$ServiceProviderSearchDtoCopyWithImpl<ServiceProviderSearchDto>(this as ServiceProviderSearchDto, _$identity);

  /// Serializes this ServiceProviderSearchDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceProviderSearchDto&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalInViewport, totalInViewport) || other.totalInViewport == totalInViewport)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.tooZoomedOut, tooZoomedOut) || other.tooZoomedOut == tooZoomedOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalInViewport,hasMore,tooZoomedOut);

@override
String toString() {
  return 'ServiceProviderSearchDto(items: $items, totalInViewport: $totalInViewport, hasMore: $hasMore, tooZoomedOut: $tooZoomedOut)';
}


}

/// @nodoc
abstract mixin class $ServiceProviderSearchDtoCopyWith<$Res>  {
  factory $ServiceProviderSearchDtoCopyWith(ServiceProviderSearchDto value, $Res Function(ServiceProviderSearchDto) _then) = _$ServiceProviderSearchDtoCopyWithImpl;
@useResult
$Res call({
 List<ServiceProviderItemDto> items, int totalInViewport, bool hasMore, bool tooZoomedOut
});




}
/// @nodoc
class _$ServiceProviderSearchDtoCopyWithImpl<$Res>
    implements $ServiceProviderSearchDtoCopyWith<$Res> {
  _$ServiceProviderSearchDtoCopyWithImpl(this._self, this._then);

  final ServiceProviderSearchDto _self;
  final $Res Function(ServiceProviderSearchDto) _then;

/// Create a copy of ServiceProviderSearchDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalInViewport = null,Object? hasMore = null,Object? tooZoomedOut = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ServiceProviderItemDto>,totalInViewport: null == totalInViewport ? _self.totalInViewport : totalInViewport // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,tooZoomedOut: null == tooZoomedOut ? _self.tooZoomedOut : tooZoomedOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceProviderSearchDto].
extension ServiceProviderSearchDtoPatterns on ServiceProviderSearchDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceProviderSearchDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceProviderSearchDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceProviderSearchDto value)  $default,){
final _that = this;
switch (_that) {
case _ServiceProviderSearchDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceProviderSearchDto value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceProviderSearchDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ServiceProviderItemDto> items,  int totalInViewport,  bool hasMore,  bool tooZoomedOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceProviderSearchDto() when $default != null:
return $default(_that.items,_that.totalInViewport,_that.hasMore,_that.tooZoomedOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ServiceProviderItemDto> items,  int totalInViewport,  bool hasMore,  bool tooZoomedOut)  $default,) {final _that = this;
switch (_that) {
case _ServiceProviderSearchDto():
return $default(_that.items,_that.totalInViewport,_that.hasMore,_that.tooZoomedOut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ServiceProviderItemDto> items,  int totalInViewport,  bool hasMore,  bool tooZoomedOut)?  $default,) {final _that = this;
switch (_that) {
case _ServiceProviderSearchDto() when $default != null:
return $default(_that.items,_that.totalInViewport,_that.hasMore,_that.tooZoomedOut);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceProviderSearchDto extends ServiceProviderSearchDto {
  const _ServiceProviderSearchDto({final  List<ServiceProviderItemDto> items = const <ServiceProviderItemDto>[], this.totalInViewport = 0, this.hasMore = false, this.tooZoomedOut = false}): _items = items,super._();
  factory _ServiceProviderSearchDto.fromJson(Map<String, dynamic> json) => _$ServiceProviderSearchDtoFromJson(json);

 final  List<ServiceProviderItemDto> _items;
@override@JsonKey() List<ServiceProviderItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int totalInViewport;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool tooZoomedOut;

/// Create a copy of ServiceProviderSearchDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceProviderSearchDtoCopyWith<_ServiceProviderSearchDto> get copyWith => __$ServiceProviderSearchDtoCopyWithImpl<_ServiceProviderSearchDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceProviderSearchDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceProviderSearchDto&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalInViewport, totalInViewport) || other.totalInViewport == totalInViewport)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.tooZoomedOut, tooZoomedOut) || other.tooZoomedOut == tooZoomedOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalInViewport,hasMore,tooZoomedOut);

@override
String toString() {
  return 'ServiceProviderSearchDto(items: $items, totalInViewport: $totalInViewport, hasMore: $hasMore, tooZoomedOut: $tooZoomedOut)';
}


}

/// @nodoc
abstract mixin class _$ServiceProviderSearchDtoCopyWith<$Res> implements $ServiceProviderSearchDtoCopyWith<$Res> {
  factory _$ServiceProviderSearchDtoCopyWith(_ServiceProviderSearchDto value, $Res Function(_ServiceProviderSearchDto) _then) = __$ServiceProviderSearchDtoCopyWithImpl;
@override @useResult
$Res call({
 List<ServiceProviderItemDto> items, int totalInViewport, bool hasMore, bool tooZoomedOut
});




}
/// @nodoc
class __$ServiceProviderSearchDtoCopyWithImpl<$Res>
    implements _$ServiceProviderSearchDtoCopyWith<$Res> {
  __$ServiceProviderSearchDtoCopyWithImpl(this._self, this._then);

  final _ServiceProviderSearchDto _self;
  final $Res Function(_ServiceProviderSearchDto) _then;

/// Create a copy of ServiceProviderSearchDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalInViewport = null,Object? hasMore = null,Object? tooZoomedOut = null,}) {
  return _then(_ServiceProviderSearchDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ServiceProviderItemDto>,totalInViewport: null == totalInViewport ? _self.totalInViewport : totalInViewport // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,tooZoomedOut: null == tooZoomedOut ? _self.tooZoomedOut : tooZoomedOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ServiceProviderItemDto {

 int get id; int get branchId; String get name; List<int> get categoryIds; int get primaryCategoryId; List<int> get serviceIds; double get latitude; double get longitude; String get address; double get rating; int get reviewCount; bool get isOpen; String? get hoursLabel; String? get photoUrl; String? get phone; double? get distanceKm; List<String> get badges; List<int> get supportedSpecies; bool get servesAllSpecies;
/// Create a copy of ServiceProviderItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceProviderItemDtoCopyWith<ServiceProviderItemDto> get copyWith => _$ServiceProviderItemDtoCopyWithImpl<ServiceProviderItemDto>(this as ServiceProviderItemDto, _$identity);

  /// Serializes this ServiceProviderItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceProviderItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&(identical(other.primaryCategoryId, primaryCategoryId) || other.primaryCategoryId == primaryCategoryId)&&const DeepCollectionEquality().equals(other.serviceIds, serviceIds)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.hoursLabel, hoursLabel) || other.hoursLabel == hoursLabel)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&const DeepCollectionEquality().equals(other.badges, badges)&&const DeepCollectionEquality().equals(other.supportedSpecies, supportedSpecies)&&(identical(other.servesAllSpecies, servesAllSpecies) || other.servesAllSpecies == servesAllSpecies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,branchId,name,const DeepCollectionEquality().hash(categoryIds),primaryCategoryId,const DeepCollectionEquality().hash(serviceIds),latitude,longitude,address,rating,reviewCount,isOpen,hoursLabel,photoUrl,phone,distanceKm,const DeepCollectionEquality().hash(badges),const DeepCollectionEquality().hash(supportedSpecies),servesAllSpecies]);

@override
String toString() {
  return 'ServiceProviderItemDto(id: $id, branchId: $branchId, name: $name, categoryIds: $categoryIds, primaryCategoryId: $primaryCategoryId, serviceIds: $serviceIds, latitude: $latitude, longitude: $longitude, address: $address, rating: $rating, reviewCount: $reviewCount, isOpen: $isOpen, hoursLabel: $hoursLabel, photoUrl: $photoUrl, phone: $phone, distanceKm: $distanceKm, badges: $badges, supportedSpecies: $supportedSpecies, servesAllSpecies: $servesAllSpecies)';
}


}

/// @nodoc
abstract mixin class $ServiceProviderItemDtoCopyWith<$Res>  {
  factory $ServiceProviderItemDtoCopyWith(ServiceProviderItemDto value, $Res Function(ServiceProviderItemDto) _then) = _$ServiceProviderItemDtoCopyWithImpl;
@useResult
$Res call({
 int id, int branchId, String name, List<int> categoryIds, int primaryCategoryId, List<int> serviceIds, double latitude, double longitude, String address, double rating, int reviewCount, bool isOpen, String? hoursLabel, String? photoUrl, String? phone, double? distanceKm, List<String> badges, List<int> supportedSpecies, bool servesAllSpecies
});




}
/// @nodoc
class _$ServiceProviderItemDtoCopyWithImpl<$Res>
    implements $ServiceProviderItemDtoCopyWith<$Res> {
  _$ServiceProviderItemDtoCopyWithImpl(this._self, this._then);

  final ServiceProviderItemDto _self;
  final $Res Function(ServiceProviderItemDto) _then;

/// Create a copy of ServiceProviderItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchId = null,Object? name = null,Object? categoryIds = null,Object? primaryCategoryId = null,Object? serviceIds = null,Object? latitude = null,Object? longitude = null,Object? address = null,Object? rating = null,Object? reviewCount = null,Object? isOpen = null,Object? hoursLabel = freezed,Object? photoUrl = freezed,Object? phone = freezed,Object? distanceKm = freezed,Object? badges = null,Object? supportedSpecies = null,Object? servesAllSpecies = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<int>,primaryCategoryId: null == primaryCategoryId ? _self.primaryCategoryId : primaryCategoryId // ignore: cast_nullable_to_non_nullable
as int,serviceIds: null == serviceIds ? _self.serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<int>,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,hoursLabel: freezed == hoursLabel ? _self.hoursLabel : hoursLabel // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,supportedSpecies: null == supportedSpecies ? _self.supportedSpecies : supportedSpecies // ignore: cast_nullable_to_non_nullable
as List<int>,servesAllSpecies: null == servesAllSpecies ? _self.servesAllSpecies : servesAllSpecies // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceProviderItemDto].
extension ServiceProviderItemDtoPatterns on ServiceProviderItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceProviderItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceProviderItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceProviderItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ServiceProviderItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceProviderItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceProviderItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int branchId,  String name,  List<int> categoryIds,  int primaryCategoryId,  List<int> serviceIds,  double latitude,  double longitude,  String address,  double rating,  int reviewCount,  bool isOpen,  String? hoursLabel,  String? photoUrl,  String? phone,  double? distanceKm,  List<String> badges,  List<int> supportedSpecies,  bool servesAllSpecies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceProviderItemDto() when $default != null:
return $default(_that.id,_that.branchId,_that.name,_that.categoryIds,_that.primaryCategoryId,_that.serviceIds,_that.latitude,_that.longitude,_that.address,_that.rating,_that.reviewCount,_that.isOpen,_that.hoursLabel,_that.photoUrl,_that.phone,_that.distanceKm,_that.badges,_that.supportedSpecies,_that.servesAllSpecies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int branchId,  String name,  List<int> categoryIds,  int primaryCategoryId,  List<int> serviceIds,  double latitude,  double longitude,  String address,  double rating,  int reviewCount,  bool isOpen,  String? hoursLabel,  String? photoUrl,  String? phone,  double? distanceKm,  List<String> badges,  List<int> supportedSpecies,  bool servesAllSpecies)  $default,) {final _that = this;
switch (_that) {
case _ServiceProviderItemDto():
return $default(_that.id,_that.branchId,_that.name,_that.categoryIds,_that.primaryCategoryId,_that.serviceIds,_that.latitude,_that.longitude,_that.address,_that.rating,_that.reviewCount,_that.isOpen,_that.hoursLabel,_that.photoUrl,_that.phone,_that.distanceKm,_that.badges,_that.supportedSpecies,_that.servesAllSpecies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int branchId,  String name,  List<int> categoryIds,  int primaryCategoryId,  List<int> serviceIds,  double latitude,  double longitude,  String address,  double rating,  int reviewCount,  bool isOpen,  String? hoursLabel,  String? photoUrl,  String? phone,  double? distanceKm,  List<String> badges,  List<int> supportedSpecies,  bool servesAllSpecies)?  $default,) {final _that = this;
switch (_that) {
case _ServiceProviderItemDto() when $default != null:
return $default(_that.id,_that.branchId,_that.name,_that.categoryIds,_that.primaryCategoryId,_that.serviceIds,_that.latitude,_that.longitude,_that.address,_that.rating,_that.reviewCount,_that.isOpen,_that.hoursLabel,_that.photoUrl,_that.phone,_that.distanceKm,_that.badges,_that.supportedSpecies,_that.servesAllSpecies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceProviderItemDto extends ServiceProviderItemDto {
  const _ServiceProviderItemDto({required this.id, required this.branchId, this.name = '', final  List<int> categoryIds = const <int>[], this.primaryCategoryId = 0, final  List<int> serviceIds = const <int>[], this.latitude = 0, this.longitude = 0, this.address = '', this.rating = 0, this.reviewCount = 0, this.isOpen = false, this.hoursLabel, this.photoUrl, this.phone, this.distanceKm, final  List<String> badges = const <String>[], final  List<int> supportedSpecies = const <int>[], this.servesAllSpecies = false}): _categoryIds = categoryIds,_serviceIds = serviceIds,_badges = badges,_supportedSpecies = supportedSpecies,super._();
  factory _ServiceProviderItemDto.fromJson(Map<String, dynamic> json) => _$ServiceProviderItemDtoFromJson(json);

@override final  int id;
@override final  int branchId;
@override@JsonKey() final  String name;
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

@override@JsonKey() final  double latitude;
@override@JsonKey() final  double longitude;
@override@JsonKey() final  String address;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
@override@JsonKey() final  bool isOpen;
@override final  String? hoursLabel;
@override final  String? photoUrl;
@override final  String? phone;
@override final  double? distanceKm;
 final  List<String> _badges;
@override@JsonKey() List<String> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

 final  List<int> _supportedSpecies;
@override@JsonKey() List<int> get supportedSpecies {
  if (_supportedSpecies is EqualUnmodifiableListView) return _supportedSpecies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportedSpecies);
}

@override@JsonKey() final  bool servesAllSpecies;

/// Create a copy of ServiceProviderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceProviderItemDtoCopyWith<_ServiceProviderItemDto> get copyWith => __$ServiceProviderItemDtoCopyWithImpl<_ServiceProviderItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceProviderItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceProviderItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&(identical(other.primaryCategoryId, primaryCategoryId) || other.primaryCategoryId == primaryCategoryId)&&const DeepCollectionEquality().equals(other._serviceIds, _serviceIds)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.hoursLabel, hoursLabel) || other.hoursLabel == hoursLabel)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&const DeepCollectionEquality().equals(other._badges, _badges)&&const DeepCollectionEquality().equals(other._supportedSpecies, _supportedSpecies)&&(identical(other.servesAllSpecies, servesAllSpecies) || other.servesAllSpecies == servesAllSpecies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,branchId,name,const DeepCollectionEquality().hash(_categoryIds),primaryCategoryId,const DeepCollectionEquality().hash(_serviceIds),latitude,longitude,address,rating,reviewCount,isOpen,hoursLabel,photoUrl,phone,distanceKm,const DeepCollectionEquality().hash(_badges),const DeepCollectionEquality().hash(_supportedSpecies),servesAllSpecies]);

@override
String toString() {
  return 'ServiceProviderItemDto(id: $id, branchId: $branchId, name: $name, categoryIds: $categoryIds, primaryCategoryId: $primaryCategoryId, serviceIds: $serviceIds, latitude: $latitude, longitude: $longitude, address: $address, rating: $rating, reviewCount: $reviewCount, isOpen: $isOpen, hoursLabel: $hoursLabel, photoUrl: $photoUrl, phone: $phone, distanceKm: $distanceKm, badges: $badges, supportedSpecies: $supportedSpecies, servesAllSpecies: $servesAllSpecies)';
}


}

/// @nodoc
abstract mixin class _$ServiceProviderItemDtoCopyWith<$Res> implements $ServiceProviderItemDtoCopyWith<$Res> {
  factory _$ServiceProviderItemDtoCopyWith(_ServiceProviderItemDto value, $Res Function(_ServiceProviderItemDto) _then) = __$ServiceProviderItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int branchId, String name, List<int> categoryIds, int primaryCategoryId, List<int> serviceIds, double latitude, double longitude, String address, double rating, int reviewCount, bool isOpen, String? hoursLabel, String? photoUrl, String? phone, double? distanceKm, List<String> badges, List<int> supportedSpecies, bool servesAllSpecies
});




}
/// @nodoc
class __$ServiceProviderItemDtoCopyWithImpl<$Res>
    implements _$ServiceProviderItemDtoCopyWith<$Res> {
  __$ServiceProviderItemDtoCopyWithImpl(this._self, this._then);

  final _ServiceProviderItemDto _self;
  final $Res Function(_ServiceProviderItemDto) _then;

/// Create a copy of ServiceProviderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchId = null,Object? name = null,Object? categoryIds = null,Object? primaryCategoryId = null,Object? serviceIds = null,Object? latitude = null,Object? longitude = null,Object? address = null,Object? rating = null,Object? reviewCount = null,Object? isOpen = null,Object? hoursLabel = freezed,Object? photoUrl = freezed,Object? phone = freezed,Object? distanceKm = freezed,Object? badges = null,Object? supportedSpecies = null,Object? servesAllSpecies = null,}) {
  return _then(_ServiceProviderItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<int>,primaryCategoryId: null == primaryCategoryId ? _self.primaryCategoryId : primaryCategoryId // ignore: cast_nullable_to_non_nullable
as int,serviceIds: null == serviceIds ? _self._serviceIds : serviceIds // ignore: cast_nullable_to_non_nullable
as List<int>,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,hoursLabel: freezed == hoursLabel ? _self.hoursLabel : hoursLabel // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,supportedSpecies: null == supportedSpecies ? _self._supportedSpecies : supportedSpecies // ignore: cast_nullable_to_non_nullable
as List<int>,servesAllSpecies: null == servesAllSpecies ? _self.servesAllSpecies : servesAllSpecies // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
