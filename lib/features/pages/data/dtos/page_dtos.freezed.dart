// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageDto {

 int get id; String get name; String get handle; String? get bio; String? get avatarUrl; String? get bannerUrl; String? get website; String? get phone; String? get address; double? get latitude; double? get longitude; String? get category; String? get ownerUserId; bool get isVerified; int get followerCount; int get postCount;// null when anonymous viewer
 bool? get isFollowing; DateTime? get createdAt;
/// Create a copy of PageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageDtoCopyWith<PageDto> get copyWith => _$PageDtoCopyWithImpl<PageDto>(this as PageDto, _$identity);

  /// Serializes this PageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.website, website) || other.website == website)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.category, category) || other.category == category)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.postCount, postCount) || other.postCount == postCount)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,handle,bio,avatarUrl,bannerUrl,website,phone,address,latitude,longitude,category,ownerUserId,isVerified,followerCount,postCount,isFollowing,createdAt);

@override
String toString() {
  return 'PageDto(id: $id, name: $name, handle: $handle, bio: $bio, avatarUrl: $avatarUrl, bannerUrl: $bannerUrl, website: $website, phone: $phone, address: $address, latitude: $latitude, longitude: $longitude, category: $category, ownerUserId: $ownerUserId, isVerified: $isVerified, followerCount: $followerCount, postCount: $postCount, isFollowing: $isFollowing, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PageDtoCopyWith<$Res>  {
  factory $PageDtoCopyWith(PageDto value, $Res Function(PageDto) _then) = _$PageDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String handle, String? bio, String? avatarUrl, String? bannerUrl, String? website, String? phone, String? address, double? latitude, double? longitude, String? category, String? ownerUserId, bool isVerified, int followerCount, int postCount, bool? isFollowing, DateTime? createdAt
});




}
/// @nodoc
class _$PageDtoCopyWithImpl<$Res>
    implements $PageDtoCopyWith<$Res> {
  _$PageDtoCopyWithImpl(this._self, this._then);

  final PageDto _self;
  final $Res Function(PageDto) _then;

/// Create a copy of PageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? bio = freezed,Object? avatarUrl = freezed,Object? bannerUrl = freezed,Object? website = freezed,Object? phone = freezed,Object? address = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? category = freezed,Object? ownerUserId = freezed,Object? isVerified = null,Object? followerCount = null,Object? postCount = null,Object? isFollowing = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,isFollowing: freezed == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PageDto].
extension PageDtoPatterns on PageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageDto value)  $default,){
final _that = this;
switch (_that) {
case _PageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageDto value)?  $default,){
final _that = this;
switch (_that) {
case _PageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String handle,  String? bio,  String? avatarUrl,  String? bannerUrl,  String? website,  String? phone,  String? address,  double? latitude,  double? longitude,  String? category,  String? ownerUserId,  bool isVerified,  int followerCount,  int postCount,  bool? isFollowing,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageDto() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.bio,_that.avatarUrl,_that.bannerUrl,_that.website,_that.phone,_that.address,_that.latitude,_that.longitude,_that.category,_that.ownerUserId,_that.isVerified,_that.followerCount,_that.postCount,_that.isFollowing,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String handle,  String? bio,  String? avatarUrl,  String? bannerUrl,  String? website,  String? phone,  String? address,  double? latitude,  double? longitude,  String? category,  String? ownerUserId,  bool isVerified,  int followerCount,  int postCount,  bool? isFollowing,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _PageDto():
return $default(_that.id,_that.name,_that.handle,_that.bio,_that.avatarUrl,_that.bannerUrl,_that.website,_that.phone,_that.address,_that.latitude,_that.longitude,_that.category,_that.ownerUserId,_that.isVerified,_that.followerCount,_that.postCount,_that.isFollowing,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String handle,  String? bio,  String? avatarUrl,  String? bannerUrl,  String? website,  String? phone,  String? address,  double? latitude,  double? longitude,  String? category,  String? ownerUserId,  bool isVerified,  int followerCount,  int postCount,  bool? isFollowing,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PageDto() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.bio,_that.avatarUrl,_that.bannerUrl,_that.website,_that.phone,_that.address,_that.latitude,_that.longitude,_that.category,_that.ownerUserId,_that.isVerified,_that.followerCount,_that.postCount,_that.isFollowing,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageDto extends PageDto {
  const _PageDto({required this.id, this.name = '', this.handle = '', this.bio, this.avatarUrl, this.bannerUrl, this.website, this.phone, this.address, this.latitude, this.longitude, this.category, this.ownerUserId, this.isVerified = false, this.followerCount = 0, this.postCount = 0, this.isFollowing, this.createdAt}): super._();
  factory _PageDto.fromJson(Map<String, dynamic> json) => _$PageDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String handle;
@override final  String? bio;
@override final  String? avatarUrl;
@override final  String? bannerUrl;
@override final  String? website;
@override final  String? phone;
@override final  String? address;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? category;
@override final  String? ownerUserId;
@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  int followerCount;
@override@JsonKey() final  int postCount;
// null when anonymous viewer
@override final  bool? isFollowing;
@override final  DateTime? createdAt;

/// Create a copy of PageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageDtoCopyWith<_PageDto> get copyWith => __$PageDtoCopyWithImpl<_PageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.website, website) || other.website == website)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.category, category) || other.category == category)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.postCount, postCount) || other.postCount == postCount)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,handle,bio,avatarUrl,bannerUrl,website,phone,address,latitude,longitude,category,ownerUserId,isVerified,followerCount,postCount,isFollowing,createdAt);

@override
String toString() {
  return 'PageDto(id: $id, name: $name, handle: $handle, bio: $bio, avatarUrl: $avatarUrl, bannerUrl: $bannerUrl, website: $website, phone: $phone, address: $address, latitude: $latitude, longitude: $longitude, category: $category, ownerUserId: $ownerUserId, isVerified: $isVerified, followerCount: $followerCount, postCount: $postCount, isFollowing: $isFollowing, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PageDtoCopyWith<$Res> implements $PageDtoCopyWith<$Res> {
  factory _$PageDtoCopyWith(_PageDto value, $Res Function(_PageDto) _then) = __$PageDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String handle, String? bio, String? avatarUrl, String? bannerUrl, String? website, String? phone, String? address, double? latitude, double? longitude, String? category, String? ownerUserId, bool isVerified, int followerCount, int postCount, bool? isFollowing, DateTime? createdAt
});




}
/// @nodoc
class __$PageDtoCopyWithImpl<$Res>
    implements _$PageDtoCopyWith<$Res> {
  __$PageDtoCopyWithImpl(this._self, this._then);

  final _PageDto _self;
  final $Res Function(_PageDto) _then;

/// Create a copy of PageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = null,Object? bio = freezed,Object? avatarUrl = freezed,Object? bannerUrl = freezed,Object? website = freezed,Object? phone = freezed,Object? address = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? category = freezed,Object? ownerUserId = freezed,Object? isVerified = null,Object? followerCount = null,Object? postCount = null,Object? isFollowing = freezed,Object? createdAt = freezed,}) {
  return _then(_PageDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,isFollowing: freezed == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
