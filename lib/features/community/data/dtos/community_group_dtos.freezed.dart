// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_group_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityDto {

 int get id; String get name; String? get handle; String? get description; String? get avatarUrl; String? get bannerUrl; int get category; PetSummaryDto get lead; int get memberCount; int get postCount;// Nullable so an explicit `null` from anonymous-viewer responses can't crash
// deserialization; coalesced to false in [toEntity].
 bool? get isMember; bool? get isLead; DateTime? get createdAt;
/// Create a copy of CommunityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityDtoCopyWith<CommunityDto> get copyWith => _$CommunityDtoCopyWithImpl<CommunityDto>(this as CommunityDto, _$identity);

  /// Serializes this CommunityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.lead, lead) || other.lead == lead)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.postCount, postCount) || other.postCount == postCount)&&(identical(other.isMember, isMember) || other.isMember == isMember)&&(identical(other.isLead, isLead) || other.isLead == isLead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,handle,description,avatarUrl,bannerUrl,category,lead,memberCount,postCount,isMember,isLead,createdAt);

@override
String toString() {
  return 'CommunityDto(id: $id, name: $name, handle: $handle, description: $description, avatarUrl: $avatarUrl, bannerUrl: $bannerUrl, category: $category, lead: $lead, memberCount: $memberCount, postCount: $postCount, isMember: $isMember, isLead: $isLead, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CommunityDtoCopyWith<$Res>  {
  factory $CommunityDtoCopyWith(CommunityDto value, $Res Function(CommunityDto) _then) = _$CommunityDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? handle, String? description, String? avatarUrl, String? bannerUrl, int category, PetSummaryDto lead, int memberCount, int postCount, bool? isMember, bool? isLead, DateTime? createdAt
});


$PetSummaryDtoCopyWith<$Res> get lead;

}
/// @nodoc
class _$CommunityDtoCopyWithImpl<$Res>
    implements $CommunityDtoCopyWith<$Res> {
  _$CommunityDtoCopyWithImpl(this._self, this._then);

  final CommunityDto _self;
  final $Res Function(CommunityDto) _then;

/// Create a copy of CommunityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? description = freezed,Object? avatarUrl = freezed,Object? bannerUrl = freezed,Object? category = null,Object? lead = null,Object? memberCount = null,Object? postCount = null,Object? isMember = freezed,Object? isLead = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,lead: null == lead ? _self.lead : lead // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,isMember: freezed == isMember ? _self.isMember : isMember // ignore: cast_nullable_to_non_nullable
as bool?,isLead: freezed == isLead ? _self.isLead : isLead // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CommunityDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get lead {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.lead, (value) {
    return _then(_self.copyWith(lead: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommunityDto].
extension CommunityDtoPatterns on CommunityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? handle,  String? description,  String? avatarUrl,  String? bannerUrl,  int category,  PetSummaryDto lead,  int memberCount,  int postCount,  bool? isMember,  bool? isLead,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityDto() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.description,_that.avatarUrl,_that.bannerUrl,_that.category,_that.lead,_that.memberCount,_that.postCount,_that.isMember,_that.isLead,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? handle,  String? description,  String? avatarUrl,  String? bannerUrl,  int category,  PetSummaryDto lead,  int memberCount,  int postCount,  bool? isMember,  bool? isLead,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityDto():
return $default(_that.id,_that.name,_that.handle,_that.description,_that.avatarUrl,_that.bannerUrl,_that.category,_that.lead,_that.memberCount,_that.postCount,_that.isMember,_that.isLead,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? handle,  String? description,  String? avatarUrl,  String? bannerUrl,  int category,  PetSummaryDto lead,  int memberCount,  int postCount,  bool? isMember,  bool? isLead,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityDto() when $default != null:
return $default(_that.id,_that.name,_that.handle,_that.description,_that.avatarUrl,_that.bannerUrl,_that.category,_that.lead,_that.memberCount,_that.postCount,_that.isMember,_that.isLead,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityDto extends CommunityDto {
  const _CommunityDto({required this.id, this.name = '', this.handle, this.description, this.avatarUrl, this.bannerUrl, this.category = 0, required this.lead, this.memberCount = 0, this.postCount = 0, this.isMember, this.isLead, this.createdAt}): super._();
  factory _CommunityDto.fromJson(Map<String, dynamic> json) => _$CommunityDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? handle;
@override final  String? description;
@override final  String? avatarUrl;
@override final  String? bannerUrl;
@override@JsonKey() final  int category;
@override final  PetSummaryDto lead;
@override@JsonKey() final  int memberCount;
@override@JsonKey() final  int postCount;
// Nullable so an explicit `null` from anonymous-viewer responses can't crash
// deserialization; coalesced to false in [toEntity].
@override final  bool? isMember;
@override final  bool? isLead;
@override final  DateTime? createdAt;

/// Create a copy of CommunityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityDtoCopyWith<_CommunityDto> get copyWith => __$CommunityDtoCopyWithImpl<_CommunityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.description, description) || other.description == description)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.lead, lead) || other.lead == lead)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.postCount, postCount) || other.postCount == postCount)&&(identical(other.isMember, isMember) || other.isMember == isMember)&&(identical(other.isLead, isLead) || other.isLead == isLead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,handle,description,avatarUrl,bannerUrl,category,lead,memberCount,postCount,isMember,isLead,createdAt);

@override
String toString() {
  return 'CommunityDto(id: $id, name: $name, handle: $handle, description: $description, avatarUrl: $avatarUrl, bannerUrl: $bannerUrl, category: $category, lead: $lead, memberCount: $memberCount, postCount: $postCount, isMember: $isMember, isLead: $isLead, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityDtoCopyWith<$Res> implements $CommunityDtoCopyWith<$Res> {
  factory _$CommunityDtoCopyWith(_CommunityDto value, $Res Function(_CommunityDto) _then) = __$CommunityDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? handle, String? description, String? avatarUrl, String? bannerUrl, int category, PetSummaryDto lead, int memberCount, int postCount, bool? isMember, bool? isLead, DateTime? createdAt
});


@override $PetSummaryDtoCopyWith<$Res> get lead;

}
/// @nodoc
class __$CommunityDtoCopyWithImpl<$Res>
    implements _$CommunityDtoCopyWith<$Res> {
  __$CommunityDtoCopyWithImpl(this._self, this._then);

  final _CommunityDto _self;
  final $Res Function(_CommunityDto) _then;

/// Create a copy of CommunityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? handle = freezed,Object? description = freezed,Object? avatarUrl = freezed,Object? bannerUrl = freezed,Object? category = null,Object? lead = null,Object? memberCount = null,Object? postCount = null,Object? isMember = freezed,Object? isLead = freezed,Object? createdAt = freezed,}) {
  return _then(_CommunityDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as int,lead: null == lead ? _self.lead : lead // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,isMember: freezed == isMember ? _self.isMember : isMember // ignore: cast_nullable_to_non_nullable
as bool?,isLead: freezed == isLead ? _self.isLead : isLead // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CommunityDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get lead {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.lead, (value) {
    return _then(_self.copyWith(lead: value));
  });
}
}


/// @nodoc
mixin _$CommunityMemberDto {

 PetSummaryDto get pet; int get role; DateTime? get joinedAt;
/// Create a copy of CommunityMemberDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityMemberDtoCopyWith<CommunityMemberDto> get copyWith => _$CommunityMemberDtoCopyWithImpl<CommunityMemberDto>(this as CommunityMemberDto, _$identity);

  /// Serializes this CommunityMemberDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityMemberDto&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pet,role,joinedAt);

@override
String toString() {
  return 'CommunityMemberDto(pet: $pet, role: $role, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $CommunityMemberDtoCopyWith<$Res>  {
  factory $CommunityMemberDtoCopyWith(CommunityMemberDto value, $Res Function(CommunityMemberDto) _then) = _$CommunityMemberDtoCopyWithImpl;
@useResult
$Res call({
 PetSummaryDto pet, int role, DateTime? joinedAt
});


$PetSummaryDtoCopyWith<$Res> get pet;

}
/// @nodoc
class _$CommunityMemberDtoCopyWithImpl<$Res>
    implements $CommunityMemberDtoCopyWith<$Res> {
  _$CommunityMemberDtoCopyWithImpl(this._self, this._then);

  final CommunityMemberDto _self;
  final $Res Function(CommunityMemberDto) _then;

/// Create a copy of CommunityMemberDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pet = null,Object? role = null,Object? joinedAt = freezed,}) {
  return _then(_self.copyWith(
pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CommunityMemberDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get pet {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommunityMemberDto].
extension CommunityMemberDtoPatterns on CommunityMemberDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityMemberDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityMemberDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityMemberDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityMemberDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityMemberDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityMemberDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PetSummaryDto pet,  int role,  DateTime? joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityMemberDto() when $default != null:
return $default(_that.pet,_that.role,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PetSummaryDto pet,  int role,  DateTime? joinedAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityMemberDto():
return $default(_that.pet,_that.role,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PetSummaryDto pet,  int role,  DateTime? joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityMemberDto() when $default != null:
return $default(_that.pet,_that.role,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityMemberDto extends CommunityMemberDto {
  const _CommunityMemberDto({required this.pet, this.role = 1, this.joinedAt}): super._();
  factory _CommunityMemberDto.fromJson(Map<String, dynamic> json) => _$CommunityMemberDtoFromJson(json);

@override final  PetSummaryDto pet;
@override@JsonKey() final  int role;
@override final  DateTime? joinedAt;

/// Create a copy of CommunityMemberDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityMemberDtoCopyWith<_CommunityMemberDto> get copyWith => __$CommunityMemberDtoCopyWithImpl<_CommunityMemberDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityMemberDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityMemberDto&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pet,role,joinedAt);

@override
String toString() {
  return 'CommunityMemberDto(pet: $pet, role: $role, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityMemberDtoCopyWith<$Res> implements $CommunityMemberDtoCopyWith<$Res> {
  factory _$CommunityMemberDtoCopyWith(_CommunityMemberDto value, $Res Function(_CommunityMemberDto) _then) = __$CommunityMemberDtoCopyWithImpl;
@override @useResult
$Res call({
 PetSummaryDto pet, int role, DateTime? joinedAt
});


@override $PetSummaryDtoCopyWith<$Res> get pet;

}
/// @nodoc
class __$CommunityMemberDtoCopyWithImpl<$Res>
    implements _$CommunityMemberDtoCopyWith<$Res> {
  __$CommunityMemberDtoCopyWithImpl(this._self, this._then);

  final _CommunityMemberDto _self;
  final $Res Function(_CommunityMemberDto) _then;

/// Create a copy of CommunityMemberDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pet = null,Object? role = null,Object? joinedAt = freezed,}) {
  return _then(_CommunityMemberDto(
pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CommunityMemberDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get pet {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}
}


/// @nodoc
mixin _$CommunityDirectoryResponseDto {

 List<CommunityDto> get communities; int? get total; bool get hasMore; int? get nextPage;
/// Create a copy of CommunityDirectoryResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityDirectoryResponseDtoCopyWith<CommunityDirectoryResponseDto> get copyWith => _$CommunityDirectoryResponseDtoCopyWithImpl<CommunityDirectoryResponseDto>(this as CommunityDirectoryResponseDto, _$identity);

  /// Serializes this CommunityDirectoryResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityDirectoryResponseDto&&const DeepCollectionEquality().equals(other.communities, communities)&&(identical(other.total, total) || other.total == total)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(communities),total,hasMore,nextPage);

@override
String toString() {
  return 'CommunityDirectoryResponseDto(communities: $communities, total: $total, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $CommunityDirectoryResponseDtoCopyWith<$Res>  {
  factory $CommunityDirectoryResponseDtoCopyWith(CommunityDirectoryResponseDto value, $Res Function(CommunityDirectoryResponseDto) _then) = _$CommunityDirectoryResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<CommunityDto> communities, int? total, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$CommunityDirectoryResponseDtoCopyWithImpl<$Res>
    implements $CommunityDirectoryResponseDtoCopyWith<$Res> {
  _$CommunityDirectoryResponseDtoCopyWithImpl(this._self, this._then);

  final CommunityDirectoryResponseDto _self;
  final $Res Function(CommunityDirectoryResponseDto) _then;

/// Create a copy of CommunityDirectoryResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? communities = null,Object? total = freezed,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
communities: null == communities ? _self.communities : communities // ignore: cast_nullable_to_non_nullable
as List<CommunityDto>,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityDirectoryResponseDto].
extension CommunityDirectoryResponseDtoPatterns on CommunityDirectoryResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityDirectoryResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityDirectoryResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityDirectoryResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityDirectoryResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityDirectoryResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityDirectoryResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CommunityDto> communities,  int? total,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityDirectoryResponseDto() when $default != null:
return $default(_that.communities,_that.total,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CommunityDto> communities,  int? total,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _CommunityDirectoryResponseDto():
return $default(_that.communities,_that.total,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CommunityDto> communities,  int? total,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _CommunityDirectoryResponseDto() when $default != null:
return $default(_that.communities,_that.total,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityDirectoryResponseDto extends CommunityDirectoryResponseDto {
  const _CommunityDirectoryResponseDto({final  List<CommunityDto> communities = const <CommunityDto>[], this.total, this.hasMore = false, this.nextPage}): _communities = communities,super._();
  factory _CommunityDirectoryResponseDto.fromJson(Map<String, dynamic> json) => _$CommunityDirectoryResponseDtoFromJson(json);

 final  List<CommunityDto> _communities;
@override@JsonKey() List<CommunityDto> get communities {
  if (_communities is EqualUnmodifiableListView) return _communities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communities);
}

@override final  int? total;
@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of CommunityDirectoryResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityDirectoryResponseDtoCopyWith<_CommunityDirectoryResponseDto> get copyWith => __$CommunityDirectoryResponseDtoCopyWithImpl<_CommunityDirectoryResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityDirectoryResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityDirectoryResponseDto&&const DeepCollectionEquality().equals(other._communities, _communities)&&(identical(other.total, total) || other.total == total)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_communities),total,hasMore,nextPage);

@override
String toString() {
  return 'CommunityDirectoryResponseDto(communities: $communities, total: $total, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$CommunityDirectoryResponseDtoCopyWith<$Res> implements $CommunityDirectoryResponseDtoCopyWith<$Res> {
  factory _$CommunityDirectoryResponseDtoCopyWith(_CommunityDirectoryResponseDto value, $Res Function(_CommunityDirectoryResponseDto) _then) = __$CommunityDirectoryResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<CommunityDto> communities, int? total, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$CommunityDirectoryResponseDtoCopyWithImpl<$Res>
    implements _$CommunityDirectoryResponseDtoCopyWith<$Res> {
  __$CommunityDirectoryResponseDtoCopyWithImpl(this._self, this._then);

  final _CommunityDirectoryResponseDto _self;
  final $Res Function(_CommunityDirectoryResponseDto) _then;

/// Create a copy of CommunityDirectoryResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? communities = null,Object? total = freezed,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_CommunityDirectoryResponseDto(
communities: null == communities ? _self._communities : communities // ignore: cast_nullable_to_non_nullable
as List<CommunityDto>,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CommunityMembersResponseDto {

 List<CommunityMemberDto> get members; int get count; bool get hasMore; int? get nextPage;
/// Create a copy of CommunityMembersResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityMembersResponseDtoCopyWith<CommunityMembersResponseDto> get copyWith => _$CommunityMembersResponseDtoCopyWithImpl<CommunityMembersResponseDto>(this as CommunityMembersResponseDto, _$identity);

  /// Serializes this CommunityMembersResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityMembersResponseDto&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.count, count) || other.count == count)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(members),count,hasMore,nextPage);

@override
String toString() {
  return 'CommunityMembersResponseDto(members: $members, count: $count, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $CommunityMembersResponseDtoCopyWith<$Res>  {
  factory $CommunityMembersResponseDtoCopyWith(CommunityMembersResponseDto value, $Res Function(CommunityMembersResponseDto) _then) = _$CommunityMembersResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<CommunityMemberDto> members, int count, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$CommunityMembersResponseDtoCopyWithImpl<$Res>
    implements $CommunityMembersResponseDtoCopyWith<$Res> {
  _$CommunityMembersResponseDtoCopyWithImpl(this._self, this._then);

  final CommunityMembersResponseDto _self;
  final $Res Function(CommunityMembersResponseDto) _then;

/// Create a copy of CommunityMembersResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? members = null,Object? count = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<CommunityMemberDto>,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityMembersResponseDto].
extension CommunityMembersResponseDtoPatterns on CommunityMembersResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityMembersResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityMembersResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityMembersResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityMembersResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityMembersResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityMembersResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CommunityMemberDto> members,  int count,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityMembersResponseDto() when $default != null:
return $default(_that.members,_that.count,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CommunityMemberDto> members,  int count,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _CommunityMembersResponseDto():
return $default(_that.members,_that.count,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CommunityMemberDto> members,  int count,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _CommunityMembersResponseDto() when $default != null:
return $default(_that.members,_that.count,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityMembersResponseDto extends CommunityMembersResponseDto {
  const _CommunityMembersResponseDto({final  List<CommunityMemberDto> members = const <CommunityMemberDto>[], this.count = 0, this.hasMore = false, this.nextPage}): _members = members,super._();
  factory _CommunityMembersResponseDto.fromJson(Map<String, dynamic> json) => _$CommunityMembersResponseDtoFromJson(json);

 final  List<CommunityMemberDto> _members;
@override@JsonKey() List<CommunityMemberDto> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override@JsonKey() final  int count;
@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of CommunityMembersResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityMembersResponseDtoCopyWith<_CommunityMembersResponseDto> get copyWith => __$CommunityMembersResponseDtoCopyWithImpl<_CommunityMembersResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityMembersResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityMembersResponseDto&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.count, count) || other.count == count)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_members),count,hasMore,nextPage);

@override
String toString() {
  return 'CommunityMembersResponseDto(members: $members, count: $count, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$CommunityMembersResponseDtoCopyWith<$Res> implements $CommunityMembersResponseDtoCopyWith<$Res> {
  factory _$CommunityMembersResponseDtoCopyWith(_CommunityMembersResponseDto value, $Res Function(_CommunityMembersResponseDto) _then) = __$CommunityMembersResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<CommunityMemberDto> members, int count, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$CommunityMembersResponseDtoCopyWithImpl<$Res>
    implements _$CommunityMembersResponseDtoCopyWith<$Res> {
  __$CommunityMembersResponseDtoCopyWithImpl(this._self, this._then);

  final _CommunityMembersResponseDto _self;
  final $Res Function(_CommunityMembersResponseDto) _then;

/// Create a copy of CommunityMembersResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? members = null,Object? count = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_CommunityMembersResponseDto(
members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<CommunityMemberDto>,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CommunityListResponseDto {

 List<CommunityDto> get communities;
/// Create a copy of CommunityListResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityListResponseDtoCopyWith<CommunityListResponseDto> get copyWith => _$CommunityListResponseDtoCopyWithImpl<CommunityListResponseDto>(this as CommunityListResponseDto, _$identity);

  /// Serializes this CommunityListResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityListResponseDto&&const DeepCollectionEquality().equals(other.communities, communities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(communities));

@override
String toString() {
  return 'CommunityListResponseDto(communities: $communities)';
}


}

/// @nodoc
abstract mixin class $CommunityListResponseDtoCopyWith<$Res>  {
  factory $CommunityListResponseDtoCopyWith(CommunityListResponseDto value, $Res Function(CommunityListResponseDto) _then) = _$CommunityListResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<CommunityDto> communities
});




}
/// @nodoc
class _$CommunityListResponseDtoCopyWithImpl<$Res>
    implements $CommunityListResponseDtoCopyWith<$Res> {
  _$CommunityListResponseDtoCopyWithImpl(this._self, this._then);

  final CommunityListResponseDto _self;
  final $Res Function(CommunityListResponseDto) _then;

/// Create a copy of CommunityListResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? communities = null,}) {
  return _then(_self.copyWith(
communities: null == communities ? _self.communities : communities // ignore: cast_nullable_to_non_nullable
as List<CommunityDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityListResponseDto].
extension CommunityListResponseDtoPatterns on CommunityListResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityListResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityListResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityListResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityListResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityListResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityListResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CommunityDto> communities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityListResponseDto() when $default != null:
return $default(_that.communities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CommunityDto> communities)  $default,) {final _that = this;
switch (_that) {
case _CommunityListResponseDto():
return $default(_that.communities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CommunityDto> communities)?  $default,) {final _that = this;
switch (_that) {
case _CommunityListResponseDto() when $default != null:
return $default(_that.communities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityListResponseDto extends CommunityListResponseDto {
  const _CommunityListResponseDto({final  List<CommunityDto> communities = const <CommunityDto>[]}): _communities = communities,super._();
  factory _CommunityListResponseDto.fromJson(Map<String, dynamic> json) => _$CommunityListResponseDtoFromJson(json);

 final  List<CommunityDto> _communities;
@override@JsonKey() List<CommunityDto> get communities {
  if (_communities is EqualUnmodifiableListView) return _communities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communities);
}


/// Create a copy of CommunityListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityListResponseDtoCopyWith<_CommunityListResponseDto> get copyWith => __$CommunityListResponseDtoCopyWithImpl<_CommunityListResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityListResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityListResponseDto&&const DeepCollectionEquality().equals(other._communities, _communities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_communities));

@override
String toString() {
  return 'CommunityListResponseDto(communities: $communities)';
}


}

/// @nodoc
abstract mixin class _$CommunityListResponseDtoCopyWith<$Res> implements $CommunityListResponseDtoCopyWith<$Res> {
  factory _$CommunityListResponseDtoCopyWith(_CommunityListResponseDto value, $Res Function(_CommunityListResponseDto) _then) = __$CommunityListResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<CommunityDto> communities
});




}
/// @nodoc
class __$CommunityListResponseDtoCopyWithImpl<$Res>
    implements _$CommunityListResponseDtoCopyWith<$Res> {
  __$CommunityListResponseDtoCopyWithImpl(this._self, this._then);

  final _CommunityListResponseDto _self;
  final $Res Function(_CommunityListResponseDto) _then;

/// Create a copy of CommunityListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? communities = null,}) {
  return _then(_CommunityListResponseDto(
communities: null == communities ? _self._communities : communities // ignore: cast_nullable_to_non_nullable
as List<CommunityDto>,
  ));
}


}


/// @nodoc
mixin _$CommunityJoinResponseDto {

 int get communityId; bool get isMember; int get memberCount;
/// Create a copy of CommunityJoinResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityJoinResponseDtoCopyWith<CommunityJoinResponseDto> get copyWith => _$CommunityJoinResponseDtoCopyWithImpl<CommunityJoinResponseDto>(this as CommunityJoinResponseDto, _$identity);

  /// Serializes this CommunityJoinResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityJoinResponseDto&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.isMember, isMember) || other.isMember == isMember)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,communityId,isMember,memberCount);

@override
String toString() {
  return 'CommunityJoinResponseDto(communityId: $communityId, isMember: $isMember, memberCount: $memberCount)';
}


}

/// @nodoc
abstract mixin class $CommunityJoinResponseDtoCopyWith<$Res>  {
  factory $CommunityJoinResponseDtoCopyWith(CommunityJoinResponseDto value, $Res Function(CommunityJoinResponseDto) _then) = _$CommunityJoinResponseDtoCopyWithImpl;
@useResult
$Res call({
 int communityId, bool isMember, int memberCount
});




}
/// @nodoc
class _$CommunityJoinResponseDtoCopyWithImpl<$Res>
    implements $CommunityJoinResponseDtoCopyWith<$Res> {
  _$CommunityJoinResponseDtoCopyWithImpl(this._self, this._then);

  final CommunityJoinResponseDto _self;
  final $Res Function(CommunityJoinResponseDto) _then;

/// Create a copy of CommunityJoinResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? communityId = null,Object? isMember = null,Object? memberCount = null,}) {
  return _then(_self.copyWith(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as int,isMember: null == isMember ? _self.isMember : isMember // ignore: cast_nullable_to_non_nullable
as bool,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityJoinResponseDto].
extension CommunityJoinResponseDtoPatterns on CommunityJoinResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityJoinResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityJoinResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityJoinResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityJoinResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityJoinResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityJoinResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int communityId,  bool isMember,  int memberCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityJoinResponseDto() when $default != null:
return $default(_that.communityId,_that.isMember,_that.memberCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int communityId,  bool isMember,  int memberCount)  $default,) {final _that = this;
switch (_that) {
case _CommunityJoinResponseDto():
return $default(_that.communityId,_that.isMember,_that.memberCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int communityId,  bool isMember,  int memberCount)?  $default,) {final _that = this;
switch (_that) {
case _CommunityJoinResponseDto() when $default != null:
return $default(_that.communityId,_that.isMember,_that.memberCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityJoinResponseDto extends CommunityJoinResponseDto {
  const _CommunityJoinResponseDto({required this.communityId, this.isMember = false, this.memberCount = 0}): super._();
  factory _CommunityJoinResponseDto.fromJson(Map<String, dynamic> json) => _$CommunityJoinResponseDtoFromJson(json);

@override final  int communityId;
@override@JsonKey() final  bool isMember;
@override@JsonKey() final  int memberCount;

/// Create a copy of CommunityJoinResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityJoinResponseDtoCopyWith<_CommunityJoinResponseDto> get copyWith => __$CommunityJoinResponseDtoCopyWithImpl<_CommunityJoinResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityJoinResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityJoinResponseDto&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.isMember, isMember) || other.isMember == isMember)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,communityId,isMember,memberCount);

@override
String toString() {
  return 'CommunityJoinResponseDto(communityId: $communityId, isMember: $isMember, memberCount: $memberCount)';
}


}

/// @nodoc
abstract mixin class _$CommunityJoinResponseDtoCopyWith<$Res> implements $CommunityJoinResponseDtoCopyWith<$Res> {
  factory _$CommunityJoinResponseDtoCopyWith(_CommunityJoinResponseDto value, $Res Function(_CommunityJoinResponseDto) _then) = __$CommunityJoinResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int communityId, bool isMember, int memberCount
});




}
/// @nodoc
class __$CommunityJoinResponseDtoCopyWithImpl<$Res>
    implements _$CommunityJoinResponseDtoCopyWith<$Res> {
  __$CommunityJoinResponseDtoCopyWithImpl(this._self, this._then);

  final _CommunityJoinResponseDto _self;
  final $Res Function(_CommunityJoinResponseDto) _then;

/// Create a copy of CommunityJoinResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? isMember = null,Object? memberCount = null,}) {
  return _then(_CommunityJoinResponseDto(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as int,isMember: null == isMember ? _self.isMember : isMember // ignore: cast_nullable_to_non_nullable
as bool,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
