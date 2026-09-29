// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationDataDto {

 String? get route; String? get petId;
/// Create a copy of NotificationDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDataDtoCopyWith<NotificationDataDto> get copyWith => _$NotificationDataDtoCopyWithImpl<NotificationDataDto>(this as NotificationDataDto, _$identity);

  /// Serializes this NotificationDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDataDto&&(identical(other.route, route) || other.route == route)&&(identical(other.petId, petId) || other.petId == petId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,route,petId);

@override
String toString() {
  return 'NotificationDataDto(route: $route, petId: $petId)';
}


}

/// @nodoc
abstract mixin class $NotificationDataDtoCopyWith<$Res>  {
  factory $NotificationDataDtoCopyWith(NotificationDataDto value, $Res Function(NotificationDataDto) _then) = _$NotificationDataDtoCopyWithImpl;
@useResult
$Res call({
 String? route, String? petId
});




}
/// @nodoc
class _$NotificationDataDtoCopyWithImpl<$Res>
    implements $NotificationDataDtoCopyWith<$Res> {
  _$NotificationDataDtoCopyWithImpl(this._self, this._then);

  final NotificationDataDto _self;
  final $Res Function(NotificationDataDto) _then;

/// Create a copy of NotificationDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? route = freezed,Object? petId = freezed,}) {
  return _then(_self.copyWith(
route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationDataDto].
extension NotificationDataDtoPatterns on NotificationDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDataDto value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? route,  String? petId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationDataDto() when $default != null:
return $default(_that.route,_that.petId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? route,  String? petId)  $default,) {final _that = this;
switch (_that) {
case _NotificationDataDto():
return $default(_that.route,_that.petId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? route,  String? petId)?  $default,) {final _that = this;
switch (_that) {
case _NotificationDataDto() when $default != null:
return $default(_that.route,_that.petId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationDataDto extends NotificationDataDto {
  const _NotificationDataDto({this.route, this.petId}): super._();
  factory _NotificationDataDto.fromJson(Map<String, dynamic> json) => _$NotificationDataDtoFromJson(json);

@override final  String? route;
@override final  String? petId;

/// Create a copy of NotificationDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDataDtoCopyWith<_NotificationDataDto> get copyWith => __$NotificationDataDtoCopyWithImpl<_NotificationDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDataDto&&(identical(other.route, route) || other.route == route)&&(identical(other.petId, petId) || other.petId == petId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,route,petId);

@override
String toString() {
  return 'NotificationDataDto(route: $route, petId: $petId)';
}


}

/// @nodoc
abstract mixin class _$NotificationDataDtoCopyWith<$Res> implements $NotificationDataDtoCopyWith<$Res> {
  factory _$NotificationDataDtoCopyWith(_NotificationDataDto value, $Res Function(_NotificationDataDto) _then) = __$NotificationDataDtoCopyWithImpl;
@override @useResult
$Res call({
 String? route, String? petId
});




}
/// @nodoc
class __$NotificationDataDtoCopyWithImpl<$Res>
    implements _$NotificationDataDtoCopyWith<$Res> {
  __$NotificationDataDtoCopyWithImpl(this._self, this._then);

  final _NotificationDataDto _self;
  final $Res Function(_NotificationDataDto) _then;

/// Create a copy of NotificationDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? route = freezed,Object? petId = freezed,}) {
  return _then(_NotificationDataDto(
route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,petId: freezed == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AppNotificationDto {

 int get id; String get type; String get category; String get title; String get body; bool get isRead; DateTime get createdAt; NotificationDataDto? get data;
/// Create a copy of AppNotificationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppNotificationDtoCopyWith<AppNotificationDto> get copyWith => _$AppNotificationDtoCopyWithImpl<AppNotificationDto>(this as AppNotificationDto, _$identity);

  /// Serializes this AppNotificationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppNotificationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,category,title,body,isRead,createdAt,data);

@override
String toString() {
  return 'AppNotificationDto(id: $id, type: $type, category: $category, title: $title, body: $body, isRead: $isRead, createdAt: $createdAt, data: $data)';
}


}

/// @nodoc
abstract mixin class $AppNotificationDtoCopyWith<$Res>  {
  factory $AppNotificationDtoCopyWith(AppNotificationDto value, $Res Function(AppNotificationDto) _then) = _$AppNotificationDtoCopyWithImpl;
@useResult
$Res call({
 int id, String type, String category, String title, String body, bool isRead, DateTime createdAt, NotificationDataDto? data
});


$NotificationDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class _$AppNotificationDtoCopyWithImpl<$Res>
    implements $AppNotificationDtoCopyWith<$Res> {
  _$AppNotificationDtoCopyWithImpl(this._self, this._then);

  final AppNotificationDto _self;
  final $Res Function(AppNotificationDto) _then;

/// Create a copy of AppNotificationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? category = null,Object? title = null,Object? body = null,Object? isRead = null,Object? createdAt = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NotificationDataDto?,
  ));
}
/// Create a copy of AppNotificationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $NotificationDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppNotificationDto].
extension AppNotificationDtoPatterns on AppNotificationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppNotificationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppNotificationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppNotificationDto value)  $default,){
final _that = this;
switch (_that) {
case _AppNotificationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppNotificationDto value)?  $default,){
final _that = this;
switch (_that) {
case _AppNotificationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String category,  String title,  String body,  bool isRead,  DateTime createdAt,  NotificationDataDto? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppNotificationDto() when $default != null:
return $default(_that.id,_that.type,_that.category,_that.title,_that.body,_that.isRead,_that.createdAt,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String category,  String title,  String body,  bool isRead,  DateTime createdAt,  NotificationDataDto? data)  $default,) {final _that = this;
switch (_that) {
case _AppNotificationDto():
return $default(_that.id,_that.type,_that.category,_that.title,_that.body,_that.isRead,_that.createdAt,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String category,  String title,  String body,  bool isRead,  DateTime createdAt,  NotificationDataDto? data)?  $default,) {final _that = this;
switch (_that) {
case _AppNotificationDto() when $default != null:
return $default(_that.id,_that.type,_that.category,_that.title,_that.body,_that.isRead,_that.createdAt,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppNotificationDto extends AppNotificationDto {
  const _AppNotificationDto({required this.id, required this.type, required this.category, required this.title, required this.body, required this.isRead, required this.createdAt, this.data}): super._();
  factory _AppNotificationDto.fromJson(Map<String, dynamic> json) => _$AppNotificationDtoFromJson(json);

@override final  int id;
@override final  String type;
@override final  String category;
@override final  String title;
@override final  String body;
@override final  bool isRead;
@override final  DateTime createdAt;
@override final  NotificationDataDto? data;

/// Create a copy of AppNotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppNotificationDtoCopyWith<_AppNotificationDto> get copyWith => __$AppNotificationDtoCopyWithImpl<_AppNotificationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppNotificationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppNotificationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,category,title,body,isRead,createdAt,data);

@override
String toString() {
  return 'AppNotificationDto(id: $id, type: $type, category: $category, title: $title, body: $body, isRead: $isRead, createdAt: $createdAt, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AppNotificationDtoCopyWith<$Res> implements $AppNotificationDtoCopyWith<$Res> {
  factory _$AppNotificationDtoCopyWith(_AppNotificationDto value, $Res Function(_AppNotificationDto) _then) = __$AppNotificationDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String category, String title, String body, bool isRead, DateTime createdAt, NotificationDataDto? data
});


@override $NotificationDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class __$AppNotificationDtoCopyWithImpl<$Res>
    implements _$AppNotificationDtoCopyWith<$Res> {
  __$AppNotificationDtoCopyWithImpl(this._self, this._then);

  final _AppNotificationDto _self;
  final $Res Function(_AppNotificationDto) _then;

/// Create a copy of AppNotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? category = null,Object? title = null,Object? body = null,Object? isRead = null,Object? createdAt = null,Object? data = freezed,}) {
  return _then(_AppNotificationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NotificationDataDto?,
  ));
}

/// Create a copy of AppNotificationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $NotificationDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$NotificationPageDto {

 List<AppNotificationDto> get items; int get totalCount; int get page; int get pageSize; bool get hasMore;
/// Create a copy of NotificationPageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPageDtoCopyWith<NotificationPageDto> get copyWith => _$NotificationPageDtoCopyWithImpl<NotificationPageDto>(this as NotificationPageDto, _$identity);

  /// Serializes this NotificationPageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPageDto&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalCount,page,pageSize,hasMore);

@override
String toString() {
  return 'NotificationPageDto(items: $items, totalCount: $totalCount, page: $page, pageSize: $pageSize, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $NotificationPageDtoCopyWith<$Res>  {
  factory $NotificationPageDtoCopyWith(NotificationPageDto value, $Res Function(NotificationPageDto) _then) = _$NotificationPageDtoCopyWithImpl;
@useResult
$Res call({
 List<AppNotificationDto> items, int totalCount, int page, int pageSize, bool hasMore
});




}
/// @nodoc
class _$NotificationPageDtoCopyWithImpl<$Res>
    implements $NotificationPageDtoCopyWith<$Res> {
  _$NotificationPageDtoCopyWithImpl(this._self, this._then);

  final NotificationPageDto _self;
  final $Res Function(NotificationPageDto) _then;

/// Create a copy of NotificationPageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? page = null,Object? pageSize = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AppNotificationDto>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPageDto].
extension NotificationPageDtoPatterns on NotificationPageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPageDto value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPageDto value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AppNotificationDto> items,  int totalCount,  int page,  int pageSize,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPageDto() when $default != null:
return $default(_that.items,_that.totalCount,_that.page,_that.pageSize,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AppNotificationDto> items,  int totalCount,  int page,  int pageSize,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _NotificationPageDto():
return $default(_that.items,_that.totalCount,_that.page,_that.pageSize,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AppNotificationDto> items,  int totalCount,  int page,  int pageSize,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPageDto() when $default != null:
return $default(_that.items,_that.totalCount,_that.page,_that.pageSize,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPageDto extends NotificationPageDto {
  const _NotificationPageDto({required final  List<AppNotificationDto> items, required this.totalCount, required this.page, required this.pageSize, required this.hasMore}): _items = items,super._();
  factory _NotificationPageDto.fromJson(Map<String, dynamic> json) => _$NotificationPageDtoFromJson(json);

 final  List<AppNotificationDto> _items;
@override List<AppNotificationDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int totalCount;
@override final  int page;
@override final  int pageSize;
@override final  bool hasMore;

/// Create a copy of NotificationPageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPageDtoCopyWith<_NotificationPageDto> get copyWith => __$NotificationPageDtoCopyWithImpl<_NotificationPageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPageDto&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,page,pageSize,hasMore);

@override
String toString() {
  return 'NotificationPageDto(items: $items, totalCount: $totalCount, page: $page, pageSize: $pageSize, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$NotificationPageDtoCopyWith<$Res> implements $NotificationPageDtoCopyWith<$Res> {
  factory _$NotificationPageDtoCopyWith(_NotificationPageDto value, $Res Function(_NotificationPageDto) _then) = __$NotificationPageDtoCopyWithImpl;
@override @useResult
$Res call({
 List<AppNotificationDto> items, int totalCount, int page, int pageSize, bool hasMore
});




}
/// @nodoc
class __$NotificationPageDtoCopyWithImpl<$Res>
    implements _$NotificationPageDtoCopyWith<$Res> {
  __$NotificationPageDtoCopyWithImpl(this._self, this._then);

  final _NotificationPageDto _self;
  final $Res Function(_NotificationPageDto) _then;

/// Create a copy of NotificationPageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? page = null,Object? pageSize = null,Object? hasMore = null,}) {
  return _then(_NotificationPageDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AppNotificationDto>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UnreadCountDto {

 int get count;
/// Create a copy of UnreadCountDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnreadCountDtoCopyWith<UnreadCountDto> get copyWith => _$UnreadCountDtoCopyWithImpl<UnreadCountDto>(this as UnreadCountDto, _$identity);

  /// Serializes this UnreadCountDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnreadCountDto&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'UnreadCountDto(count: $count)';
}


}

/// @nodoc
abstract mixin class $UnreadCountDtoCopyWith<$Res>  {
  factory $UnreadCountDtoCopyWith(UnreadCountDto value, $Res Function(UnreadCountDto) _then) = _$UnreadCountDtoCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$UnreadCountDtoCopyWithImpl<$Res>
    implements $UnreadCountDtoCopyWith<$Res> {
  _$UnreadCountDtoCopyWithImpl(this._self, this._then);

  final UnreadCountDto _self;
  final $Res Function(UnreadCountDto) _then;

/// Create a copy of UnreadCountDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UnreadCountDto].
extension UnreadCountDtoPatterns on UnreadCountDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnreadCountDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnreadCountDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnreadCountDto value)  $default,){
final _that = this;
switch (_that) {
case _UnreadCountDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnreadCountDto value)?  $default,){
final _that = this;
switch (_that) {
case _UnreadCountDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnreadCountDto() when $default != null:
return $default(_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count)  $default,) {final _that = this;
switch (_that) {
case _UnreadCountDto():
return $default(_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count)?  $default,) {final _that = this;
switch (_that) {
case _UnreadCountDto() when $default != null:
return $default(_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnreadCountDto extends UnreadCountDto {
  const _UnreadCountDto({required this.count}): super._();
  factory _UnreadCountDto.fromJson(Map<String, dynamic> json) => _$UnreadCountDtoFromJson(json);

@override final  int count;

/// Create a copy of UnreadCountDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnreadCountDtoCopyWith<_UnreadCountDto> get copyWith => __$UnreadCountDtoCopyWithImpl<_UnreadCountDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnreadCountDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnreadCountDto&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'UnreadCountDto(count: $count)';
}


}

/// @nodoc
abstract mixin class _$UnreadCountDtoCopyWith<$Res> implements $UnreadCountDtoCopyWith<$Res> {
  factory _$UnreadCountDtoCopyWith(_UnreadCountDto value, $Res Function(_UnreadCountDto) _then) = __$UnreadCountDtoCopyWithImpl;
@override @useResult
$Res call({
 int count
});




}
/// @nodoc
class __$UnreadCountDtoCopyWithImpl<$Res>
    implements _$UnreadCountDtoCopyWith<$Res> {
  __$UnreadCountDtoCopyWithImpl(this._self, this._then);

  final _UnreadCountDto _self;
  final $Res Function(_UnreadCountDto) _then;

/// Create a copy of UnreadCountDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_UnreadCountDto(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
