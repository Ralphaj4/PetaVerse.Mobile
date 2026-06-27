// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadUrlRequest {

 int get category; String get contentType; String? get fileName;// Required by the backend for petAvatar/petDocument categories; the pet
// must already exist and be owned by the caller.
 int? get petId;
/// Create a copy of UploadUrlRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadUrlRequestCopyWith<UploadUrlRequest> get copyWith => _$UploadUrlRequestCopyWithImpl<UploadUrlRequest>(this as UploadUrlRequest, _$identity);

  /// Serializes this UploadUrlRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadUrlRequest&&(identical(other.category, category) || other.category == category)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.petId, petId) || other.petId == petId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,contentType,fileName,petId);

@override
String toString() {
  return 'UploadUrlRequest(category: $category, contentType: $contentType, fileName: $fileName, petId: $petId)';
}


}

/// @nodoc
abstract mixin class $UploadUrlRequestCopyWith<$Res>  {
  factory $UploadUrlRequestCopyWith(UploadUrlRequest value, $Res Function(UploadUrlRequest) _then) = _$UploadUrlRequestCopyWithImpl;
@useResult
$Res call({
 int category, String contentType, String? fileName, int? petId
});




}
/// @nodoc
class _$UploadUrlRequestCopyWithImpl<$Res>
    implements $UploadUrlRequestCopyWith<$Res> {
  _$UploadUrlRequestCopyWithImpl(this._self, this._then);

  final UploadUrlRequest _self;
  final $Res Function(UploadUrlRequest) _then;

/// Create a copy of UploadUrlRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? contentType = null,Object? fileName = freezed,Object? petId = freezed,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UploadUrlRequest].
extension UploadUrlRequestPatterns on UploadUrlRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadUrlRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadUrlRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadUrlRequest value)  $default,){
final _that = this;
switch (_that) {
case _UploadUrlRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadUrlRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UploadUrlRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int category,  String contentType,  String? fileName,  int? petId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadUrlRequest() when $default != null:
return $default(_that.category,_that.contentType,_that.fileName,_that.petId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int category,  String contentType,  String? fileName,  int? petId)  $default,) {final _that = this;
switch (_that) {
case _UploadUrlRequest():
return $default(_that.category,_that.contentType,_that.fileName,_that.petId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int category,  String contentType,  String? fileName,  int? petId)?  $default,) {final _that = this;
switch (_that) {
case _UploadUrlRequest() when $default != null:
return $default(_that.category,_that.contentType,_that.fileName,_that.petId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadUrlRequest implements UploadUrlRequest {
  const _UploadUrlRequest({required this.category, required this.contentType, this.fileName, this.petId});
  factory _UploadUrlRequest.fromJson(Map<String, dynamic> json) => _$UploadUrlRequestFromJson(json);

@override final  int category;
@override final  String contentType;
@override final  String? fileName;
// Required by the backend for petAvatar/petDocument categories; the pet
// must already exist and be owned by the caller.
@override final  int? petId;

/// Create a copy of UploadUrlRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadUrlRequestCopyWith<_UploadUrlRequest> get copyWith => __$UploadUrlRequestCopyWithImpl<_UploadUrlRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadUrlRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadUrlRequest&&(identical(other.category, category) || other.category == category)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.petId, petId) || other.petId == petId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,contentType,fileName,petId);

@override
String toString() {
  return 'UploadUrlRequest(category: $category, contentType: $contentType, fileName: $fileName, petId: $petId)';
}


}

/// @nodoc
abstract mixin class _$UploadUrlRequestCopyWith<$Res> implements $UploadUrlRequestCopyWith<$Res> {
  factory _$UploadUrlRequestCopyWith(_UploadUrlRequest value, $Res Function(_UploadUrlRequest) _then) = __$UploadUrlRequestCopyWithImpl;
@override @useResult
$Res call({
 int category, String contentType, String? fileName, int? petId
});




}
/// @nodoc
class __$UploadUrlRequestCopyWithImpl<$Res>
    implements _$UploadUrlRequestCopyWith<$Res> {
  __$UploadUrlRequestCopyWithImpl(this._self, this._then);

  final _UploadUrlRequest _self;
  final $Res Function(_UploadUrlRequest) _then;

/// Create a copy of UploadUrlRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? contentType = null,Object? fileName = freezed,Object? petId = freezed,}) {
  return _then(_UploadUrlRequest(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$UploadUrlResponse {

 String get assetId; String get uploadUrl; String get objectKey; String get contentType; DateTime get expiresAt;
/// Create a copy of UploadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadUrlResponseCopyWith<UploadUrlResponse> get copyWith => _$UploadUrlResponseCopyWithImpl<UploadUrlResponse>(this as UploadUrlResponse, _$identity);

  /// Serializes this UploadUrlResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadUrlResponse&&(identical(other.assetId, assetId) || other.assetId == assetId)&&(identical(other.uploadUrl, uploadUrl) || other.uploadUrl == uploadUrl)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetId,uploadUrl,objectKey,contentType,expiresAt);

@override
String toString() {
  return 'UploadUrlResponse(assetId: $assetId, uploadUrl: $uploadUrl, objectKey: $objectKey, contentType: $contentType, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $UploadUrlResponseCopyWith<$Res>  {
  factory $UploadUrlResponseCopyWith(UploadUrlResponse value, $Res Function(UploadUrlResponse) _then) = _$UploadUrlResponseCopyWithImpl;
@useResult
$Res call({
 String assetId, String uploadUrl, String objectKey, String contentType, DateTime expiresAt
});




}
/// @nodoc
class _$UploadUrlResponseCopyWithImpl<$Res>
    implements $UploadUrlResponseCopyWith<$Res> {
  _$UploadUrlResponseCopyWithImpl(this._self, this._then);

  final UploadUrlResponse _self;
  final $Res Function(UploadUrlResponse) _then;

/// Create a copy of UploadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assetId = null,Object? uploadUrl = null,Object? objectKey = null,Object? contentType = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
assetId: null == assetId ? _self.assetId : assetId // ignore: cast_nullable_to_non_nullable
as String,uploadUrl: null == uploadUrl ? _self.uploadUrl : uploadUrl // ignore: cast_nullable_to_non_nullable
as String,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UploadUrlResponse].
extension UploadUrlResponsePatterns on UploadUrlResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadUrlResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadUrlResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadUrlResponse value)  $default,){
final _that = this;
switch (_that) {
case _UploadUrlResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadUrlResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UploadUrlResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String assetId,  String uploadUrl,  String objectKey,  String contentType,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadUrlResponse() when $default != null:
return $default(_that.assetId,_that.uploadUrl,_that.objectKey,_that.contentType,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String assetId,  String uploadUrl,  String objectKey,  String contentType,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _UploadUrlResponse():
return $default(_that.assetId,_that.uploadUrl,_that.objectKey,_that.contentType,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String assetId,  String uploadUrl,  String objectKey,  String contentType,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _UploadUrlResponse() when $default != null:
return $default(_that.assetId,_that.uploadUrl,_that.objectKey,_that.contentType,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadUrlResponse implements UploadUrlResponse {
  const _UploadUrlResponse({required this.assetId, required this.uploadUrl, required this.objectKey, required this.contentType, required this.expiresAt});
  factory _UploadUrlResponse.fromJson(Map<String, dynamic> json) => _$UploadUrlResponseFromJson(json);

@override final  String assetId;
@override final  String uploadUrl;
@override final  String objectKey;
@override final  String contentType;
@override final  DateTime expiresAt;

/// Create a copy of UploadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadUrlResponseCopyWith<_UploadUrlResponse> get copyWith => __$UploadUrlResponseCopyWithImpl<_UploadUrlResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadUrlResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadUrlResponse&&(identical(other.assetId, assetId) || other.assetId == assetId)&&(identical(other.uploadUrl, uploadUrl) || other.uploadUrl == uploadUrl)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetId,uploadUrl,objectKey,contentType,expiresAt);

@override
String toString() {
  return 'UploadUrlResponse(assetId: $assetId, uploadUrl: $uploadUrl, objectKey: $objectKey, contentType: $contentType, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$UploadUrlResponseCopyWith<$Res> implements $UploadUrlResponseCopyWith<$Res> {
  factory _$UploadUrlResponseCopyWith(_UploadUrlResponse value, $Res Function(_UploadUrlResponse) _then) = __$UploadUrlResponseCopyWithImpl;
@override @useResult
$Res call({
 String assetId, String uploadUrl, String objectKey, String contentType, DateTime expiresAt
});




}
/// @nodoc
class __$UploadUrlResponseCopyWithImpl<$Res>
    implements _$UploadUrlResponseCopyWith<$Res> {
  __$UploadUrlResponseCopyWithImpl(this._self, this._then);

  final _UploadUrlResponse _self;
  final $Res Function(_UploadUrlResponse) _then;

/// Create a copy of UploadUrlResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assetId = null,Object? uploadUrl = null,Object? objectKey = null,Object? contentType = null,Object? expiresAt = null,}) {
  return _then(_UploadUrlResponse(
assetId: null == assetId ? _self.assetId : assetId // ignore: cast_nullable_to_non_nullable
as String,uploadUrl: null == uploadUrl ? _self.uploadUrl : uploadUrl // ignore: cast_nullable_to_non_nullable
as String,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$MediaAsset {

 String get id; int get category; String get contentType; int get sizeBytes; String? get originalFileName; String get url; DateTime get createdAt;
/// Create a copy of MediaAsset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaAssetCopyWith<MediaAsset> get copyWith => _$MediaAssetCopyWithImpl<MediaAsset>(this as MediaAsset, _$identity);

  /// Serializes this MediaAsset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaAsset&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.originalFileName, originalFileName) || other.originalFileName == originalFileName)&&(identical(other.url, url) || other.url == url)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,contentType,sizeBytes,originalFileName,url,createdAt);

@override
String toString() {
  return 'MediaAsset(id: $id, category: $category, contentType: $contentType, sizeBytes: $sizeBytes, originalFileName: $originalFileName, url: $url, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MediaAssetCopyWith<$Res>  {
  factory $MediaAssetCopyWith(MediaAsset value, $Res Function(MediaAsset) _then) = _$MediaAssetCopyWithImpl;
@useResult
$Res call({
 String id, int category, String contentType, int sizeBytes, String? originalFileName, String url, DateTime createdAt
});




}
/// @nodoc
class _$MediaAssetCopyWithImpl<$Res>
    implements $MediaAssetCopyWith<$Res> {
  _$MediaAssetCopyWithImpl(this._self, this._then);

  final MediaAsset _self;
  final $Res Function(MediaAsset) _then;

/// Create a copy of MediaAsset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? contentType = null,Object? sizeBytes = null,Object? originalFileName = freezed,Object? url = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,originalFileName: freezed == originalFileName ? _self.originalFileName : originalFileName // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaAsset].
extension MediaAssetPatterns on MediaAsset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaAsset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaAsset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaAsset value)  $default,){
final _that = this;
switch (_that) {
case _MediaAsset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaAsset value)?  $default,){
final _that = this;
switch (_that) {
case _MediaAsset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int category,  String contentType,  int sizeBytes,  String? originalFileName,  String url,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaAsset() when $default != null:
return $default(_that.id,_that.category,_that.contentType,_that.sizeBytes,_that.originalFileName,_that.url,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int category,  String contentType,  int sizeBytes,  String? originalFileName,  String url,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MediaAsset():
return $default(_that.id,_that.category,_that.contentType,_that.sizeBytes,_that.originalFileName,_that.url,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int category,  String contentType,  int sizeBytes,  String? originalFileName,  String url,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MediaAsset() when $default != null:
return $default(_that.id,_that.category,_that.contentType,_that.sizeBytes,_that.originalFileName,_that.url,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaAsset implements MediaAsset {
  const _MediaAsset({required this.id, required this.category, required this.contentType, required this.sizeBytes, this.originalFileName, required this.url, required this.createdAt});
  factory _MediaAsset.fromJson(Map<String, dynamic> json) => _$MediaAssetFromJson(json);

@override final  String id;
@override final  int category;
@override final  String contentType;
@override final  int sizeBytes;
@override final  String? originalFileName;
@override final  String url;
@override final  DateTime createdAt;

/// Create a copy of MediaAsset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaAssetCopyWith<_MediaAsset> get copyWith => __$MediaAssetCopyWithImpl<_MediaAsset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaAssetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaAsset&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.originalFileName, originalFileName) || other.originalFileName == originalFileName)&&(identical(other.url, url) || other.url == url)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,contentType,sizeBytes,originalFileName,url,createdAt);

@override
String toString() {
  return 'MediaAsset(id: $id, category: $category, contentType: $contentType, sizeBytes: $sizeBytes, originalFileName: $originalFileName, url: $url, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MediaAssetCopyWith<$Res> implements $MediaAssetCopyWith<$Res> {
  factory _$MediaAssetCopyWith(_MediaAsset value, $Res Function(_MediaAsset) _then) = __$MediaAssetCopyWithImpl;
@override @useResult
$Res call({
 String id, int category, String contentType, int sizeBytes, String? originalFileName, String url, DateTime createdAt
});




}
/// @nodoc
class __$MediaAssetCopyWithImpl<$Res>
    implements _$MediaAssetCopyWith<$Res> {
  __$MediaAssetCopyWithImpl(this._self, this._then);

  final _MediaAsset _self;
  final $Res Function(_MediaAsset) _then;

/// Create a copy of MediaAsset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? contentType = null,Object? sizeBytes = null,Object? originalFileName = freezed,Object? url = null,Object? createdAt = null,}) {
  return _then(_MediaAsset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,originalFileName: freezed == originalFileName ? _self.originalFileName : originalFileName // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
