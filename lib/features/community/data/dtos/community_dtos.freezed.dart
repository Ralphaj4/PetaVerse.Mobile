// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PetSummaryDto {

 int get id; String get name; String? get breed; String? get species; String? get avatarUrl; String? get bio; String? get ownerName; bool get isVerified; int get followers; bool get isFollowing;
/// Create a copy of PetSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<PetSummaryDto> get copyWith => _$PetSummaryDtoCopyWithImpl<PetSummaryDto>(this as PetSummaryDto, _$identity);

  /// Serializes this PetSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.species, species) || other.species == species)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,breed,species,avatarUrl,bio,ownerName,isVerified,followers,isFollowing);

@override
String toString() {
  return 'PetSummaryDto(id: $id, name: $name, breed: $breed, species: $species, avatarUrl: $avatarUrl, bio: $bio, ownerName: $ownerName, isVerified: $isVerified, followers: $followers, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class $PetSummaryDtoCopyWith<$Res>  {
  factory $PetSummaryDtoCopyWith(PetSummaryDto value, $Res Function(PetSummaryDto) _then) = _$PetSummaryDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? breed, String? species, String? avatarUrl, String? bio, String? ownerName, bool isVerified, int followers, bool isFollowing
});




}
/// @nodoc
class _$PetSummaryDtoCopyWithImpl<$Res>
    implements $PetSummaryDtoCopyWith<$Res> {
  _$PetSummaryDtoCopyWithImpl(this._self, this._then);

  final PetSummaryDto _self;
  final $Res Function(PetSummaryDto) _then;

/// Create a copy of PetSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? breed = freezed,Object? species = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? ownerName = freezed,Object? isVerified = null,Object? followers = null,Object? isFollowing = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,species: freezed == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,ownerName: freezed == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PetSummaryDto].
extension PetSummaryDtoPatterns on PetSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PetSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PetSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PetSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _PetSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PetSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _PetSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? breed,  String? species,  String? avatarUrl,  String? bio,  String? ownerName,  bool isVerified,  int followers,  bool isFollowing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PetSummaryDto() when $default != null:
return $default(_that.id,_that.name,_that.breed,_that.species,_that.avatarUrl,_that.bio,_that.ownerName,_that.isVerified,_that.followers,_that.isFollowing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? breed,  String? species,  String? avatarUrl,  String? bio,  String? ownerName,  bool isVerified,  int followers,  bool isFollowing)  $default,) {final _that = this;
switch (_that) {
case _PetSummaryDto():
return $default(_that.id,_that.name,_that.breed,_that.species,_that.avatarUrl,_that.bio,_that.ownerName,_that.isVerified,_that.followers,_that.isFollowing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? breed,  String? species,  String? avatarUrl,  String? bio,  String? ownerName,  bool isVerified,  int followers,  bool isFollowing)?  $default,) {final _that = this;
switch (_that) {
case _PetSummaryDto() when $default != null:
return $default(_that.id,_that.name,_that.breed,_that.species,_that.avatarUrl,_that.bio,_that.ownerName,_that.isVerified,_that.followers,_that.isFollowing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PetSummaryDto extends PetSummaryDto {
  const _PetSummaryDto({required this.id, this.name = '', this.breed, this.species, this.avatarUrl, this.bio, this.ownerName, this.isVerified = false, this.followers = 0, this.isFollowing = false}): super._();
  factory _PetSummaryDto.fromJson(Map<String, dynamic> json) => _$PetSummaryDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? breed;
@override final  String? species;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  String? ownerName;
@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  int followers;
@override@JsonKey() final  bool isFollowing;

/// Create a copy of PetSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetSummaryDtoCopyWith<_PetSummaryDto> get copyWith => __$PetSummaryDtoCopyWithImpl<_PetSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.species, species) || other.species == species)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,breed,species,avatarUrl,bio,ownerName,isVerified,followers,isFollowing);

@override
String toString() {
  return 'PetSummaryDto(id: $id, name: $name, breed: $breed, species: $species, avatarUrl: $avatarUrl, bio: $bio, ownerName: $ownerName, isVerified: $isVerified, followers: $followers, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class _$PetSummaryDtoCopyWith<$Res> implements $PetSummaryDtoCopyWith<$Res> {
  factory _$PetSummaryDtoCopyWith(_PetSummaryDto value, $Res Function(_PetSummaryDto) _then) = __$PetSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? breed, String? species, String? avatarUrl, String? bio, String? ownerName, bool isVerified, int followers, bool isFollowing
});




}
/// @nodoc
class __$PetSummaryDtoCopyWithImpl<$Res>
    implements _$PetSummaryDtoCopyWith<$Res> {
  __$PetSummaryDtoCopyWithImpl(this._self, this._then);

  final _PetSummaryDto _self;
  final $Res Function(_PetSummaryDto) _then;

/// Create a copy of PetSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? breed = freezed,Object? species = freezed,Object? avatarUrl = freezed,Object? bio = freezed,Object? ownerName = freezed,Object? isVerified = null,Object? followers = null,Object? isFollowing = null,}) {
  return _then(_PetSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,species: freezed == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,ownerName: freezed == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PostMediaDto {

 String get url; bool get isVideo; int? get durationSeconds; String? get altText; String? get thumbnailUrl;
/// Create a copy of PostMediaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostMediaDtoCopyWith<PostMediaDto> get copyWith => _$PostMediaDtoCopyWithImpl<PostMediaDto>(this as PostMediaDto, _$identity);

  /// Serializes this PostMediaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostMediaDto&&(identical(other.url, url) || other.url == url)&&(identical(other.isVideo, isVideo) || other.isVideo == isVideo)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.altText, altText) || other.altText == altText)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,isVideo,durationSeconds,altText,thumbnailUrl);

@override
String toString() {
  return 'PostMediaDto(url: $url, isVideo: $isVideo, durationSeconds: $durationSeconds, altText: $altText, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class $PostMediaDtoCopyWith<$Res>  {
  factory $PostMediaDtoCopyWith(PostMediaDto value, $Res Function(PostMediaDto) _then) = _$PostMediaDtoCopyWithImpl;
@useResult
$Res call({
 String url, bool isVideo, int? durationSeconds, String? altText, String? thumbnailUrl
});




}
/// @nodoc
class _$PostMediaDtoCopyWithImpl<$Res>
    implements $PostMediaDtoCopyWith<$Res> {
  _$PostMediaDtoCopyWithImpl(this._self, this._then);

  final PostMediaDto _self;
  final $Res Function(PostMediaDto) _then;

/// Create a copy of PostMediaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? isVideo = null,Object? durationSeconds = freezed,Object? altText = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isVideo: null == isVideo ? _self.isVideo : isVideo // ignore: cast_nullable_to_non_nullable
as bool,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,altText: freezed == altText ? _self.altText : altText // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostMediaDto].
extension PostMediaDtoPatterns on PostMediaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostMediaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostMediaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostMediaDto value)  $default,){
final _that = this;
switch (_that) {
case _PostMediaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostMediaDto value)?  $default,){
final _that = this;
switch (_that) {
case _PostMediaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  bool isVideo,  int? durationSeconds,  String? altText,  String? thumbnailUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostMediaDto() when $default != null:
return $default(_that.url,_that.isVideo,_that.durationSeconds,_that.altText,_that.thumbnailUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  bool isVideo,  int? durationSeconds,  String? altText,  String? thumbnailUrl)  $default,) {final _that = this;
switch (_that) {
case _PostMediaDto():
return $default(_that.url,_that.isVideo,_that.durationSeconds,_that.altText,_that.thumbnailUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  bool isVideo,  int? durationSeconds,  String? altText,  String? thumbnailUrl)?  $default,) {final _that = this;
switch (_that) {
case _PostMediaDto() when $default != null:
return $default(_that.url,_that.isVideo,_that.durationSeconds,_that.altText,_that.thumbnailUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostMediaDto extends PostMediaDto {
  const _PostMediaDto({this.url = '', this.isVideo = false, this.durationSeconds, this.altText, this.thumbnailUrl}): super._();
  factory _PostMediaDto.fromJson(Map<String, dynamic> json) => _$PostMediaDtoFromJson(json);

@override@JsonKey() final  String url;
@override@JsonKey() final  bool isVideo;
@override final  int? durationSeconds;
@override final  String? altText;
@override final  String? thumbnailUrl;

/// Create a copy of PostMediaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostMediaDtoCopyWith<_PostMediaDto> get copyWith => __$PostMediaDtoCopyWithImpl<_PostMediaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostMediaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostMediaDto&&(identical(other.url, url) || other.url == url)&&(identical(other.isVideo, isVideo) || other.isVideo == isVideo)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.altText, altText) || other.altText == altText)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,isVideo,durationSeconds,altText,thumbnailUrl);

@override
String toString() {
  return 'PostMediaDto(url: $url, isVideo: $isVideo, durationSeconds: $durationSeconds, altText: $altText, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class _$PostMediaDtoCopyWith<$Res> implements $PostMediaDtoCopyWith<$Res> {
  factory _$PostMediaDtoCopyWith(_PostMediaDto value, $Res Function(_PostMediaDto) _then) = __$PostMediaDtoCopyWithImpl;
@override @useResult
$Res call({
 String url, bool isVideo, int? durationSeconds, String? altText, String? thumbnailUrl
});




}
/// @nodoc
class __$PostMediaDtoCopyWithImpl<$Res>
    implements _$PostMediaDtoCopyWith<$Res> {
  __$PostMediaDtoCopyWithImpl(this._self, this._then);

  final _PostMediaDto _self;
  final $Res Function(_PostMediaDto) _then;

/// Create a copy of PostMediaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? isVideo = null,Object? durationSeconds = freezed,Object? altText = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_PostMediaDto(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isVideo: null == isVideo ? _self.isVideo : isVideo // ignore: cast_nullable_to_non_nullable
as bool,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,altText: freezed == altText ? _self.altText : altText // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PostDto {

 int get id; PetSummaryDto get author; List<PostMediaDto> get media; String? get caption; String? get locationName; int get visibility; List<String> get hashtags;// Tagged pets now arrive as full pet objects (id/name/avatarUrl/breed),
// not bare ids.
 List<PetSummaryDto> get taggedPets; int get likes; int get comments; bool get likedByMe; bool get saved; bool get isEdited; DateTime? get createdAt; String? get timeAgo; int? get communityId; String? get communityName;
/// Create a copy of PostDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDtoCopyWith<PostDto> get copyWith => _$PostDtoCopyWithImpl<PostDto>(this as PostDto, _$identity);

  /// Serializes this PostDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDto&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.media, media)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other.hashtags, hashtags)&&const DeepCollectionEquality().equals(other.taggedPets, taggedPets)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.likedByMe, likedByMe) || other.likedByMe == likedByMe)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,const DeepCollectionEquality().hash(media),caption,locationName,visibility,const DeepCollectionEquality().hash(hashtags),const DeepCollectionEquality().hash(taggedPets),likes,comments,likedByMe,saved,isEdited,createdAt,timeAgo,communityId,communityName);

@override
String toString() {
  return 'PostDto(id: $id, author: $author, media: $media, caption: $caption, locationName: $locationName, visibility: $visibility, hashtags: $hashtags, taggedPets: $taggedPets, likes: $likes, comments: $comments, likedByMe: $likedByMe, saved: $saved, isEdited: $isEdited, createdAt: $createdAt, timeAgo: $timeAgo, communityId: $communityId, communityName: $communityName)';
}


}

/// @nodoc
abstract mixin class $PostDtoCopyWith<$Res>  {
  factory $PostDtoCopyWith(PostDto value, $Res Function(PostDto) _then) = _$PostDtoCopyWithImpl;
@useResult
$Res call({
 int id, PetSummaryDto author, List<PostMediaDto> media, String? caption, String? locationName, int visibility, List<String> hashtags, List<PetSummaryDto> taggedPets, int likes, int comments, bool likedByMe, bool saved, bool isEdited, DateTime? createdAt, String? timeAgo, int? communityId, String? communityName
});


$PetSummaryDtoCopyWith<$Res> get author;

}
/// @nodoc
class _$PostDtoCopyWithImpl<$Res>
    implements $PostDtoCopyWith<$Res> {
  _$PostDtoCopyWithImpl(this._self, this._then);

  final PostDto _self;
  final $Res Function(PostDto) _then;

/// Create a copy of PostDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? media = null,Object? caption = freezed,Object? locationName = freezed,Object? visibility = null,Object? hashtags = null,Object? taggedPets = null,Object? likes = null,Object? comments = null,Object? likedByMe = null,Object? saved = null,Object? isEdited = null,Object? createdAt = freezed,Object? timeAgo = freezed,Object? communityId = freezed,Object? communityName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<PostMediaDto>,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as int,hashtags: null == hashtags ? _self.hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,taggedPets: null == taggedPets ? _self.taggedPets : taggedPets // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,likedByMe: null == likedByMe ? _self.likedByMe : likedByMe // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as int?,communityName: freezed == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PostDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get author {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostDto].
extension PostDtoPatterns on PostDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDto value)  $default,){
final _that = this;
switch (_that) {
case _PostDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDto value)?  $default,){
final _that = this;
switch (_that) {
case _PostDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  PetSummaryDto author,  List<PostMediaDto> media,  String? caption,  String? locationName,  int visibility,  List<String> hashtags,  List<PetSummaryDto> taggedPets,  int likes,  int comments,  bool likedByMe,  bool saved,  bool isEdited,  DateTime? createdAt,  String? timeAgo,  int? communityId,  String? communityName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDto() when $default != null:
return $default(_that.id,_that.author,_that.media,_that.caption,_that.locationName,_that.visibility,_that.hashtags,_that.taggedPets,_that.likes,_that.comments,_that.likedByMe,_that.saved,_that.isEdited,_that.createdAt,_that.timeAgo,_that.communityId,_that.communityName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  PetSummaryDto author,  List<PostMediaDto> media,  String? caption,  String? locationName,  int visibility,  List<String> hashtags,  List<PetSummaryDto> taggedPets,  int likes,  int comments,  bool likedByMe,  bool saved,  bool isEdited,  DateTime? createdAt,  String? timeAgo,  int? communityId,  String? communityName)  $default,) {final _that = this;
switch (_that) {
case _PostDto():
return $default(_that.id,_that.author,_that.media,_that.caption,_that.locationName,_that.visibility,_that.hashtags,_that.taggedPets,_that.likes,_that.comments,_that.likedByMe,_that.saved,_that.isEdited,_that.createdAt,_that.timeAgo,_that.communityId,_that.communityName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  PetSummaryDto author,  List<PostMediaDto> media,  String? caption,  String? locationName,  int visibility,  List<String> hashtags,  List<PetSummaryDto> taggedPets,  int likes,  int comments,  bool likedByMe,  bool saved,  bool isEdited,  DateTime? createdAt,  String? timeAgo,  int? communityId,  String? communityName)?  $default,) {final _that = this;
switch (_that) {
case _PostDto() when $default != null:
return $default(_that.id,_that.author,_that.media,_that.caption,_that.locationName,_that.visibility,_that.hashtags,_that.taggedPets,_that.likes,_that.comments,_that.likedByMe,_that.saved,_that.isEdited,_that.createdAt,_that.timeAgo,_that.communityId,_that.communityName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostDto extends PostDto {
  const _PostDto({required this.id, required this.author, final  List<PostMediaDto> media = const <PostMediaDto>[], this.caption, this.locationName, this.visibility = 0, final  List<String> hashtags = const <String>[], final  List<PetSummaryDto> taggedPets = const <PetSummaryDto>[], this.likes = 0, this.comments = 0, this.likedByMe = false, this.saved = false, this.isEdited = false, this.createdAt, this.timeAgo, this.communityId, this.communityName}): _media = media,_hashtags = hashtags,_taggedPets = taggedPets,super._();
  factory _PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);

@override final  int id;
@override final  PetSummaryDto author;
 final  List<PostMediaDto> _media;
@override@JsonKey() List<PostMediaDto> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}

@override final  String? caption;
@override final  String? locationName;
@override@JsonKey() final  int visibility;
 final  List<String> _hashtags;
@override@JsonKey() List<String> get hashtags {
  if (_hashtags is EqualUnmodifiableListView) return _hashtags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hashtags);
}

// Tagged pets now arrive as full pet objects (id/name/avatarUrl/breed),
// not bare ids.
 final  List<PetSummaryDto> _taggedPets;
// Tagged pets now arrive as full pet objects (id/name/avatarUrl/breed),
// not bare ids.
@override@JsonKey() List<PetSummaryDto> get taggedPets {
  if (_taggedPets is EqualUnmodifiableListView) return _taggedPets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taggedPets);
}

@override@JsonKey() final  int likes;
@override@JsonKey() final  int comments;
@override@JsonKey() final  bool likedByMe;
@override@JsonKey() final  bool saved;
@override@JsonKey() final  bool isEdited;
@override final  DateTime? createdAt;
@override final  String? timeAgo;
@override final  int? communityId;
@override final  String? communityName;

/// Create a copy of PostDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDtoCopyWith<_PostDto> get copyWith => __$PostDtoCopyWithImpl<_PostDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDto&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._media, _media)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other._hashtags, _hashtags)&&const DeepCollectionEquality().equals(other._taggedPets, _taggedPets)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.likedByMe, likedByMe) || other.likedByMe == likedByMe)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,const DeepCollectionEquality().hash(_media),caption,locationName,visibility,const DeepCollectionEquality().hash(_hashtags),const DeepCollectionEquality().hash(_taggedPets),likes,comments,likedByMe,saved,isEdited,createdAt,timeAgo,communityId,communityName);

@override
String toString() {
  return 'PostDto(id: $id, author: $author, media: $media, caption: $caption, locationName: $locationName, visibility: $visibility, hashtags: $hashtags, taggedPets: $taggedPets, likes: $likes, comments: $comments, likedByMe: $likedByMe, saved: $saved, isEdited: $isEdited, createdAt: $createdAt, timeAgo: $timeAgo, communityId: $communityId, communityName: $communityName)';
}


}

/// @nodoc
abstract mixin class _$PostDtoCopyWith<$Res> implements $PostDtoCopyWith<$Res> {
  factory _$PostDtoCopyWith(_PostDto value, $Res Function(_PostDto) _then) = __$PostDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, PetSummaryDto author, List<PostMediaDto> media, String? caption, String? locationName, int visibility, List<String> hashtags, List<PetSummaryDto> taggedPets, int likes, int comments, bool likedByMe, bool saved, bool isEdited, DateTime? createdAt, String? timeAgo, int? communityId, String? communityName
});


@override $PetSummaryDtoCopyWith<$Res> get author;

}
/// @nodoc
class __$PostDtoCopyWithImpl<$Res>
    implements _$PostDtoCopyWith<$Res> {
  __$PostDtoCopyWithImpl(this._self, this._then);

  final _PostDto _self;
  final $Res Function(_PostDto) _then;

/// Create a copy of PostDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? media = null,Object? caption = freezed,Object? locationName = freezed,Object? visibility = null,Object? hashtags = null,Object? taggedPets = null,Object? likes = null,Object? comments = null,Object? likedByMe = null,Object? saved = null,Object? isEdited = null,Object? createdAt = freezed,Object? timeAgo = freezed,Object? communityId = freezed,Object? communityName = freezed,}) {
  return _then(_PostDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<PostMediaDto>,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as int,hashtags: null == hashtags ? _self._hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,taggedPets: null == taggedPets ? _self._taggedPets : taggedPets // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,likedByMe: null == likedByMe ? _self.likedByMe : likedByMe // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as int?,communityName: freezed == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PostDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get author {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$CommentDto {

 int get id; int get postId; PetSummaryDto get author; int? get parentCommentId; String get body; int get likes; bool get likedByMe; bool get isPinned; List<CommentDto> get replies; DateTime? get createdAt; String? get timeAgo;
/// Create a copy of CommentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentDtoCopyWith<CommentDto> get copyWith => _$CommentDtoCopyWithImpl<CommentDto>(this as CommentDto, _$identity);

  /// Serializes this CommentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentDto&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.author, author) || other.author == author)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId)&&(identical(other.body, body) || other.body == body)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.likedByMe, likedByMe) || other.likedByMe == likedByMe)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,author,parentCommentId,body,likes,likedByMe,isPinned,const DeepCollectionEquality().hash(replies),createdAt,timeAgo);

@override
String toString() {
  return 'CommentDto(id: $id, postId: $postId, author: $author, parentCommentId: $parentCommentId, body: $body, likes: $likes, likedByMe: $likedByMe, isPinned: $isPinned, replies: $replies, createdAt: $createdAt, timeAgo: $timeAgo)';
}


}

/// @nodoc
abstract mixin class $CommentDtoCopyWith<$Res>  {
  factory $CommentDtoCopyWith(CommentDto value, $Res Function(CommentDto) _then) = _$CommentDtoCopyWithImpl;
@useResult
$Res call({
 int id, int postId, PetSummaryDto author, int? parentCommentId, String body, int likes, bool likedByMe, bool isPinned, List<CommentDto> replies, DateTime? createdAt, String? timeAgo
});


$PetSummaryDtoCopyWith<$Res> get author;

}
/// @nodoc
class _$CommentDtoCopyWithImpl<$Res>
    implements $CommentDtoCopyWith<$Res> {
  _$CommentDtoCopyWithImpl(this._self, this._then);

  final CommentDto _self;
  final $Res Function(CommentDto) _then;

/// Create a copy of CommentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? postId = null,Object? author = null,Object? parentCommentId = freezed,Object? body = null,Object? likes = null,Object? likedByMe = null,Object? isPinned = null,Object? replies = null,Object? createdAt = freezed,Object? timeAgo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as int?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,likedByMe: null == likedByMe ? _self.likedByMe : likedByMe // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentDto>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CommentDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get author {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommentDto].
extension CommentDtoPatterns on CommentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentDto value)  $default,){
final _that = this;
switch (_that) {
case _CommentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int postId,  PetSummaryDto author,  int? parentCommentId,  String body,  int likes,  bool likedByMe,  bool isPinned,  List<CommentDto> replies,  DateTime? createdAt,  String? timeAgo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentDto() when $default != null:
return $default(_that.id,_that.postId,_that.author,_that.parentCommentId,_that.body,_that.likes,_that.likedByMe,_that.isPinned,_that.replies,_that.createdAt,_that.timeAgo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int postId,  PetSummaryDto author,  int? parentCommentId,  String body,  int likes,  bool likedByMe,  bool isPinned,  List<CommentDto> replies,  DateTime? createdAt,  String? timeAgo)  $default,) {final _that = this;
switch (_that) {
case _CommentDto():
return $default(_that.id,_that.postId,_that.author,_that.parentCommentId,_that.body,_that.likes,_that.likedByMe,_that.isPinned,_that.replies,_that.createdAt,_that.timeAgo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int postId,  PetSummaryDto author,  int? parentCommentId,  String body,  int likes,  bool likedByMe,  bool isPinned,  List<CommentDto> replies,  DateTime? createdAt,  String? timeAgo)?  $default,) {final _that = this;
switch (_that) {
case _CommentDto() when $default != null:
return $default(_that.id,_that.postId,_that.author,_that.parentCommentId,_that.body,_that.likes,_that.likedByMe,_that.isPinned,_that.replies,_that.createdAt,_that.timeAgo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentDto extends CommentDto {
  const _CommentDto({required this.id, this.postId = 0, required this.author, this.parentCommentId, this.body = '', this.likes = 0, this.likedByMe = false, this.isPinned = false, final  List<CommentDto> replies = const <CommentDto>[], this.createdAt, this.timeAgo}): _replies = replies,super._();
  factory _CommentDto.fromJson(Map<String, dynamic> json) => _$CommentDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  int postId;
@override final  PetSummaryDto author;
@override final  int? parentCommentId;
@override@JsonKey() final  String body;
@override@JsonKey() final  int likes;
@override@JsonKey() final  bool likedByMe;
@override@JsonKey() final  bool isPinned;
 final  List<CommentDto> _replies;
@override@JsonKey() List<CommentDto> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override final  DateTime? createdAt;
@override final  String? timeAgo;

/// Create a copy of CommentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentDtoCopyWith<_CommentDto> get copyWith => __$CommentDtoCopyWithImpl<_CommentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentDto&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.author, author) || other.author == author)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId)&&(identical(other.body, body) || other.body == body)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.likedByMe, likedByMe) || other.likedByMe == likedByMe)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,author,parentCommentId,body,likes,likedByMe,isPinned,const DeepCollectionEquality().hash(_replies),createdAt,timeAgo);

@override
String toString() {
  return 'CommentDto(id: $id, postId: $postId, author: $author, parentCommentId: $parentCommentId, body: $body, likes: $likes, likedByMe: $likedByMe, isPinned: $isPinned, replies: $replies, createdAt: $createdAt, timeAgo: $timeAgo)';
}


}

/// @nodoc
abstract mixin class _$CommentDtoCopyWith<$Res> implements $CommentDtoCopyWith<$Res> {
  factory _$CommentDtoCopyWith(_CommentDto value, $Res Function(_CommentDto) _then) = __$CommentDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int postId, PetSummaryDto author, int? parentCommentId, String body, int likes, bool likedByMe, bool isPinned, List<CommentDto> replies, DateTime? createdAt, String? timeAgo
});


@override $PetSummaryDtoCopyWith<$Res> get author;

}
/// @nodoc
class __$CommentDtoCopyWithImpl<$Res>
    implements _$CommentDtoCopyWith<$Res> {
  __$CommentDtoCopyWithImpl(this._self, this._then);

  final _CommentDto _self;
  final $Res Function(_CommentDto) _then;

/// Create a copy of CommentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? postId = null,Object? author = null,Object? parentCommentId = freezed,Object? body = null,Object? likes = null,Object? likedByMe = null,Object? isPinned = null,Object? replies = null,Object? createdAt = freezed,Object? timeAgo = freezed,}) {
  return _then(_CommentDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as int?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,likedByMe: null == likedByMe ? _self.likedByMe : likedByMe // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentDto>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CommentDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get author {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$PostDetailDto {

 PostDto get post; List<CommentDto> get comments;
/// Create a copy of PostDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDetailDtoCopyWith<PostDetailDto> get copyWith => _$PostDetailDtoCopyWithImpl<PostDetailDto>(this as PostDetailDto, _$identity);

  /// Serializes this PostDetailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDetailDto&&(identical(other.post, post) || other.post == post)&&const DeepCollectionEquality().equals(other.comments, comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,post,const DeepCollectionEquality().hash(comments));

@override
String toString() {
  return 'PostDetailDto(post: $post, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $PostDetailDtoCopyWith<$Res>  {
  factory $PostDetailDtoCopyWith(PostDetailDto value, $Res Function(PostDetailDto) _then) = _$PostDetailDtoCopyWithImpl;
@useResult
$Res call({
 PostDto post, List<CommentDto> comments
});


$PostDtoCopyWith<$Res> get post;

}
/// @nodoc
class _$PostDetailDtoCopyWithImpl<$Res>
    implements $PostDetailDtoCopyWith<$Res> {
  _$PostDetailDtoCopyWithImpl(this._self, this._then);

  final PostDetailDto _self;
  final $Res Function(PostDetailDto) _then;

/// Create a copy of PostDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? post = null,Object? comments = null,}) {
  return _then(_self.copyWith(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as PostDto,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentDto>,
  ));
}
/// Create a copy of PostDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostDtoCopyWith<$Res> get post {
  
  return $PostDtoCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostDetailDto].
extension PostDetailDtoPatterns on PostDetailDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDetailDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _PostDetailDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _PostDetailDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PostDto post,  List<CommentDto> comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDetailDto() when $default != null:
return $default(_that.post,_that.comments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PostDto post,  List<CommentDto> comments)  $default,) {final _that = this;
switch (_that) {
case _PostDetailDto():
return $default(_that.post,_that.comments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PostDto post,  List<CommentDto> comments)?  $default,) {final _that = this;
switch (_that) {
case _PostDetailDto() when $default != null:
return $default(_that.post,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostDetailDto extends PostDetailDto {
  const _PostDetailDto({required this.post, final  List<CommentDto> comments = const <CommentDto>[]}): _comments = comments,super._();
  factory _PostDetailDto.fromJson(Map<String, dynamic> json) => _$PostDetailDtoFromJson(json);

@override final  PostDto post;
 final  List<CommentDto> _comments;
@override@JsonKey() List<CommentDto> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}


/// Create a copy of PostDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDetailDtoCopyWith<_PostDetailDto> get copyWith => __$PostDetailDtoCopyWithImpl<_PostDetailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostDetailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDetailDto&&(identical(other.post, post) || other.post == post)&&const DeepCollectionEquality().equals(other._comments, _comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,post,const DeepCollectionEquality().hash(_comments));

@override
String toString() {
  return 'PostDetailDto(post: $post, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$PostDetailDtoCopyWith<$Res> implements $PostDetailDtoCopyWith<$Res> {
  factory _$PostDetailDtoCopyWith(_PostDetailDto value, $Res Function(_PostDetailDto) _then) = __$PostDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 PostDto post, List<CommentDto> comments
});


@override $PostDtoCopyWith<$Res> get post;

}
/// @nodoc
class __$PostDetailDtoCopyWithImpl<$Res>
    implements _$PostDetailDtoCopyWith<$Res> {
  __$PostDetailDtoCopyWithImpl(this._self, this._then);

  final _PostDetailDto _self;
  final $Res Function(_PostDetailDto) _then;

/// Create a copy of PostDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? post = null,Object? comments = null,}) {
  return _then(_PostDetailDto(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as PostDto,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentDto>,
  ));
}

/// Create a copy of PostDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostDtoCopyWith<$Res> get post {
  
  return $PostDtoCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}


/// @nodoc
mixin _$LostFoundAlertDto {

 int get id; String get petName; String get breed; String? get distanceLabel; String get imageUrl; int? get reward; DateTime? get createdAt; String? get timeAgo;
/// Create a copy of LostFoundAlertDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LostFoundAlertDtoCopyWith<LostFoundAlertDto> get copyWith => _$LostFoundAlertDtoCopyWithImpl<LostFoundAlertDto>(this as LostFoundAlertDto, _$identity);

  /// Serializes this LostFoundAlertDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LostFoundAlertDto&&(identical(other.id, id) || other.id == id)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.distanceLabel, distanceLabel) || other.distanceLabel == distanceLabel)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.reward, reward) || other.reward == reward)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,petName,breed,distanceLabel,imageUrl,reward,createdAt,timeAgo);

@override
String toString() {
  return 'LostFoundAlertDto(id: $id, petName: $petName, breed: $breed, distanceLabel: $distanceLabel, imageUrl: $imageUrl, reward: $reward, createdAt: $createdAt, timeAgo: $timeAgo)';
}


}

/// @nodoc
abstract mixin class $LostFoundAlertDtoCopyWith<$Res>  {
  factory $LostFoundAlertDtoCopyWith(LostFoundAlertDto value, $Res Function(LostFoundAlertDto) _then) = _$LostFoundAlertDtoCopyWithImpl;
@useResult
$Res call({
 int id, String petName, String breed, String? distanceLabel, String imageUrl, int? reward, DateTime? createdAt, String? timeAgo
});




}
/// @nodoc
class _$LostFoundAlertDtoCopyWithImpl<$Res>
    implements $LostFoundAlertDtoCopyWith<$Res> {
  _$LostFoundAlertDtoCopyWithImpl(this._self, this._then);

  final LostFoundAlertDto _self;
  final $Res Function(LostFoundAlertDto) _then;

/// Create a copy of LostFoundAlertDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? petName = null,Object? breed = null,Object? distanceLabel = freezed,Object? imageUrl = null,Object? reward = freezed,Object? createdAt = freezed,Object? timeAgo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,breed: null == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String,distanceLabel: freezed == distanceLabel ? _self.distanceLabel : distanceLabel // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,reward: freezed == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LostFoundAlertDto].
extension LostFoundAlertDtoPatterns on LostFoundAlertDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LostFoundAlertDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LostFoundAlertDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LostFoundAlertDto value)  $default,){
final _that = this;
switch (_that) {
case _LostFoundAlertDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LostFoundAlertDto value)?  $default,){
final _that = this;
switch (_that) {
case _LostFoundAlertDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String petName,  String breed,  String? distanceLabel,  String imageUrl,  int? reward,  DateTime? createdAt,  String? timeAgo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LostFoundAlertDto() when $default != null:
return $default(_that.id,_that.petName,_that.breed,_that.distanceLabel,_that.imageUrl,_that.reward,_that.createdAt,_that.timeAgo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String petName,  String breed,  String? distanceLabel,  String imageUrl,  int? reward,  DateTime? createdAt,  String? timeAgo)  $default,) {final _that = this;
switch (_that) {
case _LostFoundAlertDto():
return $default(_that.id,_that.petName,_that.breed,_that.distanceLabel,_that.imageUrl,_that.reward,_that.createdAt,_that.timeAgo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String petName,  String breed,  String? distanceLabel,  String imageUrl,  int? reward,  DateTime? createdAt,  String? timeAgo)?  $default,) {final _that = this;
switch (_that) {
case _LostFoundAlertDto() when $default != null:
return $default(_that.id,_that.petName,_that.breed,_that.distanceLabel,_that.imageUrl,_that.reward,_that.createdAt,_that.timeAgo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LostFoundAlertDto extends LostFoundAlertDto {
  const _LostFoundAlertDto({required this.id, this.petName = '', this.breed = '', this.distanceLabel, this.imageUrl = '', this.reward, this.createdAt, this.timeAgo}): super._();
  factory _LostFoundAlertDto.fromJson(Map<String, dynamic> json) => _$LostFoundAlertDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String petName;
@override@JsonKey() final  String breed;
@override final  String? distanceLabel;
@override@JsonKey() final  String imageUrl;
@override final  int? reward;
@override final  DateTime? createdAt;
@override final  String? timeAgo;

/// Create a copy of LostFoundAlertDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LostFoundAlertDtoCopyWith<_LostFoundAlertDto> get copyWith => __$LostFoundAlertDtoCopyWithImpl<_LostFoundAlertDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LostFoundAlertDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LostFoundAlertDto&&(identical(other.id, id) || other.id == id)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.distanceLabel, distanceLabel) || other.distanceLabel == distanceLabel)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.reward, reward) || other.reward == reward)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,petName,breed,distanceLabel,imageUrl,reward,createdAt,timeAgo);

@override
String toString() {
  return 'LostFoundAlertDto(id: $id, petName: $petName, breed: $breed, distanceLabel: $distanceLabel, imageUrl: $imageUrl, reward: $reward, createdAt: $createdAt, timeAgo: $timeAgo)';
}


}

/// @nodoc
abstract mixin class _$LostFoundAlertDtoCopyWith<$Res> implements $LostFoundAlertDtoCopyWith<$Res> {
  factory _$LostFoundAlertDtoCopyWith(_LostFoundAlertDto value, $Res Function(_LostFoundAlertDto) _then) = __$LostFoundAlertDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String petName, String breed, String? distanceLabel, String imageUrl, int? reward, DateTime? createdAt, String? timeAgo
});




}
/// @nodoc
class __$LostFoundAlertDtoCopyWithImpl<$Res>
    implements _$LostFoundAlertDtoCopyWith<$Res> {
  __$LostFoundAlertDtoCopyWithImpl(this._self, this._then);

  final _LostFoundAlertDto _self;
  final $Res Function(_LostFoundAlertDto) _then;

/// Create a copy of LostFoundAlertDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? petName = null,Object? breed = null,Object? distanceLabel = freezed,Object? imageUrl = null,Object? reward = freezed,Object? createdAt = freezed,Object? timeAgo = freezed,}) {
  return _then(_LostFoundAlertDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,breed: null == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String,distanceLabel: freezed == distanceLabel ? _self.distanceLabel : distanceLabel // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,reward: freezed == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NotificationDto {

 int get id; int get type; PetSummaryDto? get actor; String get text; String? get thumbnailUrl; String? get actionUrl; bool get isRead; DateTime? get createdAt; String? get timeAgo;
/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDtoCopyWith<NotificationDto> get copyWith => _$NotificationDtoCopyWithImpl<NotificationDto>(this as NotificationDto, _$identity);

  /// Serializes this NotificationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.text, text) || other.text == text)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.actionUrl, actionUrl) || other.actionUrl == actionUrl)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,actor,text,thumbnailUrl,actionUrl,isRead,createdAt,timeAgo);

@override
String toString() {
  return 'NotificationDto(id: $id, type: $type, actor: $actor, text: $text, thumbnailUrl: $thumbnailUrl, actionUrl: $actionUrl, isRead: $isRead, createdAt: $createdAt, timeAgo: $timeAgo)';
}


}

/// @nodoc
abstract mixin class $NotificationDtoCopyWith<$Res>  {
  factory $NotificationDtoCopyWith(NotificationDto value, $Res Function(NotificationDto) _then) = _$NotificationDtoCopyWithImpl;
@useResult
$Res call({
 int id, int type, PetSummaryDto? actor, String text, String? thumbnailUrl, String? actionUrl, bool isRead, DateTime? createdAt, String? timeAgo
});


$PetSummaryDtoCopyWith<$Res>? get actor;

}
/// @nodoc
class _$NotificationDtoCopyWithImpl<$Res>
    implements $NotificationDtoCopyWith<$Res> {
  _$NotificationDtoCopyWithImpl(this._self, this._then);

  final NotificationDto _self;
  final $Res Function(NotificationDto) _then;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? actor = freezed,Object? text = null,Object? thumbnailUrl = freezed,Object? actionUrl = freezed,Object? isRead = null,Object? createdAt = freezed,Object? timeAgo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,actor: freezed == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as PetSummaryDto?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,actionUrl: freezed == actionUrl ? _self.actionUrl : actionUrl // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res>? get actor {
    if (_self.actor == null) {
    return null;
  }

  return $PetSummaryDtoCopyWith<$Res>(_self.actor!, (value) {
    return _then(_self.copyWith(actor: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationDto].
extension NotificationDtoPatterns on NotificationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDto value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDto value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int type,  PetSummaryDto? actor,  String text,  String? thumbnailUrl,  String? actionUrl,  bool isRead,  DateTime? createdAt,  String? timeAgo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that.id,_that.type,_that.actor,_that.text,_that.thumbnailUrl,_that.actionUrl,_that.isRead,_that.createdAt,_that.timeAgo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int type,  PetSummaryDto? actor,  String text,  String? thumbnailUrl,  String? actionUrl,  bool isRead,  DateTime? createdAt,  String? timeAgo)  $default,) {final _that = this;
switch (_that) {
case _NotificationDto():
return $default(_that.id,_that.type,_that.actor,_that.text,_that.thumbnailUrl,_that.actionUrl,_that.isRead,_that.createdAt,_that.timeAgo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int type,  PetSummaryDto? actor,  String text,  String? thumbnailUrl,  String? actionUrl,  bool isRead,  DateTime? createdAt,  String? timeAgo)?  $default,) {final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that.id,_that.type,_that.actor,_that.text,_that.thumbnailUrl,_that.actionUrl,_that.isRead,_that.createdAt,_that.timeAgo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationDto extends NotificationDto {
  const _NotificationDto({required this.id, this.type = 0, this.actor, this.text = '', this.thumbnailUrl, this.actionUrl, this.isRead = false, this.createdAt, this.timeAgo}): super._();
  factory _NotificationDto.fromJson(Map<String, dynamic> json) => _$NotificationDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  int type;
@override final  PetSummaryDto? actor;
@override@JsonKey() final  String text;
@override final  String? thumbnailUrl;
@override final  String? actionUrl;
@override@JsonKey() final  bool isRead;
@override final  DateTime? createdAt;
@override final  String? timeAgo;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDtoCopyWith<_NotificationDto> get copyWith => __$NotificationDtoCopyWithImpl<_NotificationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.text, text) || other.text == text)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.actionUrl, actionUrl) || other.actionUrl == actionUrl)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,actor,text,thumbnailUrl,actionUrl,isRead,createdAt,timeAgo);

@override
String toString() {
  return 'NotificationDto(id: $id, type: $type, actor: $actor, text: $text, thumbnailUrl: $thumbnailUrl, actionUrl: $actionUrl, isRead: $isRead, createdAt: $createdAt, timeAgo: $timeAgo)';
}


}

/// @nodoc
abstract mixin class _$NotificationDtoCopyWith<$Res> implements $NotificationDtoCopyWith<$Res> {
  factory _$NotificationDtoCopyWith(_NotificationDto value, $Res Function(_NotificationDto) _then) = __$NotificationDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int type, PetSummaryDto? actor, String text, String? thumbnailUrl, String? actionUrl, bool isRead, DateTime? createdAt, String? timeAgo
});


@override $PetSummaryDtoCopyWith<$Res>? get actor;

}
/// @nodoc
class __$NotificationDtoCopyWithImpl<$Res>
    implements _$NotificationDtoCopyWith<$Res> {
  __$NotificationDtoCopyWithImpl(this._self, this._then);

  final _NotificationDto _self;
  final $Res Function(_NotificationDto) _then;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? actor = freezed,Object? text = null,Object? thumbnailUrl = freezed,Object? actionUrl = freezed,Object? isRead = null,Object? createdAt = freezed,Object? timeAgo = freezed,}) {
  return _then(_NotificationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,actor: freezed == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as PetSummaryDto?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,actionUrl: freezed == actionUrl ? _self.actionUrl : actionUrl // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res>? get actor {
    if (_self.actor == null) {
    return null;
  }

  return $PetSummaryDtoCopyWith<$Res>(_self.actor!, (value) {
    return _then(_self.copyWith(actor: value));
  });
}
}


/// @nodoc
mixin _$SearchResultDto {

 String get type; PostDto? get post; String? get hashtag; int? get postCount; PetSummaryDto? get pet;
/// Create a copy of SearchResultDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultDtoCopyWith<SearchResultDto> get copyWith => _$SearchResultDtoCopyWithImpl<SearchResultDto>(this as SearchResultDto, _$identity);

  /// Serializes this SearchResultDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultDto&&(identical(other.type, type) || other.type == type)&&(identical(other.post, post) || other.post == post)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.postCount, postCount) || other.postCount == postCount)&&(identical(other.pet, pet) || other.pet == pet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,post,hashtag,postCount,pet);

@override
String toString() {
  return 'SearchResultDto(type: $type, post: $post, hashtag: $hashtag, postCount: $postCount, pet: $pet)';
}


}

/// @nodoc
abstract mixin class $SearchResultDtoCopyWith<$Res>  {
  factory $SearchResultDtoCopyWith(SearchResultDto value, $Res Function(SearchResultDto) _then) = _$SearchResultDtoCopyWithImpl;
@useResult
$Res call({
 String type, PostDto? post, String? hashtag, int? postCount, PetSummaryDto? pet
});


$PostDtoCopyWith<$Res>? get post;$PetSummaryDtoCopyWith<$Res>? get pet;

}
/// @nodoc
class _$SearchResultDtoCopyWithImpl<$Res>
    implements $SearchResultDtoCopyWith<$Res> {
  _$SearchResultDtoCopyWithImpl(this._self, this._then);

  final SearchResultDto _self;
  final $Res Function(SearchResultDto) _then;

/// Create a copy of SearchResultDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? post = freezed,Object? hashtag = freezed,Object? postCount = freezed,Object? pet = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as PostDto?,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,postCount: freezed == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int?,pet: freezed == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as PetSummaryDto?,
  ));
}
/// Create a copy of SearchResultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostDtoCopyWith<$Res>? get post {
    if (_self.post == null) {
    return null;
  }

  return $PostDtoCopyWith<$Res>(_self.post!, (value) {
    return _then(_self.copyWith(post: value));
  });
}/// Create a copy of SearchResultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res>? get pet {
    if (_self.pet == null) {
    return null;
  }

  return $PetSummaryDtoCopyWith<$Res>(_self.pet!, (value) {
    return _then(_self.copyWith(pet: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchResultDto].
extension SearchResultDtoPatterns on SearchResultDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResultDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResultDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResultDto value)  $default,){
final _that = this;
switch (_that) {
case _SearchResultDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResultDto value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResultDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  PostDto? post,  String? hashtag,  int? postCount,  PetSummaryDto? pet)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResultDto() when $default != null:
return $default(_that.type,_that.post,_that.hashtag,_that.postCount,_that.pet);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  PostDto? post,  String? hashtag,  int? postCount,  PetSummaryDto? pet)  $default,) {final _that = this;
switch (_that) {
case _SearchResultDto():
return $default(_that.type,_that.post,_that.hashtag,_that.postCount,_that.pet);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  PostDto? post,  String? hashtag,  int? postCount,  PetSummaryDto? pet)?  $default,) {final _that = this;
switch (_that) {
case _SearchResultDto() when $default != null:
return $default(_that.type,_that.post,_that.hashtag,_that.postCount,_that.pet);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchResultDto extends SearchResultDto {
  const _SearchResultDto({this.type = 'post', this.post, this.hashtag, this.postCount, this.pet}): super._();
  factory _SearchResultDto.fromJson(Map<String, dynamic> json) => _$SearchResultDtoFromJson(json);

@override@JsonKey() final  String type;
@override final  PostDto? post;
@override final  String? hashtag;
@override final  int? postCount;
@override final  PetSummaryDto? pet;

/// Create a copy of SearchResultDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultDtoCopyWith<_SearchResultDto> get copyWith => __$SearchResultDtoCopyWithImpl<_SearchResultDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResultDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResultDto&&(identical(other.type, type) || other.type == type)&&(identical(other.post, post) || other.post == post)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.postCount, postCount) || other.postCount == postCount)&&(identical(other.pet, pet) || other.pet == pet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,post,hashtag,postCount,pet);

@override
String toString() {
  return 'SearchResultDto(type: $type, post: $post, hashtag: $hashtag, postCount: $postCount, pet: $pet)';
}


}

/// @nodoc
abstract mixin class _$SearchResultDtoCopyWith<$Res> implements $SearchResultDtoCopyWith<$Res> {
  factory _$SearchResultDtoCopyWith(_SearchResultDto value, $Res Function(_SearchResultDto) _then) = __$SearchResultDtoCopyWithImpl;
@override @useResult
$Res call({
 String type, PostDto? post, String? hashtag, int? postCount, PetSummaryDto? pet
});


@override $PostDtoCopyWith<$Res>? get post;@override $PetSummaryDtoCopyWith<$Res>? get pet;

}
/// @nodoc
class __$SearchResultDtoCopyWithImpl<$Res>
    implements _$SearchResultDtoCopyWith<$Res> {
  __$SearchResultDtoCopyWithImpl(this._self, this._then);

  final _SearchResultDto _self;
  final $Res Function(_SearchResultDto) _then;

/// Create a copy of SearchResultDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? post = freezed,Object? hashtag = freezed,Object? postCount = freezed,Object? pet = freezed,}) {
  return _then(_SearchResultDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as PostDto?,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,postCount: freezed == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int?,pet: freezed == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as PetSummaryDto?,
  ));
}

/// Create a copy of SearchResultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostDtoCopyWith<$Res>? get post {
    if (_self.post == null) {
    return null;
  }

  return $PostDtoCopyWith<$Res>(_self.post!, (value) {
    return _then(_self.copyWith(post: value));
  });
}/// Create a copy of SearchResultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res>? get pet {
    if (_self.pet == null) {
    return null;
  }

  return $PetSummaryDtoCopyWith<$Res>(_self.pet!, (value) {
    return _then(_self.copyWith(pet: value));
  });
}
}


/// @nodoc
mixin _$TrendingHashtagDto {

 String get tag; int get postCount;
/// Create a copy of TrendingHashtagDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendingHashtagDtoCopyWith<TrendingHashtagDto> get copyWith => _$TrendingHashtagDtoCopyWithImpl<TrendingHashtagDto>(this as TrendingHashtagDto, _$identity);

  /// Serializes this TrendingHashtagDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendingHashtagDto&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.postCount, postCount) || other.postCount == postCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tag,postCount);

@override
String toString() {
  return 'TrendingHashtagDto(tag: $tag, postCount: $postCount)';
}


}

/// @nodoc
abstract mixin class $TrendingHashtagDtoCopyWith<$Res>  {
  factory $TrendingHashtagDtoCopyWith(TrendingHashtagDto value, $Res Function(TrendingHashtagDto) _then) = _$TrendingHashtagDtoCopyWithImpl;
@useResult
$Res call({
 String tag, int postCount
});




}
/// @nodoc
class _$TrendingHashtagDtoCopyWithImpl<$Res>
    implements $TrendingHashtagDtoCopyWith<$Res> {
  _$TrendingHashtagDtoCopyWithImpl(this._self, this._then);

  final TrendingHashtagDto _self;
  final $Res Function(TrendingHashtagDto) _then;

/// Create a copy of TrendingHashtagDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tag = null,Object? postCount = null,}) {
  return _then(_self.copyWith(
tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendingHashtagDto].
extension TrendingHashtagDtoPatterns on TrendingHashtagDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendingHashtagDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendingHashtagDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendingHashtagDto value)  $default,){
final _that = this;
switch (_that) {
case _TrendingHashtagDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendingHashtagDto value)?  $default,){
final _that = this;
switch (_that) {
case _TrendingHashtagDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tag,  int postCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendingHashtagDto() when $default != null:
return $default(_that.tag,_that.postCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tag,  int postCount)  $default,) {final _that = this;
switch (_that) {
case _TrendingHashtagDto():
return $default(_that.tag,_that.postCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tag,  int postCount)?  $default,) {final _that = this;
switch (_that) {
case _TrendingHashtagDto() when $default != null:
return $default(_that.tag,_that.postCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendingHashtagDto extends TrendingHashtagDto {
  const _TrendingHashtagDto({this.tag = '', this.postCount = 0}): super._();
  factory _TrendingHashtagDto.fromJson(Map<String, dynamic> json) => _$TrendingHashtagDtoFromJson(json);

@override@JsonKey() final  String tag;
@override@JsonKey() final  int postCount;

/// Create a copy of TrendingHashtagDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendingHashtagDtoCopyWith<_TrendingHashtagDto> get copyWith => __$TrendingHashtagDtoCopyWithImpl<_TrendingHashtagDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendingHashtagDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendingHashtagDto&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.postCount, postCount) || other.postCount == postCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tag,postCount);

@override
String toString() {
  return 'TrendingHashtagDto(tag: $tag, postCount: $postCount)';
}


}

/// @nodoc
abstract mixin class _$TrendingHashtagDtoCopyWith<$Res> implements $TrendingHashtagDtoCopyWith<$Res> {
  factory _$TrendingHashtagDtoCopyWith(_TrendingHashtagDto value, $Res Function(_TrendingHashtagDto) _then) = __$TrendingHashtagDtoCopyWithImpl;
@override @useResult
$Res call({
 String tag, int postCount
});




}
/// @nodoc
class __$TrendingHashtagDtoCopyWithImpl<$Res>
    implements _$TrendingHashtagDtoCopyWith<$Res> {
  __$TrendingHashtagDtoCopyWithImpl(this._self, this._then);

  final _TrendingHashtagDto _self;
  final $Res Function(_TrendingHashtagDto) _then;

/// Create a copy of TrendingHashtagDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tag = null,Object? postCount = null,}) {
  return _then(_TrendingHashtagDto(
tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FeedResponseDto {

 List<PostDto> get posts; bool get hasMore; int? get nextPage; int? get postCount;
/// Create a copy of FeedResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedResponseDtoCopyWith<FeedResponseDto> get copyWith => _$FeedResponseDtoCopyWithImpl<FeedResponseDto>(this as FeedResponseDto, _$identity);

  /// Serializes this FeedResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedResponseDto&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage)&&(identical(other.postCount, postCount) || other.postCount == postCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(posts),hasMore,nextPage,postCount);

@override
String toString() {
  return 'FeedResponseDto(posts: $posts, hasMore: $hasMore, nextPage: $nextPage, postCount: $postCount)';
}


}

/// @nodoc
abstract mixin class $FeedResponseDtoCopyWith<$Res>  {
  factory $FeedResponseDtoCopyWith(FeedResponseDto value, $Res Function(FeedResponseDto) _then) = _$FeedResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<PostDto> posts, bool hasMore, int? nextPage, int? postCount
});




}
/// @nodoc
class _$FeedResponseDtoCopyWithImpl<$Res>
    implements $FeedResponseDtoCopyWith<$Res> {
  _$FeedResponseDtoCopyWithImpl(this._self, this._then);

  final FeedResponseDto _self;
  final $Res Function(FeedResponseDto) _then;

/// Create a copy of FeedResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? posts = null,Object? hasMore = null,Object? nextPage = freezed,Object? postCount = freezed,}) {
  return _then(_self.copyWith(
posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,postCount: freezed == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedResponseDto].
extension FeedResponseDtoPatterns on FeedResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _FeedResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _FeedResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PostDto> posts,  bool hasMore,  int? nextPage,  int? postCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedResponseDto() when $default != null:
return $default(_that.posts,_that.hasMore,_that.nextPage,_that.postCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PostDto> posts,  bool hasMore,  int? nextPage,  int? postCount)  $default,) {final _that = this;
switch (_that) {
case _FeedResponseDto():
return $default(_that.posts,_that.hasMore,_that.nextPage,_that.postCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PostDto> posts,  bool hasMore,  int? nextPage,  int? postCount)?  $default,) {final _that = this;
switch (_that) {
case _FeedResponseDto() when $default != null:
return $default(_that.posts,_that.hasMore,_that.nextPage,_that.postCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedResponseDto extends FeedResponseDto {
  const _FeedResponseDto({final  List<PostDto> posts = const <PostDto>[], this.hasMore = false, this.nextPage, this.postCount}): _posts = posts,super._();
  factory _FeedResponseDto.fromJson(Map<String, dynamic> json) => _$FeedResponseDtoFromJson(json);

 final  List<PostDto> _posts;
@override@JsonKey() List<PostDto> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;
@override final  int? postCount;

/// Create a copy of FeedResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedResponseDtoCopyWith<_FeedResponseDto> get copyWith => __$FeedResponseDtoCopyWithImpl<_FeedResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedResponseDto&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage)&&(identical(other.postCount, postCount) || other.postCount == postCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts),hasMore,nextPage,postCount);

@override
String toString() {
  return 'FeedResponseDto(posts: $posts, hasMore: $hasMore, nextPage: $nextPage, postCount: $postCount)';
}


}

/// @nodoc
abstract mixin class _$FeedResponseDtoCopyWith<$Res> implements $FeedResponseDtoCopyWith<$Res> {
  factory _$FeedResponseDtoCopyWith(_FeedResponseDto value, $Res Function(_FeedResponseDto) _then) = __$FeedResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<PostDto> posts, bool hasMore, int? nextPage, int? postCount
});




}
/// @nodoc
class __$FeedResponseDtoCopyWithImpl<$Res>
    implements _$FeedResponseDtoCopyWith<$Res> {
  __$FeedResponseDtoCopyWithImpl(this._self, this._then);

  final _FeedResponseDto _self;
  final $Res Function(_FeedResponseDto) _then;

/// Create a copy of FeedResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? posts = null,Object? hasMore = null,Object? nextPage = freezed,Object? postCount = freezed,}) {
  return _then(_FeedResponseDto(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,postCount: freezed == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DiscoverResponseDto {

 List<PostDto> get posts; List<PetSummaryDto> get suggestedPets; List<CommunityDto> get suggestedCommunities; List<LostFoundAlertDto> get alerts; bool get hasMore; int? get nextPage;
/// Create a copy of DiscoverResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoverResponseDtoCopyWith<DiscoverResponseDto> get copyWith => _$DiscoverResponseDtoCopyWithImpl<DiscoverResponseDto>(this as DiscoverResponseDto, _$identity);

  /// Serializes this DiscoverResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscoverResponseDto&&const DeepCollectionEquality().equals(other.posts, posts)&&const DeepCollectionEquality().equals(other.suggestedPets, suggestedPets)&&const DeepCollectionEquality().equals(other.suggestedCommunities, suggestedCommunities)&&const DeepCollectionEquality().equals(other.alerts, alerts)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(posts),const DeepCollectionEquality().hash(suggestedPets),const DeepCollectionEquality().hash(suggestedCommunities),const DeepCollectionEquality().hash(alerts),hasMore,nextPage);

@override
String toString() {
  return 'DiscoverResponseDto(posts: $posts, suggestedPets: $suggestedPets, suggestedCommunities: $suggestedCommunities, alerts: $alerts, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $DiscoverResponseDtoCopyWith<$Res>  {
  factory $DiscoverResponseDtoCopyWith(DiscoverResponseDto value, $Res Function(DiscoverResponseDto) _then) = _$DiscoverResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<PostDto> posts, List<PetSummaryDto> suggestedPets, List<CommunityDto> suggestedCommunities, List<LostFoundAlertDto> alerts, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$DiscoverResponseDtoCopyWithImpl<$Res>
    implements $DiscoverResponseDtoCopyWith<$Res> {
  _$DiscoverResponseDtoCopyWithImpl(this._self, this._then);

  final DiscoverResponseDto _self;
  final $Res Function(DiscoverResponseDto) _then;

/// Create a copy of DiscoverResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? posts = null,Object? suggestedPets = null,Object? suggestedCommunities = null,Object? alerts = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostDto>,suggestedPets: null == suggestedPets ? _self.suggestedPets : suggestedPets // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,suggestedCommunities: null == suggestedCommunities ? _self.suggestedCommunities : suggestedCommunities // ignore: cast_nullable_to_non_nullable
as List<CommunityDto>,alerts: null == alerts ? _self.alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<LostFoundAlertDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DiscoverResponseDto].
extension DiscoverResponseDtoPatterns on DiscoverResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscoverResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscoverResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscoverResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _DiscoverResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscoverResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _DiscoverResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PostDto> posts,  List<PetSummaryDto> suggestedPets,  List<CommunityDto> suggestedCommunities,  List<LostFoundAlertDto> alerts,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscoverResponseDto() when $default != null:
return $default(_that.posts,_that.suggestedPets,_that.suggestedCommunities,_that.alerts,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PostDto> posts,  List<PetSummaryDto> suggestedPets,  List<CommunityDto> suggestedCommunities,  List<LostFoundAlertDto> alerts,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _DiscoverResponseDto():
return $default(_that.posts,_that.suggestedPets,_that.suggestedCommunities,_that.alerts,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PostDto> posts,  List<PetSummaryDto> suggestedPets,  List<CommunityDto> suggestedCommunities,  List<LostFoundAlertDto> alerts,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _DiscoverResponseDto() when $default != null:
return $default(_that.posts,_that.suggestedPets,_that.suggestedCommunities,_that.alerts,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiscoverResponseDto extends DiscoverResponseDto {
  const _DiscoverResponseDto({final  List<PostDto> posts = const <PostDto>[], final  List<PetSummaryDto> suggestedPets = const <PetSummaryDto>[], final  List<CommunityDto> suggestedCommunities = const <CommunityDto>[], final  List<LostFoundAlertDto> alerts = const <LostFoundAlertDto>[], this.hasMore = false, this.nextPage}): _posts = posts,_suggestedPets = suggestedPets,_suggestedCommunities = suggestedCommunities,_alerts = alerts,super._();
  factory _DiscoverResponseDto.fromJson(Map<String, dynamic> json) => _$DiscoverResponseDtoFromJson(json);

 final  List<PostDto> _posts;
@override@JsonKey() List<PostDto> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

 final  List<PetSummaryDto> _suggestedPets;
@override@JsonKey() List<PetSummaryDto> get suggestedPets {
  if (_suggestedPets is EqualUnmodifiableListView) return _suggestedPets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestedPets);
}

 final  List<CommunityDto> _suggestedCommunities;
@override@JsonKey() List<CommunityDto> get suggestedCommunities {
  if (_suggestedCommunities is EqualUnmodifiableListView) return _suggestedCommunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestedCommunities);
}

 final  List<LostFoundAlertDto> _alerts;
@override@JsonKey() List<LostFoundAlertDto> get alerts {
  if (_alerts is EqualUnmodifiableListView) return _alerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alerts);
}

@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of DiscoverResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscoverResponseDtoCopyWith<_DiscoverResponseDto> get copyWith => __$DiscoverResponseDtoCopyWithImpl<_DiscoverResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscoverResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscoverResponseDto&&const DeepCollectionEquality().equals(other._posts, _posts)&&const DeepCollectionEquality().equals(other._suggestedPets, _suggestedPets)&&const DeepCollectionEquality().equals(other._suggestedCommunities, _suggestedCommunities)&&const DeepCollectionEquality().equals(other._alerts, _alerts)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts),const DeepCollectionEquality().hash(_suggestedPets),const DeepCollectionEquality().hash(_suggestedCommunities),const DeepCollectionEquality().hash(_alerts),hasMore,nextPage);

@override
String toString() {
  return 'DiscoverResponseDto(posts: $posts, suggestedPets: $suggestedPets, suggestedCommunities: $suggestedCommunities, alerts: $alerts, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$DiscoverResponseDtoCopyWith<$Res> implements $DiscoverResponseDtoCopyWith<$Res> {
  factory _$DiscoverResponseDtoCopyWith(_DiscoverResponseDto value, $Res Function(_DiscoverResponseDto) _then) = __$DiscoverResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<PostDto> posts, List<PetSummaryDto> suggestedPets, List<CommunityDto> suggestedCommunities, List<LostFoundAlertDto> alerts, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$DiscoverResponseDtoCopyWithImpl<$Res>
    implements _$DiscoverResponseDtoCopyWith<$Res> {
  __$DiscoverResponseDtoCopyWithImpl(this._self, this._then);

  final _DiscoverResponseDto _self;
  final $Res Function(_DiscoverResponseDto) _then;

/// Create a copy of DiscoverResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? posts = null,Object? suggestedPets = null,Object? suggestedCommunities = null,Object? alerts = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_DiscoverResponseDto(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostDto>,suggestedPets: null == suggestedPets ? _self._suggestedPets : suggestedPets // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,suggestedCommunities: null == suggestedCommunities ? _self._suggestedCommunities : suggestedCommunities // ignore: cast_nullable_to_non_nullable
as List<CommunityDto>,alerts: null == alerts ? _self._alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<LostFoundAlertDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CommentsResponseDto {

 List<CommentDto> get comments; bool get hasMore; int? get nextPage;
/// Create a copy of CommentsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentsResponseDtoCopyWith<CommentsResponseDto> get copyWith => _$CommentsResponseDtoCopyWithImpl<CommentsResponseDto>(this as CommentsResponseDto, _$identity);

  /// Serializes this CommentsResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentsResponseDto&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(comments),hasMore,nextPage);

@override
String toString() {
  return 'CommentsResponseDto(comments: $comments, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $CommentsResponseDtoCopyWith<$Res>  {
  factory $CommentsResponseDtoCopyWith(CommentsResponseDto value, $Res Function(CommentsResponseDto) _then) = _$CommentsResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<CommentDto> comments, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$CommentsResponseDtoCopyWithImpl<$Res>
    implements $CommentsResponseDtoCopyWith<$Res> {
  _$CommentsResponseDtoCopyWithImpl(this._self, this._then);

  final CommentsResponseDto _self;
  final $Res Function(CommentsResponseDto) _then;

/// Create a copy of CommentsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? comments = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentsResponseDto].
extension CommentsResponseDtoPatterns on CommentsResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentsResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CommentsResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommentsResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CommentDto> comments,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentsResponseDto() when $default != null:
return $default(_that.comments,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CommentDto> comments,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _CommentsResponseDto():
return $default(_that.comments,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CommentDto> comments,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _CommentsResponseDto() when $default != null:
return $default(_that.comments,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentsResponseDto extends CommentsResponseDto {
  const _CommentsResponseDto({final  List<CommentDto> comments = const <CommentDto>[], this.hasMore = false, this.nextPage}): _comments = comments,super._();
  factory _CommentsResponseDto.fromJson(Map<String, dynamic> json) => _$CommentsResponseDtoFromJson(json);

 final  List<CommentDto> _comments;
@override@JsonKey() List<CommentDto> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of CommentsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentsResponseDtoCopyWith<_CommentsResponseDto> get copyWith => __$CommentsResponseDtoCopyWithImpl<_CommentsResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentsResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentsResponseDto&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_comments),hasMore,nextPage);

@override
String toString() {
  return 'CommentsResponseDto(comments: $comments, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$CommentsResponseDtoCopyWith<$Res> implements $CommentsResponseDtoCopyWith<$Res> {
  factory _$CommentsResponseDtoCopyWith(_CommentsResponseDto value, $Res Function(_CommentsResponseDto) _then) = __$CommentsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<CommentDto> comments, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$CommentsResponseDtoCopyWithImpl<$Res>
    implements _$CommentsResponseDtoCopyWith<$Res> {
  __$CommentsResponseDtoCopyWithImpl(this._self, this._then);

  final _CommentsResponseDto _self;
  final $Res Function(_CommentsResponseDto) _then;

/// Create a copy of CommentsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? comments = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_CommentsResponseDto(
comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PetPageDto {

 List<PetSummaryDto> get followers; List<PetSummaryDto> get following; List<PetSummaryDto> get blockedPets; int get count; bool get hasMore; int? get nextPage;
/// Create a copy of PetPageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PetPageDtoCopyWith<PetPageDto> get copyWith => _$PetPageDtoCopyWithImpl<PetPageDto>(this as PetPageDto, _$identity);

  /// Serializes this PetPageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PetPageDto&&const DeepCollectionEquality().equals(other.followers, followers)&&const DeepCollectionEquality().equals(other.following, following)&&const DeepCollectionEquality().equals(other.blockedPets, blockedPets)&&(identical(other.count, count) || other.count == count)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(followers),const DeepCollectionEquality().hash(following),const DeepCollectionEquality().hash(blockedPets),count,hasMore,nextPage);

@override
String toString() {
  return 'PetPageDto(followers: $followers, following: $following, blockedPets: $blockedPets, count: $count, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $PetPageDtoCopyWith<$Res>  {
  factory $PetPageDtoCopyWith(PetPageDto value, $Res Function(PetPageDto) _then) = _$PetPageDtoCopyWithImpl;
@useResult
$Res call({
 List<PetSummaryDto> followers, List<PetSummaryDto> following, List<PetSummaryDto> blockedPets, int count, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$PetPageDtoCopyWithImpl<$Res>
    implements $PetPageDtoCopyWith<$Res> {
  _$PetPageDtoCopyWithImpl(this._self, this._then);

  final PetPageDto _self;
  final $Res Function(PetPageDto) _then;

/// Create a copy of PetPageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? followers = null,Object? following = null,Object? blockedPets = null,Object? count = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,blockedPets: null == blockedPets ? _self.blockedPets : blockedPets // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PetPageDto].
extension PetPageDtoPatterns on PetPageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PetPageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PetPageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PetPageDto value)  $default,){
final _that = this;
switch (_that) {
case _PetPageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PetPageDto value)?  $default,){
final _that = this;
switch (_that) {
case _PetPageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PetSummaryDto> followers,  List<PetSummaryDto> following,  List<PetSummaryDto> blockedPets,  int count,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PetPageDto() when $default != null:
return $default(_that.followers,_that.following,_that.blockedPets,_that.count,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PetSummaryDto> followers,  List<PetSummaryDto> following,  List<PetSummaryDto> blockedPets,  int count,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _PetPageDto():
return $default(_that.followers,_that.following,_that.blockedPets,_that.count,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PetSummaryDto> followers,  List<PetSummaryDto> following,  List<PetSummaryDto> blockedPets,  int count,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _PetPageDto() when $default != null:
return $default(_that.followers,_that.following,_that.blockedPets,_that.count,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PetPageDto extends PetPageDto {
  const _PetPageDto({final  List<PetSummaryDto> followers = const <PetSummaryDto>[], final  List<PetSummaryDto> following = const <PetSummaryDto>[], final  List<PetSummaryDto> blockedPets = const <PetSummaryDto>[], this.count = 0, this.hasMore = false, this.nextPage}): _followers = followers,_following = following,_blockedPets = blockedPets,super._();
  factory _PetPageDto.fromJson(Map<String, dynamic> json) => _$PetPageDtoFromJson(json);

 final  List<PetSummaryDto> _followers;
@override@JsonKey() List<PetSummaryDto> get followers {
  if (_followers is EqualUnmodifiableListView) return _followers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_followers);
}

 final  List<PetSummaryDto> _following;
@override@JsonKey() List<PetSummaryDto> get following {
  if (_following is EqualUnmodifiableListView) return _following;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_following);
}

 final  List<PetSummaryDto> _blockedPets;
@override@JsonKey() List<PetSummaryDto> get blockedPets {
  if (_blockedPets is EqualUnmodifiableListView) return _blockedPets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blockedPets);
}

@override@JsonKey() final  int count;
@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of PetPageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PetPageDtoCopyWith<_PetPageDto> get copyWith => __$PetPageDtoCopyWithImpl<_PetPageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PetPageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PetPageDto&&const DeepCollectionEquality().equals(other._followers, _followers)&&const DeepCollectionEquality().equals(other._following, _following)&&const DeepCollectionEquality().equals(other._blockedPets, _blockedPets)&&(identical(other.count, count) || other.count == count)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_followers),const DeepCollectionEquality().hash(_following),const DeepCollectionEquality().hash(_blockedPets),count,hasMore,nextPage);

@override
String toString() {
  return 'PetPageDto(followers: $followers, following: $following, blockedPets: $blockedPets, count: $count, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$PetPageDtoCopyWith<$Res> implements $PetPageDtoCopyWith<$Res> {
  factory _$PetPageDtoCopyWith(_PetPageDto value, $Res Function(_PetPageDto) _then) = __$PetPageDtoCopyWithImpl;
@override @useResult
$Res call({
 List<PetSummaryDto> followers, List<PetSummaryDto> following, List<PetSummaryDto> blockedPets, int count, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$PetPageDtoCopyWithImpl<$Res>
    implements _$PetPageDtoCopyWith<$Res> {
  __$PetPageDtoCopyWithImpl(this._self, this._then);

  final _PetPageDto _self;
  final $Res Function(_PetPageDto) _then;

/// Create a copy of PetPageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? followers = null,Object? following = null,Object? blockedPets = null,Object? count = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_PetPageDto(
followers: null == followers ? _self._followers : followers // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,following: null == following ? _self._following : following // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,blockedPets: null == blockedPets ? _self._blockedPets : blockedPets // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SuggestedPetsResponseDto {

 List<PetSummaryDto> get suggestedPets;
/// Create a copy of SuggestedPetsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuggestedPetsResponseDtoCopyWith<SuggestedPetsResponseDto> get copyWith => _$SuggestedPetsResponseDtoCopyWithImpl<SuggestedPetsResponseDto>(this as SuggestedPetsResponseDto, _$identity);

  /// Serializes this SuggestedPetsResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuggestedPetsResponseDto&&const DeepCollectionEquality().equals(other.suggestedPets, suggestedPets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(suggestedPets));

@override
String toString() {
  return 'SuggestedPetsResponseDto(suggestedPets: $suggestedPets)';
}


}

/// @nodoc
abstract mixin class $SuggestedPetsResponseDtoCopyWith<$Res>  {
  factory $SuggestedPetsResponseDtoCopyWith(SuggestedPetsResponseDto value, $Res Function(SuggestedPetsResponseDto) _then) = _$SuggestedPetsResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<PetSummaryDto> suggestedPets
});




}
/// @nodoc
class _$SuggestedPetsResponseDtoCopyWithImpl<$Res>
    implements $SuggestedPetsResponseDtoCopyWith<$Res> {
  _$SuggestedPetsResponseDtoCopyWithImpl(this._self, this._then);

  final SuggestedPetsResponseDto _self;
  final $Res Function(SuggestedPetsResponseDto) _then;

/// Create a copy of SuggestedPetsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestedPets = null,}) {
  return _then(_self.copyWith(
suggestedPets: null == suggestedPets ? _self.suggestedPets : suggestedPets // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [SuggestedPetsResponseDto].
extension SuggestedPetsResponseDtoPatterns on SuggestedPetsResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuggestedPetsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuggestedPetsResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuggestedPetsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _SuggestedPetsResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuggestedPetsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _SuggestedPetsResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PetSummaryDto> suggestedPets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuggestedPetsResponseDto() when $default != null:
return $default(_that.suggestedPets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PetSummaryDto> suggestedPets)  $default,) {final _that = this;
switch (_that) {
case _SuggestedPetsResponseDto():
return $default(_that.suggestedPets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PetSummaryDto> suggestedPets)?  $default,) {final _that = this;
switch (_that) {
case _SuggestedPetsResponseDto() when $default != null:
return $default(_that.suggestedPets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SuggestedPetsResponseDto extends SuggestedPetsResponseDto {
  const _SuggestedPetsResponseDto({final  List<PetSummaryDto> suggestedPets = const <PetSummaryDto>[]}): _suggestedPets = suggestedPets,super._();
  factory _SuggestedPetsResponseDto.fromJson(Map<String, dynamic> json) => _$SuggestedPetsResponseDtoFromJson(json);

 final  List<PetSummaryDto> _suggestedPets;
@override@JsonKey() List<PetSummaryDto> get suggestedPets {
  if (_suggestedPets is EqualUnmodifiableListView) return _suggestedPets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestedPets);
}


/// Create a copy of SuggestedPetsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuggestedPetsResponseDtoCopyWith<_SuggestedPetsResponseDto> get copyWith => __$SuggestedPetsResponseDtoCopyWithImpl<_SuggestedPetsResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuggestedPetsResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuggestedPetsResponseDto&&const DeepCollectionEquality().equals(other._suggestedPets, _suggestedPets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_suggestedPets));

@override
String toString() {
  return 'SuggestedPetsResponseDto(suggestedPets: $suggestedPets)';
}


}

/// @nodoc
abstract mixin class _$SuggestedPetsResponseDtoCopyWith<$Res> implements $SuggestedPetsResponseDtoCopyWith<$Res> {
  factory _$SuggestedPetsResponseDtoCopyWith(_SuggestedPetsResponseDto value, $Res Function(_SuggestedPetsResponseDto) _then) = __$SuggestedPetsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<PetSummaryDto> suggestedPets
});




}
/// @nodoc
class __$SuggestedPetsResponseDtoCopyWithImpl<$Res>
    implements _$SuggestedPetsResponseDtoCopyWith<$Res> {
  __$SuggestedPetsResponseDtoCopyWithImpl(this._self, this._then);

  final _SuggestedPetsResponseDto _self;
  final $Res Function(_SuggestedPetsResponseDto) _then;

/// Create a copy of SuggestedPetsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestedPets = null,}) {
  return _then(_SuggestedPetsResponseDto(
suggestedPets: null == suggestedPets ? _self._suggestedPets : suggestedPets // ignore: cast_nullable_to_non_nullable
as List<PetSummaryDto>,
  ));
}


}


/// @nodoc
mixin _$NotificationsResponseDto {

 List<NotificationDto> get notifications; int get unreadCount; bool get hasMore; int? get nextPage;
/// Create a copy of NotificationsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsResponseDtoCopyWith<NotificationsResponseDto> get copyWith => _$NotificationsResponseDtoCopyWithImpl<NotificationsResponseDto>(this as NotificationsResponseDto, _$identity);

  /// Serializes this NotificationsResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsResponseDto&&const DeepCollectionEquality().equals(other.notifications, notifications)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notifications),unreadCount,hasMore,nextPage);

@override
String toString() {
  return 'NotificationsResponseDto(notifications: $notifications, unreadCount: $unreadCount, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $NotificationsResponseDtoCopyWith<$Res>  {
  factory $NotificationsResponseDtoCopyWith(NotificationsResponseDto value, $Res Function(NotificationsResponseDto) _then) = _$NotificationsResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<NotificationDto> notifications, int unreadCount, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$NotificationsResponseDtoCopyWithImpl<$Res>
    implements $NotificationsResponseDtoCopyWith<$Res> {
  _$NotificationsResponseDtoCopyWithImpl(this._self, this._then);

  final NotificationsResponseDto _self;
  final $Res Function(NotificationsResponseDto) _then;

/// Create a copy of NotificationsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notifications = null,Object? unreadCount = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationDto>,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationsResponseDto].
extension NotificationsResponseDtoPatterns on NotificationsResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationsResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _NotificationsResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationsResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationDto> notifications,  int unreadCount,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationsResponseDto() when $default != null:
return $default(_that.notifications,_that.unreadCount,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationDto> notifications,  int unreadCount,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _NotificationsResponseDto():
return $default(_that.notifications,_that.unreadCount,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationDto> notifications,  int unreadCount,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _NotificationsResponseDto() when $default != null:
return $default(_that.notifications,_that.unreadCount,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationsResponseDto extends NotificationsResponseDto {
  const _NotificationsResponseDto({final  List<NotificationDto> notifications = const <NotificationDto>[], this.unreadCount = 0, this.hasMore = false, this.nextPage}): _notifications = notifications,super._();
  factory _NotificationsResponseDto.fromJson(Map<String, dynamic> json) => _$NotificationsResponseDtoFromJson(json);

 final  List<NotificationDto> _notifications;
@override@JsonKey() List<NotificationDto> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}

@override@JsonKey() final  int unreadCount;
@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of NotificationsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsResponseDtoCopyWith<_NotificationsResponseDto> get copyWith => __$NotificationsResponseDtoCopyWithImpl<_NotificationsResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationsResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsResponseDto&&const DeepCollectionEquality().equals(other._notifications, _notifications)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notifications),unreadCount,hasMore,nextPage);

@override
String toString() {
  return 'NotificationsResponseDto(notifications: $notifications, unreadCount: $unreadCount, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$NotificationsResponseDtoCopyWith<$Res> implements $NotificationsResponseDtoCopyWith<$Res> {
  factory _$NotificationsResponseDtoCopyWith(_NotificationsResponseDto value, $Res Function(_NotificationsResponseDto) _then) = __$NotificationsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationDto> notifications, int unreadCount, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$NotificationsResponseDtoCopyWithImpl<$Res>
    implements _$NotificationsResponseDtoCopyWith<$Res> {
  __$NotificationsResponseDtoCopyWithImpl(this._self, this._then);

  final _NotificationsResponseDto _self;
  final $Res Function(_NotificationsResponseDto) _then;

/// Create a copy of NotificationsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notifications = null,Object? unreadCount = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_NotificationsResponseDto(
notifications: null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationDto>,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$HashtagFeedResponseDto {

 String get hashtag; int get postCount; List<PostDto> get posts; bool get hasMore; int? get nextPage;
/// Create a copy of HashtagFeedResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HashtagFeedResponseDtoCopyWith<HashtagFeedResponseDto> get copyWith => _$HashtagFeedResponseDtoCopyWithImpl<HashtagFeedResponseDto>(this as HashtagFeedResponseDto, _$identity);

  /// Serializes this HashtagFeedResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HashtagFeedResponseDto&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.postCount, postCount) || other.postCount == postCount)&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hashtag,postCount,const DeepCollectionEquality().hash(posts),hasMore,nextPage);

@override
String toString() {
  return 'HashtagFeedResponseDto(hashtag: $hashtag, postCount: $postCount, posts: $posts, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $HashtagFeedResponseDtoCopyWith<$Res>  {
  factory $HashtagFeedResponseDtoCopyWith(HashtagFeedResponseDto value, $Res Function(HashtagFeedResponseDto) _then) = _$HashtagFeedResponseDtoCopyWithImpl;
@useResult
$Res call({
 String hashtag, int postCount, List<PostDto> posts, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$HashtagFeedResponseDtoCopyWithImpl<$Res>
    implements $HashtagFeedResponseDtoCopyWith<$Res> {
  _$HashtagFeedResponseDtoCopyWithImpl(this._self, this._then);

  final HashtagFeedResponseDto _self;
  final $Res Function(HashtagFeedResponseDto) _then;

/// Create a copy of HashtagFeedResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hashtag = null,Object? postCount = null,Object? posts = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
hashtag: null == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [HashtagFeedResponseDto].
extension HashtagFeedResponseDtoPatterns on HashtagFeedResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HashtagFeedResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HashtagFeedResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HashtagFeedResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _HashtagFeedResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HashtagFeedResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _HashtagFeedResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String hashtag,  int postCount,  List<PostDto> posts,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HashtagFeedResponseDto() when $default != null:
return $default(_that.hashtag,_that.postCount,_that.posts,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String hashtag,  int postCount,  List<PostDto> posts,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _HashtagFeedResponseDto():
return $default(_that.hashtag,_that.postCount,_that.posts,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String hashtag,  int postCount,  List<PostDto> posts,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _HashtagFeedResponseDto() when $default != null:
return $default(_that.hashtag,_that.postCount,_that.posts,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HashtagFeedResponseDto extends HashtagFeedResponseDto {
  const _HashtagFeedResponseDto({this.hashtag = '', this.postCount = 0, final  List<PostDto> posts = const <PostDto>[], this.hasMore = false, this.nextPage}): _posts = posts,super._();
  factory _HashtagFeedResponseDto.fromJson(Map<String, dynamic> json) => _$HashtagFeedResponseDtoFromJson(json);

@override@JsonKey() final  String hashtag;
@override@JsonKey() final  int postCount;
 final  List<PostDto> _posts;
@override@JsonKey() List<PostDto> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of HashtagFeedResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HashtagFeedResponseDtoCopyWith<_HashtagFeedResponseDto> get copyWith => __$HashtagFeedResponseDtoCopyWithImpl<_HashtagFeedResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HashtagFeedResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HashtagFeedResponseDto&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.postCount, postCount) || other.postCount == postCount)&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hashtag,postCount,const DeepCollectionEquality().hash(_posts),hasMore,nextPage);

@override
String toString() {
  return 'HashtagFeedResponseDto(hashtag: $hashtag, postCount: $postCount, posts: $posts, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$HashtagFeedResponseDtoCopyWith<$Res> implements $HashtagFeedResponseDtoCopyWith<$Res> {
  factory _$HashtagFeedResponseDtoCopyWith(_HashtagFeedResponseDto value, $Res Function(_HashtagFeedResponseDto) _then) = __$HashtagFeedResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String hashtag, int postCount, List<PostDto> posts, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$HashtagFeedResponseDtoCopyWithImpl<$Res>
    implements _$HashtagFeedResponseDtoCopyWith<$Res> {
  __$HashtagFeedResponseDtoCopyWithImpl(this._self, this._then);

  final _HashtagFeedResponseDto _self;
  final $Res Function(_HashtagFeedResponseDto) _then;

/// Create a copy of HashtagFeedResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hashtag = null,Object? postCount = null,Object? posts = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_HashtagFeedResponseDto(
hashtag: null == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SearchResponseDto {

 List<SearchResultDto> get results; bool get hasMore; int? get nextPage;
/// Create a copy of SearchResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResponseDtoCopyWith<SearchResponseDto> get copyWith => _$SearchResponseDtoCopyWithImpl<SearchResponseDto>(this as SearchResponseDto, _$identity);

  /// Serializes this SearchResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResponseDto&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(results),hasMore,nextPage);

@override
String toString() {
  return 'SearchResponseDto(results: $results, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $SearchResponseDtoCopyWith<$Res>  {
  factory $SearchResponseDtoCopyWith(SearchResponseDto value, $Res Function(SearchResponseDto) _then) = _$SearchResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<SearchResultDto> results, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$SearchResponseDtoCopyWithImpl<$Res>
    implements $SearchResponseDtoCopyWith<$Res> {
  _$SearchResponseDtoCopyWithImpl(this._self, this._then);

  final SearchResponseDto _self;
  final $Res Function(SearchResponseDto) _then;

/// Create a copy of SearchResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<SearchResultDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchResponseDto].
extension SearchResponseDtoPatterns on SearchResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _SearchResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SearchResultDto> results,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResponseDto() when $default != null:
return $default(_that.results,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SearchResultDto> results,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _SearchResponseDto():
return $default(_that.results,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SearchResultDto> results,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _SearchResponseDto() when $default != null:
return $default(_that.results,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchResponseDto extends SearchResponseDto {
  const _SearchResponseDto({final  List<SearchResultDto> results = const <SearchResultDto>[], this.hasMore = false, this.nextPage}): _results = results,super._();
  factory _SearchResponseDto.fromJson(Map<String, dynamic> json) => _$SearchResponseDtoFromJson(json);

 final  List<SearchResultDto> _results;
@override@JsonKey() List<SearchResultDto> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of SearchResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResponseDtoCopyWith<_SearchResponseDto> get copyWith => __$SearchResponseDtoCopyWithImpl<_SearchResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResponseDto&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),hasMore,nextPage);

@override
String toString() {
  return 'SearchResponseDto(results: $results, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$SearchResponseDtoCopyWith<$Res> implements $SearchResponseDtoCopyWith<$Res> {
  factory _$SearchResponseDtoCopyWith(_SearchResponseDto value, $Res Function(_SearchResponseDto) _then) = __$SearchResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<SearchResultDto> results, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$SearchResponseDtoCopyWithImpl<$Res>
    implements _$SearchResponseDtoCopyWith<$Res> {
  __$SearchResponseDtoCopyWithImpl(this._self, this._then);

  final _SearchResponseDto _self;
  final $Res Function(_SearchResponseDto) _then;

/// Create a copy of SearchResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_SearchResponseDto(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<SearchResultDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TrendingResponseDto {

 List<TrendingHashtagDto> get trendingHashtags; List<PostDto> get trendingPosts;
/// Create a copy of TrendingResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendingResponseDtoCopyWith<TrendingResponseDto> get copyWith => _$TrendingResponseDtoCopyWithImpl<TrendingResponseDto>(this as TrendingResponseDto, _$identity);

  /// Serializes this TrendingResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendingResponseDto&&const DeepCollectionEquality().equals(other.trendingHashtags, trendingHashtags)&&const DeepCollectionEquality().equals(other.trendingPosts, trendingPosts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(trendingHashtags),const DeepCollectionEquality().hash(trendingPosts));

@override
String toString() {
  return 'TrendingResponseDto(trendingHashtags: $trendingHashtags, trendingPosts: $trendingPosts)';
}


}

/// @nodoc
abstract mixin class $TrendingResponseDtoCopyWith<$Res>  {
  factory $TrendingResponseDtoCopyWith(TrendingResponseDto value, $Res Function(TrendingResponseDto) _then) = _$TrendingResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<TrendingHashtagDto> trendingHashtags, List<PostDto> trendingPosts
});




}
/// @nodoc
class _$TrendingResponseDtoCopyWithImpl<$Res>
    implements $TrendingResponseDtoCopyWith<$Res> {
  _$TrendingResponseDtoCopyWithImpl(this._self, this._then);

  final TrendingResponseDto _self;
  final $Res Function(TrendingResponseDto) _then;

/// Create a copy of TrendingResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trendingHashtags = null,Object? trendingPosts = null,}) {
  return _then(_self.copyWith(
trendingHashtags: null == trendingHashtags ? _self.trendingHashtags : trendingHashtags // ignore: cast_nullable_to_non_nullable
as List<TrendingHashtagDto>,trendingPosts: null == trendingPosts ? _self.trendingPosts : trendingPosts // ignore: cast_nullable_to_non_nullable
as List<PostDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendingResponseDto].
extension TrendingResponseDtoPatterns on TrendingResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendingResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendingResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendingResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _TrendingResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendingResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _TrendingResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TrendingHashtagDto> trendingHashtags,  List<PostDto> trendingPosts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendingResponseDto() when $default != null:
return $default(_that.trendingHashtags,_that.trendingPosts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TrendingHashtagDto> trendingHashtags,  List<PostDto> trendingPosts)  $default,) {final _that = this;
switch (_that) {
case _TrendingResponseDto():
return $default(_that.trendingHashtags,_that.trendingPosts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TrendingHashtagDto> trendingHashtags,  List<PostDto> trendingPosts)?  $default,) {final _that = this;
switch (_that) {
case _TrendingResponseDto() when $default != null:
return $default(_that.trendingHashtags,_that.trendingPosts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendingResponseDto extends TrendingResponseDto {
  const _TrendingResponseDto({final  List<TrendingHashtagDto> trendingHashtags = const <TrendingHashtagDto>[], final  List<PostDto> trendingPosts = const <PostDto>[]}): _trendingHashtags = trendingHashtags,_trendingPosts = trendingPosts,super._();
  factory _TrendingResponseDto.fromJson(Map<String, dynamic> json) => _$TrendingResponseDtoFromJson(json);

 final  List<TrendingHashtagDto> _trendingHashtags;
@override@JsonKey() List<TrendingHashtagDto> get trendingHashtags {
  if (_trendingHashtags is EqualUnmodifiableListView) return _trendingHashtags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trendingHashtags);
}

 final  List<PostDto> _trendingPosts;
@override@JsonKey() List<PostDto> get trendingPosts {
  if (_trendingPosts is EqualUnmodifiableListView) return _trendingPosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trendingPosts);
}


/// Create a copy of TrendingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendingResponseDtoCopyWith<_TrendingResponseDto> get copyWith => __$TrendingResponseDtoCopyWithImpl<_TrendingResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendingResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendingResponseDto&&const DeepCollectionEquality().equals(other._trendingHashtags, _trendingHashtags)&&const DeepCollectionEquality().equals(other._trendingPosts, _trendingPosts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_trendingHashtags),const DeepCollectionEquality().hash(_trendingPosts));

@override
String toString() {
  return 'TrendingResponseDto(trendingHashtags: $trendingHashtags, trendingPosts: $trendingPosts)';
}


}

/// @nodoc
abstract mixin class _$TrendingResponseDtoCopyWith<$Res> implements $TrendingResponseDtoCopyWith<$Res> {
  factory _$TrendingResponseDtoCopyWith(_TrendingResponseDto value, $Res Function(_TrendingResponseDto) _then) = __$TrendingResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<TrendingHashtagDto> trendingHashtags, List<PostDto> trendingPosts
});




}
/// @nodoc
class __$TrendingResponseDtoCopyWithImpl<$Res>
    implements _$TrendingResponseDtoCopyWith<$Res> {
  __$TrendingResponseDtoCopyWithImpl(this._self, this._then);

  final _TrendingResponseDto _self;
  final $Res Function(_TrendingResponseDto) _then;

/// Create a copy of TrendingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trendingHashtags = null,Object? trendingPosts = null,}) {
  return _then(_TrendingResponseDto(
trendingHashtags: null == trendingHashtags ? _self._trendingHashtags : trendingHashtags // ignore: cast_nullable_to_non_nullable
as List<TrendingHashtagDto>,trendingPosts: null == trendingPosts ? _self._trendingPosts : trendingPosts // ignore: cast_nullable_to_non_nullable
as List<PostDto>,
  ));
}


}


/// @nodoc
mixin _$FollowResponseDto {

 int get petId; int get followers; bool get isFollowing;
/// Create a copy of FollowResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FollowResponseDtoCopyWith<FollowResponseDto> get copyWith => _$FollowResponseDtoCopyWithImpl<FollowResponseDto>(this as FollowResponseDto, _$identity);

  /// Serializes this FollowResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FollowResponseDto&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petId,followers,isFollowing);

@override
String toString() {
  return 'FollowResponseDto(petId: $petId, followers: $followers, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class $FollowResponseDtoCopyWith<$Res>  {
  factory $FollowResponseDtoCopyWith(FollowResponseDto value, $Res Function(FollowResponseDto) _then) = _$FollowResponseDtoCopyWithImpl;
@useResult
$Res call({
 int petId, int followers, bool isFollowing
});




}
/// @nodoc
class _$FollowResponseDtoCopyWithImpl<$Res>
    implements $FollowResponseDtoCopyWith<$Res> {
  _$FollowResponseDtoCopyWithImpl(this._self, this._then);

  final FollowResponseDto _self;
  final $Res Function(FollowResponseDto) _then;

/// Create a copy of FollowResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? petId = null,Object? followers = null,Object? isFollowing = null,}) {
  return _then(_self.copyWith(
petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FollowResponseDto].
extension FollowResponseDtoPatterns on FollowResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FollowResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FollowResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FollowResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _FollowResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FollowResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _FollowResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int petId,  int followers,  bool isFollowing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FollowResponseDto() when $default != null:
return $default(_that.petId,_that.followers,_that.isFollowing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int petId,  int followers,  bool isFollowing)  $default,) {final _that = this;
switch (_that) {
case _FollowResponseDto():
return $default(_that.petId,_that.followers,_that.isFollowing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int petId,  int followers,  bool isFollowing)?  $default,) {final _that = this;
switch (_that) {
case _FollowResponseDto() when $default != null:
return $default(_that.petId,_that.followers,_that.isFollowing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FollowResponseDto extends FollowResponseDto {
  const _FollowResponseDto({this.petId = 0, this.followers = 0, this.isFollowing = false}): super._();
  factory _FollowResponseDto.fromJson(Map<String, dynamic> json) => _$FollowResponseDtoFromJson(json);

@override@JsonKey() final  int petId;
@override@JsonKey() final  int followers;
@override@JsonKey() final  bool isFollowing;

/// Create a copy of FollowResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FollowResponseDtoCopyWith<_FollowResponseDto> get copyWith => __$FollowResponseDtoCopyWithImpl<_FollowResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FollowResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FollowResponseDto&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petId,followers,isFollowing);

@override
String toString() {
  return 'FollowResponseDto(petId: $petId, followers: $followers, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class _$FollowResponseDtoCopyWith<$Res> implements $FollowResponseDtoCopyWith<$Res> {
  factory _$FollowResponseDtoCopyWith(_FollowResponseDto value, $Res Function(_FollowResponseDto) _then) = __$FollowResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int petId, int followers, bool isFollowing
});




}
/// @nodoc
class __$FollowResponseDtoCopyWithImpl<$Res>
    implements _$FollowResponseDtoCopyWith<$Res> {
  __$FollowResponseDtoCopyWithImpl(this._self, this._then);

  final _FollowResponseDto _self;
  final $Res Function(_FollowResponseDto) _then;

/// Create a copy of FollowResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? petId = null,Object? followers = null,Object? isFollowing = null,}) {
  return _then(_FollowResponseDto(
petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SaveResponseDto {

 int get postId; bool get saved; int get saveCount;
/// Create a copy of SaveResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveResponseDtoCopyWith<SaveResponseDto> get copyWith => _$SaveResponseDtoCopyWithImpl<SaveResponseDto>(this as SaveResponseDto, _$identity);

  /// Serializes this SaveResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveResponseDto&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.saveCount, saveCount) || other.saveCount == saveCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,postId,saved,saveCount);

@override
String toString() {
  return 'SaveResponseDto(postId: $postId, saved: $saved, saveCount: $saveCount)';
}


}

/// @nodoc
abstract mixin class $SaveResponseDtoCopyWith<$Res>  {
  factory $SaveResponseDtoCopyWith(SaveResponseDto value, $Res Function(SaveResponseDto) _then) = _$SaveResponseDtoCopyWithImpl;
@useResult
$Res call({
 int postId, bool saved, int saveCount
});




}
/// @nodoc
class _$SaveResponseDtoCopyWithImpl<$Res>
    implements $SaveResponseDtoCopyWith<$Res> {
  _$SaveResponseDtoCopyWithImpl(this._self, this._then);

  final SaveResponseDto _self;
  final $Res Function(SaveResponseDto) _then;

/// Create a copy of SaveResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postId = null,Object? saved = null,Object? saveCount = null,}) {
  return _then(_self.copyWith(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,saveCount: null == saveCount ? _self.saveCount : saveCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SaveResponseDto].
extension SaveResponseDtoPatterns on SaveResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaveResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaveResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaveResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _SaveResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaveResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _SaveResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int postId,  bool saved,  int saveCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaveResponseDto() when $default != null:
return $default(_that.postId,_that.saved,_that.saveCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int postId,  bool saved,  int saveCount)  $default,) {final _that = this;
switch (_that) {
case _SaveResponseDto():
return $default(_that.postId,_that.saved,_that.saveCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int postId,  bool saved,  int saveCount)?  $default,) {final _that = this;
switch (_that) {
case _SaveResponseDto() when $default != null:
return $default(_that.postId,_that.saved,_that.saveCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaveResponseDto extends SaveResponseDto {
  const _SaveResponseDto({this.postId = 0, this.saved = false, this.saveCount = 0}): super._();
  factory _SaveResponseDto.fromJson(Map<String, dynamic> json) => _$SaveResponseDtoFromJson(json);

@override@JsonKey() final  int postId;
@override@JsonKey() final  bool saved;
@override@JsonKey() final  int saveCount;

/// Create a copy of SaveResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveResponseDtoCopyWith<_SaveResponseDto> get copyWith => __$SaveResponseDtoCopyWithImpl<_SaveResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaveResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveResponseDto&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.saveCount, saveCount) || other.saveCount == saveCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,postId,saved,saveCount);

@override
String toString() {
  return 'SaveResponseDto(postId: $postId, saved: $saved, saveCount: $saveCount)';
}


}

/// @nodoc
abstract mixin class _$SaveResponseDtoCopyWith<$Res> implements $SaveResponseDtoCopyWith<$Res> {
  factory _$SaveResponseDtoCopyWith(_SaveResponseDto value, $Res Function(_SaveResponseDto) _then) = __$SaveResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int postId, bool saved, int saveCount
});




}
/// @nodoc
class __$SaveResponseDtoCopyWithImpl<$Res>
    implements _$SaveResponseDtoCopyWith<$Res> {
  __$SaveResponseDtoCopyWithImpl(this._self, this._then);

  final _SaveResponseDto _self;
  final $Res Function(_SaveResponseDto) _then;

/// Create a copy of SaveResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? saved = null,Object? saveCount = null,}) {
  return _then(_SaveResponseDto(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,saveCount: null == saveCount ? _self.saveCount : saveCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ShareResponseDto {

 int get postId; String get shareUrl;
/// Create a copy of ShareResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareResponseDtoCopyWith<ShareResponseDto> get copyWith => _$ShareResponseDtoCopyWithImpl<ShareResponseDto>(this as ShareResponseDto, _$identity);

  /// Serializes this ShareResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareResponseDto&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.shareUrl, shareUrl) || other.shareUrl == shareUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,postId,shareUrl);

@override
String toString() {
  return 'ShareResponseDto(postId: $postId, shareUrl: $shareUrl)';
}


}

/// @nodoc
abstract mixin class $ShareResponseDtoCopyWith<$Res>  {
  factory $ShareResponseDtoCopyWith(ShareResponseDto value, $Res Function(ShareResponseDto) _then) = _$ShareResponseDtoCopyWithImpl;
@useResult
$Res call({
 int postId, String shareUrl
});




}
/// @nodoc
class _$ShareResponseDtoCopyWithImpl<$Res>
    implements $ShareResponseDtoCopyWith<$Res> {
  _$ShareResponseDtoCopyWithImpl(this._self, this._then);

  final ShareResponseDto _self;
  final $Res Function(ShareResponseDto) _then;

/// Create a copy of ShareResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postId = null,Object? shareUrl = null,}) {
  return _then(_self.copyWith(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,shareUrl: null == shareUrl ? _self.shareUrl : shareUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ShareResponseDto].
extension ShareResponseDtoPatterns on ShareResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShareResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShareResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShareResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ShareResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShareResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShareResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int postId,  String shareUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShareResponseDto() when $default != null:
return $default(_that.postId,_that.shareUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int postId,  String shareUrl)  $default,) {final _that = this;
switch (_that) {
case _ShareResponseDto():
return $default(_that.postId,_that.shareUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int postId,  String shareUrl)?  $default,) {final _that = this;
switch (_that) {
case _ShareResponseDto() when $default != null:
return $default(_that.postId,_that.shareUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShareResponseDto extends ShareResponseDto {
  const _ShareResponseDto({this.postId = 0, this.shareUrl = ''}): super._();
  factory _ShareResponseDto.fromJson(Map<String, dynamic> json) => _$ShareResponseDtoFromJson(json);

@override@JsonKey() final  int postId;
@override@JsonKey() final  String shareUrl;

/// Create a copy of ShareResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareResponseDtoCopyWith<_ShareResponseDto> get copyWith => __$ShareResponseDtoCopyWithImpl<_ShareResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShareResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareResponseDto&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.shareUrl, shareUrl) || other.shareUrl == shareUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,postId,shareUrl);

@override
String toString() {
  return 'ShareResponseDto(postId: $postId, shareUrl: $shareUrl)';
}


}

/// @nodoc
abstract mixin class _$ShareResponseDtoCopyWith<$Res> implements $ShareResponseDtoCopyWith<$Res> {
  factory _$ShareResponseDtoCopyWith(_ShareResponseDto value, $Res Function(_ShareResponseDto) _then) = __$ShareResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int postId, String shareUrl
});




}
/// @nodoc
class __$ShareResponseDtoCopyWithImpl<$Res>
    implements _$ShareResponseDtoCopyWith<$Res> {
  __$ShareResponseDtoCopyWithImpl(this._self, this._then);

  final _ShareResponseDto _self;
  final $Res Function(_ShareResponseDto) _then;

/// Create a copy of ShareResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? shareUrl = null,}) {
  return _then(_ShareResponseDto(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as int,shareUrl: null == shareUrl ? _self.shareUrl : shareUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LikeCountResponseDto {

 int get likes;
/// Create a copy of LikeCountResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LikeCountResponseDtoCopyWith<LikeCountResponseDto> get copyWith => _$LikeCountResponseDtoCopyWithImpl<LikeCountResponseDto>(this as LikeCountResponseDto, _$identity);

  /// Serializes this LikeCountResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LikeCountResponseDto&&(identical(other.likes, likes) || other.likes == likes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,likes);

@override
String toString() {
  return 'LikeCountResponseDto(likes: $likes)';
}


}

/// @nodoc
abstract mixin class $LikeCountResponseDtoCopyWith<$Res>  {
  factory $LikeCountResponseDtoCopyWith(LikeCountResponseDto value, $Res Function(LikeCountResponseDto) _then) = _$LikeCountResponseDtoCopyWithImpl;
@useResult
$Res call({
 int likes
});




}
/// @nodoc
class _$LikeCountResponseDtoCopyWithImpl<$Res>
    implements $LikeCountResponseDtoCopyWith<$Res> {
  _$LikeCountResponseDtoCopyWithImpl(this._self, this._then);

  final LikeCountResponseDto _self;
  final $Res Function(LikeCountResponseDto) _then;

/// Create a copy of LikeCountResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? likes = null,}) {
  return _then(_self.copyWith(
likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LikeCountResponseDto].
extension LikeCountResponseDtoPatterns on LikeCountResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LikeCountResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LikeCountResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LikeCountResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _LikeCountResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LikeCountResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _LikeCountResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int likes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LikeCountResponseDto() when $default != null:
return $default(_that.likes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int likes)  $default,) {final _that = this;
switch (_that) {
case _LikeCountResponseDto():
return $default(_that.likes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int likes)?  $default,) {final _that = this;
switch (_that) {
case _LikeCountResponseDto() when $default != null:
return $default(_that.likes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LikeCountResponseDto extends LikeCountResponseDto {
  const _LikeCountResponseDto({this.likes = 0}): super._();
  factory _LikeCountResponseDto.fromJson(Map<String, dynamic> json) => _$LikeCountResponseDtoFromJson(json);

@override@JsonKey() final  int likes;

/// Create a copy of LikeCountResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LikeCountResponseDtoCopyWith<_LikeCountResponseDto> get copyWith => __$LikeCountResponseDtoCopyWithImpl<_LikeCountResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LikeCountResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LikeCountResponseDto&&(identical(other.likes, likes) || other.likes == likes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,likes);

@override
String toString() {
  return 'LikeCountResponseDto(likes: $likes)';
}


}

/// @nodoc
abstract mixin class _$LikeCountResponseDtoCopyWith<$Res> implements $LikeCountResponseDtoCopyWith<$Res> {
  factory _$LikeCountResponseDtoCopyWith(_LikeCountResponseDto value, $Res Function(_LikeCountResponseDto) _then) = __$LikeCountResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int likes
});




}
/// @nodoc
class __$LikeCountResponseDtoCopyWithImpl<$Res>
    implements _$LikeCountResponseDtoCopyWith<$Res> {
  __$LikeCountResponseDtoCopyWithImpl(this._self, this._then);

  final _LikeCountResponseDto _self;
  final $Res Function(_LikeCountResponseDto) _then;

/// Create a copy of LikeCountResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? likes = null,}) {
  return _then(_LikeCountResponseDto(
likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PinResponseDto {

 bool get isPinned;
/// Create a copy of PinResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinResponseDtoCopyWith<PinResponseDto> get copyWith => _$PinResponseDtoCopyWithImpl<PinResponseDto>(this as PinResponseDto, _$identity);

  /// Serializes this PinResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinResponseDto&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isPinned);

@override
String toString() {
  return 'PinResponseDto(isPinned: $isPinned)';
}


}

/// @nodoc
abstract mixin class $PinResponseDtoCopyWith<$Res>  {
  factory $PinResponseDtoCopyWith(PinResponseDto value, $Res Function(PinResponseDto) _then) = _$PinResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool isPinned
});




}
/// @nodoc
class _$PinResponseDtoCopyWithImpl<$Res>
    implements $PinResponseDtoCopyWith<$Res> {
  _$PinResponseDtoCopyWithImpl(this._self, this._then);

  final PinResponseDto _self;
  final $Res Function(PinResponseDto) _then;

/// Create a copy of PinResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPinned = null,}) {
  return _then(_self.copyWith(
isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PinResponseDto].
extension PinResponseDtoPatterns on PinResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _PinResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _PinResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isPinned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinResponseDto() when $default != null:
return $default(_that.isPinned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isPinned)  $default,) {final _that = this;
switch (_that) {
case _PinResponseDto():
return $default(_that.isPinned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isPinned)?  $default,) {final _that = this;
switch (_that) {
case _PinResponseDto() when $default != null:
return $default(_that.isPinned);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PinResponseDto extends PinResponseDto {
  const _PinResponseDto({this.isPinned = false}): super._();
  factory _PinResponseDto.fromJson(Map<String, dynamic> json) => _$PinResponseDtoFromJson(json);

@override@JsonKey() final  bool isPinned;

/// Create a copy of PinResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinResponseDtoCopyWith<_PinResponseDto> get copyWith => __$PinResponseDtoCopyWithImpl<_PinResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinResponseDto&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isPinned);

@override
String toString() {
  return 'PinResponseDto(isPinned: $isPinned)';
}


}

/// @nodoc
abstract mixin class _$PinResponseDtoCopyWith<$Res> implements $PinResponseDtoCopyWith<$Res> {
  factory _$PinResponseDtoCopyWith(_PinResponseDto value, $Res Function(_PinResponseDto) _then) = __$PinResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool isPinned
});




}
/// @nodoc
class __$PinResponseDtoCopyWithImpl<$Res>
    implements _$PinResponseDtoCopyWith<$Res> {
  __$PinResponseDtoCopyWithImpl(this._self, this._then);

  final _PinResponseDto _self;
  final $Res Function(_PinResponseDto) _then;

/// Create a copy of PinResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPinned = null,}) {
  return _then(_PinResponseDto(
isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$BlockResponseDto {

 int get petId; bool get blocked;
/// Create a copy of BlockResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockResponseDtoCopyWith<BlockResponseDto> get copyWith => _$BlockResponseDtoCopyWithImpl<BlockResponseDto>(this as BlockResponseDto, _$identity);

  /// Serializes this BlockResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockResponseDto&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.blocked, blocked) || other.blocked == blocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petId,blocked);

@override
String toString() {
  return 'BlockResponseDto(petId: $petId, blocked: $blocked)';
}


}

/// @nodoc
abstract mixin class $BlockResponseDtoCopyWith<$Res>  {
  factory $BlockResponseDtoCopyWith(BlockResponseDto value, $Res Function(BlockResponseDto) _then) = _$BlockResponseDtoCopyWithImpl;
@useResult
$Res call({
 int petId, bool blocked
});




}
/// @nodoc
class _$BlockResponseDtoCopyWithImpl<$Res>
    implements $BlockResponseDtoCopyWith<$Res> {
  _$BlockResponseDtoCopyWithImpl(this._self, this._then);

  final BlockResponseDto _self;
  final $Res Function(BlockResponseDto) _then;

/// Create a copy of BlockResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? petId = null,Object? blocked = null,}) {
  return _then(_self.copyWith(
petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,blocked: null == blocked ? _self.blocked : blocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockResponseDto].
extension BlockResponseDtoPatterns on BlockResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _BlockResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _BlockResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int petId,  bool blocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockResponseDto() when $default != null:
return $default(_that.petId,_that.blocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int petId,  bool blocked)  $default,) {final _that = this;
switch (_that) {
case _BlockResponseDto():
return $default(_that.petId,_that.blocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int petId,  bool blocked)?  $default,) {final _that = this;
switch (_that) {
case _BlockResponseDto() when $default != null:
return $default(_that.petId,_that.blocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlockResponseDto extends BlockResponseDto {
  const _BlockResponseDto({this.petId = 0, this.blocked = false}): super._();
  factory _BlockResponseDto.fromJson(Map<String, dynamic> json) => _$BlockResponseDtoFromJson(json);

@override@JsonKey() final  int petId;
@override@JsonKey() final  bool blocked;

/// Create a copy of BlockResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockResponseDtoCopyWith<_BlockResponseDto> get copyWith => __$BlockResponseDtoCopyWithImpl<_BlockResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockResponseDto&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.blocked, blocked) || other.blocked == blocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,petId,blocked);

@override
String toString() {
  return 'BlockResponseDto(petId: $petId, blocked: $blocked)';
}


}

/// @nodoc
abstract mixin class _$BlockResponseDtoCopyWith<$Res> implements $BlockResponseDtoCopyWith<$Res> {
  factory _$BlockResponseDtoCopyWith(_BlockResponseDto value, $Res Function(_BlockResponseDto) _then) = __$BlockResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int petId, bool blocked
});




}
/// @nodoc
class __$BlockResponseDtoCopyWithImpl<$Res>
    implements _$BlockResponseDtoCopyWith<$Res> {
  __$BlockResponseDtoCopyWithImpl(this._self, this._then);

  final _BlockResponseDto _self;
  final $Res Function(_BlockResponseDto) _then;

/// Create a copy of BlockResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? petId = null,Object? blocked = null,}) {
  return _then(_BlockResponseDto(
petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,blocked: null == blocked ? _self.blocked : blocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ReportResponseDto {

 int get reportId; String get status;
/// Create a copy of ReportResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportResponseDtoCopyWith<ReportResponseDto> get copyWith => _$ReportResponseDtoCopyWithImpl<ReportResponseDto>(this as ReportResponseDto, _$identity);

  /// Serializes this ReportResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportResponseDto&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportId,status);

@override
String toString() {
  return 'ReportResponseDto(reportId: $reportId, status: $status)';
}


}

/// @nodoc
abstract mixin class $ReportResponseDtoCopyWith<$Res>  {
  factory $ReportResponseDtoCopyWith(ReportResponseDto value, $Res Function(ReportResponseDto) _then) = _$ReportResponseDtoCopyWithImpl;
@useResult
$Res call({
 int reportId, String status
});




}
/// @nodoc
class _$ReportResponseDtoCopyWithImpl<$Res>
    implements $ReportResponseDtoCopyWith<$Res> {
  _$ReportResponseDtoCopyWithImpl(this._self, this._then);

  final ReportResponseDto _self;
  final $Res Function(ReportResponseDto) _then;

/// Create a copy of ReportResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportId = null,Object? status = null,}) {
  return _then(_self.copyWith(
reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportResponseDto].
extension ReportResponseDtoPatterns on ReportResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ReportResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReportResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int reportId,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportResponseDto() when $default != null:
return $default(_that.reportId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int reportId,  String status)  $default,) {final _that = this;
switch (_that) {
case _ReportResponseDto():
return $default(_that.reportId,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int reportId,  String status)?  $default,) {final _that = this;
switch (_that) {
case _ReportResponseDto() when $default != null:
return $default(_that.reportId,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportResponseDto extends ReportResponseDto {
  const _ReportResponseDto({this.reportId = 0, this.status = 'open'}): super._();
  factory _ReportResponseDto.fromJson(Map<String, dynamic> json) => _$ReportResponseDtoFromJson(json);

@override@JsonKey() final  int reportId;
@override@JsonKey() final  String status;

/// Create a copy of ReportResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportResponseDtoCopyWith<_ReportResponseDto> get copyWith => __$ReportResponseDtoCopyWithImpl<_ReportResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportResponseDto&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reportId,status);

@override
String toString() {
  return 'ReportResponseDto(reportId: $reportId, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ReportResponseDtoCopyWith<$Res> implements $ReportResponseDtoCopyWith<$Res> {
  factory _$ReportResponseDtoCopyWith(_ReportResponseDto value, $Res Function(_ReportResponseDto) _then) = __$ReportResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int reportId, String status
});




}
/// @nodoc
class __$ReportResponseDtoCopyWithImpl<$Res>
    implements _$ReportResponseDtoCopyWith<$Res> {
  __$ReportResponseDtoCopyWithImpl(this._self, this._then);

  final _ReportResponseDto _self;
  final $Res Function(_ReportResponseDto) _then;

/// Create a copy of ReportResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportId = null,Object? status = null,}) {
  return _then(_ReportResponseDto(
reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MarkReadResponseDto {

 bool get isRead; int get unreadCount;
/// Create a copy of MarkReadResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkReadResponseDtoCopyWith<MarkReadResponseDto> get copyWith => _$MarkReadResponseDtoCopyWithImpl<MarkReadResponseDto>(this as MarkReadResponseDto, _$identity);

  /// Serializes this MarkReadResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkReadResponseDto&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isRead,unreadCount);

@override
String toString() {
  return 'MarkReadResponseDto(isRead: $isRead, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $MarkReadResponseDtoCopyWith<$Res>  {
  factory $MarkReadResponseDtoCopyWith(MarkReadResponseDto value, $Res Function(MarkReadResponseDto) _then) = _$MarkReadResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool isRead, int unreadCount
});




}
/// @nodoc
class _$MarkReadResponseDtoCopyWithImpl<$Res>
    implements $MarkReadResponseDtoCopyWith<$Res> {
  _$MarkReadResponseDtoCopyWithImpl(this._self, this._then);

  final MarkReadResponseDto _self;
  final $Res Function(MarkReadResponseDto) _then;

/// Create a copy of MarkReadResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isRead = null,Object? unreadCount = null,}) {
  return _then(_self.copyWith(
isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MarkReadResponseDto].
extension MarkReadResponseDtoPatterns on MarkReadResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkReadResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkReadResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkReadResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _MarkReadResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkReadResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _MarkReadResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isRead,  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarkReadResponseDto() when $default != null:
return $default(_that.isRead,_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isRead,  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _MarkReadResponseDto():
return $default(_that.isRead,_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isRead,  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _MarkReadResponseDto() when $default != null:
return $default(_that.isRead,_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarkReadResponseDto extends MarkReadResponseDto {
  const _MarkReadResponseDto({this.isRead = false, this.unreadCount = 0}): super._();
  factory _MarkReadResponseDto.fromJson(Map<String, dynamic> json) => _$MarkReadResponseDtoFromJson(json);

@override@JsonKey() final  bool isRead;
@override@JsonKey() final  int unreadCount;

/// Create a copy of MarkReadResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkReadResponseDtoCopyWith<_MarkReadResponseDto> get copyWith => __$MarkReadResponseDtoCopyWithImpl<_MarkReadResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarkReadResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkReadResponseDto&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isRead,unreadCount);

@override
String toString() {
  return 'MarkReadResponseDto(isRead: $isRead, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$MarkReadResponseDtoCopyWith<$Res> implements $MarkReadResponseDtoCopyWith<$Res> {
  factory _$MarkReadResponseDtoCopyWith(_MarkReadResponseDto value, $Res Function(_MarkReadResponseDto) _then) = __$MarkReadResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool isRead, int unreadCount
});




}
/// @nodoc
class __$MarkReadResponseDtoCopyWithImpl<$Res>
    implements _$MarkReadResponseDtoCopyWith<$Res> {
  __$MarkReadResponseDtoCopyWithImpl(this._self, this._then);

  final _MarkReadResponseDto _self;
  final $Res Function(_MarkReadResponseDto) _then;

/// Create a copy of MarkReadResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isRead = null,Object? unreadCount = null,}) {
  return _then(_MarkReadResponseDto(
isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MarkAllReadResponseDto {

 int get marked;
/// Create a copy of MarkAllReadResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkAllReadResponseDtoCopyWith<MarkAllReadResponseDto> get copyWith => _$MarkAllReadResponseDtoCopyWithImpl<MarkAllReadResponseDto>(this as MarkAllReadResponseDto, _$identity);

  /// Serializes this MarkAllReadResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkAllReadResponseDto&&(identical(other.marked, marked) || other.marked == marked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,marked);

@override
String toString() {
  return 'MarkAllReadResponseDto(marked: $marked)';
}


}

/// @nodoc
abstract mixin class $MarkAllReadResponseDtoCopyWith<$Res>  {
  factory $MarkAllReadResponseDtoCopyWith(MarkAllReadResponseDto value, $Res Function(MarkAllReadResponseDto) _then) = _$MarkAllReadResponseDtoCopyWithImpl;
@useResult
$Res call({
 int marked
});




}
/// @nodoc
class _$MarkAllReadResponseDtoCopyWithImpl<$Res>
    implements $MarkAllReadResponseDtoCopyWith<$Res> {
  _$MarkAllReadResponseDtoCopyWithImpl(this._self, this._then);

  final MarkAllReadResponseDto _self;
  final $Res Function(MarkAllReadResponseDto) _then;

/// Create a copy of MarkAllReadResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? marked = null,}) {
  return _then(_self.copyWith(
marked: null == marked ? _self.marked : marked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MarkAllReadResponseDto].
extension MarkAllReadResponseDtoPatterns on MarkAllReadResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkAllReadResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkAllReadResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkAllReadResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _MarkAllReadResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkAllReadResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _MarkAllReadResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int marked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarkAllReadResponseDto() when $default != null:
return $default(_that.marked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int marked)  $default,) {final _that = this;
switch (_that) {
case _MarkAllReadResponseDto():
return $default(_that.marked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int marked)?  $default,) {final _that = this;
switch (_that) {
case _MarkAllReadResponseDto() when $default != null:
return $default(_that.marked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarkAllReadResponseDto extends MarkAllReadResponseDto {
  const _MarkAllReadResponseDto({this.marked = 0}): super._();
  factory _MarkAllReadResponseDto.fromJson(Map<String, dynamic> json) => _$MarkAllReadResponseDtoFromJson(json);

@override@JsonKey() final  int marked;

/// Create a copy of MarkAllReadResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkAllReadResponseDtoCopyWith<_MarkAllReadResponseDto> get copyWith => __$MarkAllReadResponseDtoCopyWithImpl<_MarkAllReadResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarkAllReadResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkAllReadResponseDto&&(identical(other.marked, marked) || other.marked == marked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,marked);

@override
String toString() {
  return 'MarkAllReadResponseDto(marked: $marked)';
}


}

/// @nodoc
abstract mixin class _$MarkAllReadResponseDtoCopyWith<$Res> implements $MarkAllReadResponseDtoCopyWith<$Res> {
  factory _$MarkAllReadResponseDtoCopyWith(_MarkAllReadResponseDto value, $Res Function(_MarkAllReadResponseDto) _then) = __$MarkAllReadResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int marked
});




}
/// @nodoc
class __$MarkAllReadResponseDtoCopyWithImpl<$Res>
    implements _$MarkAllReadResponseDtoCopyWith<$Res> {
  __$MarkAllReadResponseDtoCopyWithImpl(this._self, this._then);

  final _MarkAllReadResponseDto _self;
  final $Res Function(_MarkAllReadResponseDto) _then;

/// Create a copy of MarkAllReadResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? marked = null,}) {
  return _then(_MarkAllReadResponseDto(
marked: null == marked ? _self.marked : marked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
