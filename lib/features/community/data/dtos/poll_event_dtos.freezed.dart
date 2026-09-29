// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll_event_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PollOptionDto {

 int get id; String get text; int get voteCount; bool get votedByMe;
/// Create a copy of PollOptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollOptionDtoCopyWith<PollOptionDto> get copyWith => _$PollOptionDtoCopyWithImpl<PollOptionDto>(this as PollOptionDto, _$identity);

  /// Serializes this PollOptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.votedByMe, votedByMe) || other.votedByMe == votedByMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,voteCount,votedByMe);

@override
String toString() {
  return 'PollOptionDto(id: $id, text: $text, voteCount: $voteCount, votedByMe: $votedByMe)';
}


}

/// @nodoc
abstract mixin class $PollOptionDtoCopyWith<$Res>  {
  factory $PollOptionDtoCopyWith(PollOptionDto value, $Res Function(PollOptionDto) _then) = _$PollOptionDtoCopyWithImpl;
@useResult
$Res call({
 int id, String text, int voteCount, bool votedByMe
});




}
/// @nodoc
class _$PollOptionDtoCopyWithImpl<$Res>
    implements $PollOptionDtoCopyWith<$Res> {
  _$PollOptionDtoCopyWithImpl(this._self, this._then);

  final PollOptionDto _self;
  final $Res Function(PollOptionDto) _then;

/// Create a copy of PollOptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? voteCount = null,Object? votedByMe = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,votedByMe: null == votedByMe ? _self.votedByMe : votedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PollOptionDto].
extension PollOptionDtoPatterns on PollOptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollOptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollOptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollOptionDto value)  $default,){
final _that = this;
switch (_that) {
case _PollOptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollOptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _PollOptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String text,  int voteCount,  bool votedByMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollOptionDto() when $default != null:
return $default(_that.id,_that.text,_that.voteCount,_that.votedByMe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String text,  int voteCount,  bool votedByMe)  $default,) {final _that = this;
switch (_that) {
case _PollOptionDto():
return $default(_that.id,_that.text,_that.voteCount,_that.votedByMe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String text,  int voteCount,  bool votedByMe)?  $default,) {final _that = this;
switch (_that) {
case _PollOptionDto() when $default != null:
return $default(_that.id,_that.text,_that.voteCount,_that.votedByMe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollOptionDto extends PollOptionDto {
  const _PollOptionDto({required this.id, this.text = '', this.voteCount = 0, this.votedByMe = false}): super._();
  factory _PollOptionDto.fromJson(Map<String, dynamic> json) => _$PollOptionDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String text;
@override@JsonKey() final  int voteCount;
@override@JsonKey() final  bool votedByMe;

/// Create a copy of PollOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollOptionDtoCopyWith<_PollOptionDto> get copyWith => __$PollOptionDtoCopyWithImpl<_PollOptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollOptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollOptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.votedByMe, votedByMe) || other.votedByMe == votedByMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,voteCount,votedByMe);

@override
String toString() {
  return 'PollOptionDto(id: $id, text: $text, voteCount: $voteCount, votedByMe: $votedByMe)';
}


}

/// @nodoc
abstract mixin class _$PollOptionDtoCopyWith<$Res> implements $PollOptionDtoCopyWith<$Res> {
  factory _$PollOptionDtoCopyWith(_PollOptionDto value, $Res Function(_PollOptionDto) _then) = __$PollOptionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String text, int voteCount, bool votedByMe
});




}
/// @nodoc
class __$PollOptionDtoCopyWithImpl<$Res>
    implements _$PollOptionDtoCopyWith<$Res> {
  __$PollOptionDtoCopyWithImpl(this._self, this._then);

  final _PollOptionDto _self;
  final $Res Function(_PollOptionDto) _then;

/// Create a copy of PollOptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? voteCount = null,Object? votedByMe = null,}) {
  return _then(_PollOptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,votedByMe: null == votedByMe ? _self.votedByMe : votedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PollDto {

 int get id; int get communityId; PetSummaryDto get creator; String get title; String? get description; List<PollOptionDto> get options; bool get allowMultipleVotes; int get totalVotes; bool get hasVoted; bool get isExpired; DateTime? get createdAt; DateTime? get expiresAt;
/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollDtoCopyWith<PollDto> get copyWith => _$PollDtoCopyWithImpl<PollDto>(this as PollDto, _$identity);

  /// Serializes this PollDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollDto&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.totalVotes, totalVotes) || other.totalVotes == totalVotes)&&(identical(other.hasVoted, hasVoted) || other.hasVoted == hasVoted)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,creator,title,description,const DeepCollectionEquality().hash(options),allowMultipleVotes,totalVotes,hasVoted,isExpired,createdAt,expiresAt);

@override
String toString() {
  return 'PollDto(id: $id, communityId: $communityId, creator: $creator, title: $title, description: $description, options: $options, allowMultipleVotes: $allowMultipleVotes, totalVotes: $totalVotes, hasVoted: $hasVoted, isExpired: $isExpired, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $PollDtoCopyWith<$Res>  {
  factory $PollDtoCopyWith(PollDto value, $Res Function(PollDto) _then) = _$PollDtoCopyWithImpl;
@useResult
$Res call({
 int id, int communityId, PetSummaryDto creator, String title, String? description, List<PollOptionDto> options, bool allowMultipleVotes, int totalVotes, bool hasVoted, bool isExpired, DateTime? createdAt, DateTime? expiresAt
});


$PetSummaryDtoCopyWith<$Res> get creator;

}
/// @nodoc
class _$PollDtoCopyWithImpl<$Res>
    implements $PollDtoCopyWith<$Res> {
  _$PollDtoCopyWithImpl(this._self, this._then);

  final PollDto _self;
  final $Res Function(PollDto) _then;

/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? options = null,Object? allowMultipleVotes = null,Object? totalVotes = null,Object? hasVoted = null,Object? isExpired = null,Object? createdAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PollOptionDto>,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,totalVotes: null == totalVotes ? _self.totalVotes : totalVotes // ignore: cast_nullable_to_non_nullable
as int,hasVoted: null == hasVoted ? _self.hasVoted : hasVoted // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get creator {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [PollDto].
extension PollDtoPatterns on PollDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollDto value)  $default,){
final _that = this;
switch (_that) {
case _PollDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollDto value)?  $default,){
final _that = this;
switch (_that) {
case _PollDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int communityId,  PetSummaryDto creator,  String title,  String? description,  List<PollOptionDto> options,  bool allowMultipleVotes,  int totalVotes,  bool hasVoted,  bool isExpired,  DateTime? createdAt,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollDto() when $default != null:
return $default(_that.id,_that.communityId,_that.creator,_that.title,_that.description,_that.options,_that.allowMultipleVotes,_that.totalVotes,_that.hasVoted,_that.isExpired,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int communityId,  PetSummaryDto creator,  String title,  String? description,  List<PollOptionDto> options,  bool allowMultipleVotes,  int totalVotes,  bool hasVoted,  bool isExpired,  DateTime? createdAt,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _PollDto():
return $default(_that.id,_that.communityId,_that.creator,_that.title,_that.description,_that.options,_that.allowMultipleVotes,_that.totalVotes,_that.hasVoted,_that.isExpired,_that.createdAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int communityId,  PetSummaryDto creator,  String title,  String? description,  List<PollOptionDto> options,  bool allowMultipleVotes,  int totalVotes,  bool hasVoted,  bool isExpired,  DateTime? createdAt,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _PollDto() when $default != null:
return $default(_that.id,_that.communityId,_that.creator,_that.title,_that.description,_that.options,_that.allowMultipleVotes,_that.totalVotes,_that.hasVoted,_that.isExpired,_that.createdAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollDto extends PollDto {
  const _PollDto({required this.id, this.communityId = 0, required this.creator, this.title = '', this.description, final  List<PollOptionDto> options = const <PollOptionDto>[], this.allowMultipleVotes = false, this.totalVotes = 0, this.hasVoted = false, this.isExpired = false, this.createdAt, this.expiresAt}): _options = options,super._();
  factory _PollDto.fromJson(Map<String, dynamic> json) => _$PollDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  int communityId;
@override final  PetSummaryDto creator;
@override@JsonKey() final  String title;
@override final  String? description;
 final  List<PollOptionDto> _options;
@override@JsonKey() List<PollOptionDto> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override@JsonKey() final  bool allowMultipleVotes;
@override@JsonKey() final  int totalVotes;
@override@JsonKey() final  bool hasVoted;
@override@JsonKey() final  bool isExpired;
@override final  DateTime? createdAt;
@override final  DateTime? expiresAt;

/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollDtoCopyWith<_PollDto> get copyWith => __$PollDtoCopyWithImpl<_PollDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollDto&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.totalVotes, totalVotes) || other.totalVotes == totalVotes)&&(identical(other.hasVoted, hasVoted) || other.hasVoted == hasVoted)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,creator,title,description,const DeepCollectionEquality().hash(_options),allowMultipleVotes,totalVotes,hasVoted,isExpired,createdAt,expiresAt);

@override
String toString() {
  return 'PollDto(id: $id, communityId: $communityId, creator: $creator, title: $title, description: $description, options: $options, allowMultipleVotes: $allowMultipleVotes, totalVotes: $totalVotes, hasVoted: $hasVoted, isExpired: $isExpired, createdAt: $createdAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$PollDtoCopyWith<$Res> implements $PollDtoCopyWith<$Res> {
  factory _$PollDtoCopyWith(_PollDto value, $Res Function(_PollDto) _then) = __$PollDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int communityId, PetSummaryDto creator, String title, String? description, List<PollOptionDto> options, bool allowMultipleVotes, int totalVotes, bool hasVoted, bool isExpired, DateTime? createdAt, DateTime? expiresAt
});


@override $PetSummaryDtoCopyWith<$Res> get creator;

}
/// @nodoc
class __$PollDtoCopyWithImpl<$Res>
    implements _$PollDtoCopyWith<$Res> {
  __$PollDtoCopyWithImpl(this._self, this._then);

  final _PollDto _self;
  final $Res Function(_PollDto) _then;

/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? options = null,Object? allowMultipleVotes = null,Object? totalVotes = null,Object? hasVoted = null,Object? isExpired = null,Object? createdAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_PollDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PollOptionDto>,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,totalVotes: null == totalVotes ? _self.totalVotes : totalVotes // ignore: cast_nullable_to_non_nullable
as int,hasVoted: null == hasVoted ? _self.hasVoted : hasVoted // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of PollDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get creator {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// @nodoc
mixin _$PollListResponseDto {

 List<PollDto> get polls; bool get hasMore; int? get nextPage;
/// Create a copy of PollListResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PollListResponseDtoCopyWith<PollListResponseDto> get copyWith => _$PollListResponseDtoCopyWithImpl<PollListResponseDto>(this as PollListResponseDto, _$identity);

  /// Serializes this PollListResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PollListResponseDto&&const DeepCollectionEquality().equals(other.polls, polls)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(polls),hasMore,nextPage);

@override
String toString() {
  return 'PollListResponseDto(polls: $polls, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $PollListResponseDtoCopyWith<$Res>  {
  factory $PollListResponseDtoCopyWith(PollListResponseDto value, $Res Function(PollListResponseDto) _then) = _$PollListResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<PollDto> polls, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$PollListResponseDtoCopyWithImpl<$Res>
    implements $PollListResponseDtoCopyWith<$Res> {
  _$PollListResponseDtoCopyWithImpl(this._self, this._then);

  final PollListResponseDto _self;
  final $Res Function(PollListResponseDto) _then;

/// Create a copy of PollListResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? polls = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
polls: null == polls ? _self.polls : polls // ignore: cast_nullable_to_non_nullable
as List<PollDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PollListResponseDto].
extension PollListResponseDtoPatterns on PollListResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PollListResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PollListResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PollListResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _PollListResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PollListResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _PollListResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PollDto> polls,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PollListResponseDto() when $default != null:
return $default(_that.polls,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PollDto> polls,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _PollListResponseDto():
return $default(_that.polls,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PollDto> polls,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _PollListResponseDto() when $default != null:
return $default(_that.polls,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PollListResponseDto extends PollListResponseDto {
  const _PollListResponseDto({final  List<PollDto> polls = const <PollDto>[], this.hasMore = false, this.nextPage}): _polls = polls,super._();
  factory _PollListResponseDto.fromJson(Map<String, dynamic> json) => _$PollListResponseDtoFromJson(json);

 final  List<PollDto> _polls;
@override@JsonKey() List<PollDto> get polls {
  if (_polls is EqualUnmodifiableListView) return _polls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_polls);
}

@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of PollListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollListResponseDtoCopyWith<_PollListResponseDto> get copyWith => __$PollListResponseDtoCopyWithImpl<_PollListResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PollListResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollListResponseDto&&const DeepCollectionEquality().equals(other._polls, _polls)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_polls),hasMore,nextPage);

@override
String toString() {
  return 'PollListResponseDto(polls: $polls, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$PollListResponseDtoCopyWith<$Res> implements $PollListResponseDtoCopyWith<$Res> {
  factory _$PollListResponseDtoCopyWith(_PollListResponseDto value, $Res Function(_PollListResponseDto) _then) = __$PollListResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<PollDto> polls, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$PollListResponseDtoCopyWithImpl<$Res>
    implements _$PollListResponseDtoCopyWith<$Res> {
  __$PollListResponseDtoCopyWithImpl(this._self, this._then);

  final _PollListResponseDto _self;
  final $Res Function(_PollListResponseDto) _then;

/// Create a copy of PollListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? polls = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_PollListResponseDto(
polls: null == polls ? _self._polls : polls // ignore: cast_nullable_to_non_nullable
as List<PollDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$EventLocationDto {

 String get displayName; double? get lat; double? get lng;
/// Create a copy of EventLocationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventLocationDtoCopyWith<EventLocationDto> get copyWith => _$EventLocationDtoCopyWithImpl<EventLocationDto>(this as EventLocationDto, _$identity);

  /// Serializes this EventLocationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventLocationDto&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,lat,lng);

@override
String toString() {
  return 'EventLocationDto(displayName: $displayName, lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class $EventLocationDtoCopyWith<$Res>  {
  factory $EventLocationDtoCopyWith(EventLocationDto value, $Res Function(EventLocationDto) _then) = _$EventLocationDtoCopyWithImpl;
@useResult
$Res call({
 String displayName, double? lat, double? lng
});




}
/// @nodoc
class _$EventLocationDtoCopyWithImpl<$Res>
    implements $EventLocationDtoCopyWith<$Res> {
  _$EventLocationDtoCopyWithImpl(this._self, this._then);

  final EventLocationDto _self;
  final $Res Function(EventLocationDto) _then;

/// Create a copy of EventLocationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? lat = freezed,Object? lng = freezed,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventLocationDto].
extension EventLocationDtoPatterns on EventLocationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventLocationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventLocationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventLocationDto value)  $default,){
final _that = this;
switch (_that) {
case _EventLocationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventLocationDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventLocationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  double? lat,  double? lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventLocationDto() when $default != null:
return $default(_that.displayName,_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  double? lat,  double? lng)  $default,) {final _that = this;
switch (_that) {
case _EventLocationDto():
return $default(_that.displayName,_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  double? lat,  double? lng)?  $default,) {final _that = this;
switch (_that) {
case _EventLocationDto() when $default != null:
return $default(_that.displayName,_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventLocationDto extends EventLocationDto {
  const _EventLocationDto({this.displayName = '', this.lat, this.lng}): super._();
  factory _EventLocationDto.fromJson(Map<String, dynamic> json) => _$EventLocationDtoFromJson(json);

@override@JsonKey() final  String displayName;
@override final  double? lat;
@override final  double? lng;

/// Create a copy of EventLocationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventLocationDtoCopyWith<_EventLocationDto> get copyWith => __$EventLocationDtoCopyWithImpl<_EventLocationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventLocationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLocationDto&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,lat,lng);

@override
String toString() {
  return 'EventLocationDto(displayName: $displayName, lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$EventLocationDtoCopyWith<$Res> implements $EventLocationDtoCopyWith<$Res> {
  factory _$EventLocationDtoCopyWith(_EventLocationDto value, $Res Function(_EventLocationDto) _then) = __$EventLocationDtoCopyWithImpl;
@override @useResult
$Res call({
 String displayName, double? lat, double? lng
});




}
/// @nodoc
class __$EventLocationDtoCopyWithImpl<$Res>
    implements _$EventLocationDtoCopyWith<$Res> {
  __$EventLocationDtoCopyWithImpl(this._self, this._then);

  final _EventLocationDto _self;
  final $Res Function(_EventLocationDto) _then;

/// Create a copy of EventLocationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? lat = freezed,Object? lng = freezed,}) {
  return _then(_EventLocationDto(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$EventDto {

 int get id; int get communityId; PetSummaryDto get creator; String get title; String? get description; EventLocationDto? get location; DateTime? get startsAt; DateTime? get endsAt; int get attendingCount; int get interestedCount;// Nullable: null when petId wasn't passed or the pet hasn't RSVPed.
 int? get myStatus; DateTime? get createdAt;
/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDtoCopyWith<EventDto> get copyWith => _$EventDtoCopyWithImpl<EventDto>(this as EventDto, _$identity);

  /// Serializes this EventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.attendingCount, attendingCount) || other.attendingCount == attendingCount)&&(identical(other.interestedCount, interestedCount) || other.interestedCount == interestedCount)&&(identical(other.myStatus, myStatus) || other.myStatus == myStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,creator,title,description,location,startsAt,endsAt,attendingCount,interestedCount,myStatus,createdAt);

@override
String toString() {
  return 'EventDto(id: $id, communityId: $communityId, creator: $creator, title: $title, description: $description, location: $location, startsAt: $startsAt, endsAt: $endsAt, attendingCount: $attendingCount, interestedCount: $interestedCount, myStatus: $myStatus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EventDtoCopyWith<$Res>  {
  factory $EventDtoCopyWith(EventDto value, $Res Function(EventDto) _then) = _$EventDtoCopyWithImpl;
@useResult
$Res call({
 int id, int communityId, PetSummaryDto creator, String title, String? description, EventLocationDto? location, DateTime? startsAt, DateTime? endsAt, int attendingCount, int interestedCount, int? myStatus, DateTime? createdAt
});


$PetSummaryDtoCopyWith<$Res> get creator;$EventLocationDtoCopyWith<$Res>? get location;

}
/// @nodoc
class _$EventDtoCopyWithImpl<$Res>
    implements $EventDtoCopyWith<$Res> {
  _$EventDtoCopyWithImpl(this._self, this._then);

  final EventDto _self;
  final $Res Function(EventDto) _then;

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? location = freezed,Object? startsAt = freezed,Object? endsAt = freezed,Object? attendingCount = null,Object? interestedCount = null,Object? myStatus = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as EventLocationDto?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,attendingCount: null == attendingCount ? _self.attendingCount : attendingCount // ignore: cast_nullable_to_non_nullable
as int,interestedCount: null == interestedCount ? _self.interestedCount : interestedCount // ignore: cast_nullable_to_non_nullable
as int,myStatus: freezed == myStatus ? _self.myStatus : myStatus // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get creator {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventLocationDtoCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $EventLocationDtoCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventDto].
extension EventDtoPatterns on EventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDto value)  $default,){
final _that = this;
switch (_that) {
case _EventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int communityId,  PetSummaryDto creator,  String title,  String? description,  EventLocationDto? location,  DateTime? startsAt,  DateTime? endsAt,  int attendingCount,  int interestedCount,  int? myStatus,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDto() when $default != null:
return $default(_that.id,_that.communityId,_that.creator,_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.attendingCount,_that.interestedCount,_that.myStatus,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int communityId,  PetSummaryDto creator,  String title,  String? description,  EventLocationDto? location,  DateTime? startsAt,  DateTime? endsAt,  int attendingCount,  int interestedCount,  int? myStatus,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _EventDto():
return $default(_that.id,_that.communityId,_that.creator,_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.attendingCount,_that.interestedCount,_that.myStatus,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int communityId,  PetSummaryDto creator,  String title,  String? description,  EventLocationDto? location,  DateTime? startsAt,  DateTime? endsAt,  int attendingCount,  int interestedCount,  int? myStatus,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EventDto() when $default != null:
return $default(_that.id,_that.communityId,_that.creator,_that.title,_that.description,_that.location,_that.startsAt,_that.endsAt,_that.attendingCount,_that.interestedCount,_that.myStatus,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDto extends EventDto {
  const _EventDto({required this.id, this.communityId = 0, required this.creator, this.title = '', this.description, this.location, this.startsAt, this.endsAt, this.attendingCount = 0, this.interestedCount = 0, this.myStatus, this.createdAt}): super._();
  factory _EventDto.fromJson(Map<String, dynamic> json) => _$EventDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  int communityId;
@override final  PetSummaryDto creator;
@override@JsonKey() final  String title;
@override final  String? description;
@override final  EventLocationDto? location;
@override final  DateTime? startsAt;
@override final  DateTime? endsAt;
@override@JsonKey() final  int attendingCount;
@override@JsonKey() final  int interestedCount;
// Nullable: null when petId wasn't passed or the pet hasn't RSVPed.
@override final  int? myStatus;
@override final  DateTime? createdAt;

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDtoCopyWith<_EventDto> get copyWith => __$EventDtoCopyWithImpl<_EventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.attendingCount, attendingCount) || other.attendingCount == attendingCount)&&(identical(other.interestedCount, interestedCount) || other.interestedCount == interestedCount)&&(identical(other.myStatus, myStatus) || other.myStatus == myStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityId,creator,title,description,location,startsAt,endsAt,attendingCount,interestedCount,myStatus,createdAt);

@override
String toString() {
  return 'EventDto(id: $id, communityId: $communityId, creator: $creator, title: $title, description: $description, location: $location, startsAt: $startsAt, endsAt: $endsAt, attendingCount: $attendingCount, interestedCount: $interestedCount, myStatus: $myStatus, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EventDtoCopyWith<$Res> implements $EventDtoCopyWith<$Res> {
  factory _$EventDtoCopyWith(_EventDto value, $Res Function(_EventDto) _then) = __$EventDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int communityId, PetSummaryDto creator, String title, String? description, EventLocationDto? location, DateTime? startsAt, DateTime? endsAt, int attendingCount, int interestedCount, int? myStatus, DateTime? createdAt
});


@override $PetSummaryDtoCopyWith<$Res> get creator;@override $EventLocationDtoCopyWith<$Res>? get location;

}
/// @nodoc
class __$EventDtoCopyWithImpl<$Res>
    implements _$EventDtoCopyWith<$Res> {
  __$EventDtoCopyWithImpl(this._self, this._then);

  final _EventDto _self;
  final $Res Function(_EventDto) _then;

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? location = freezed,Object? startsAt = freezed,Object? endsAt = freezed,Object? attendingCount = null,Object? interestedCount = null,Object? myStatus = freezed,Object? createdAt = freezed,}) {
  return _then(_EventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as EventLocationDto?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,attendingCount: null == attendingCount ? _self.attendingCount : attendingCount // ignore: cast_nullable_to_non_nullable
as int,interestedCount: null == interestedCount ? _self.interestedCount : interestedCount // ignore: cast_nullable_to_non_nullable
as int,myStatus: freezed == myStatus ? _self.myStatus : myStatus // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get creator {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventLocationDtoCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $EventLocationDtoCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$EventListResponseDto {

 List<EventDto> get events; bool get hasMore; int? get nextPage;
/// Create a copy of EventListResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventListResponseDtoCopyWith<EventListResponseDto> get copyWith => _$EventListResponseDtoCopyWithImpl<EventListResponseDto>(this as EventListResponseDto, _$identity);

  /// Serializes this EventListResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventListResponseDto&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(events),hasMore,nextPage);

@override
String toString() {
  return 'EventListResponseDto(events: $events, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $EventListResponseDtoCopyWith<$Res>  {
  factory $EventListResponseDtoCopyWith(EventListResponseDto value, $Res Function(EventListResponseDto) _then) = _$EventListResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<EventDto> events, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$EventListResponseDtoCopyWithImpl<$Res>
    implements $EventListResponseDtoCopyWith<$Res> {
  _$EventListResponseDtoCopyWithImpl(this._self, this._then);

  final EventListResponseDto _self;
  final $Res Function(EventListResponseDto) _then;

/// Create a copy of EventListResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<EventDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventListResponseDto].
extension EventListResponseDtoPatterns on EventListResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventListResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventListResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventListResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _EventListResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventListResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventListResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EventDto> events,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventListResponseDto() when $default != null:
return $default(_that.events,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EventDto> events,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _EventListResponseDto():
return $default(_that.events,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EventDto> events,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _EventListResponseDto() when $default != null:
return $default(_that.events,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventListResponseDto extends EventListResponseDto {
  const _EventListResponseDto({final  List<EventDto> events = const <EventDto>[], this.hasMore = false, this.nextPage}): _events = events,super._();
  factory _EventListResponseDto.fromJson(Map<String, dynamic> json) => _$EventListResponseDtoFromJson(json);

 final  List<EventDto> _events;
@override@JsonKey() List<EventDto> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of EventListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventListResponseDtoCopyWith<_EventListResponseDto> get copyWith => __$EventListResponseDtoCopyWithImpl<_EventListResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventListResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventListResponseDto&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events),hasMore,nextPage);

@override
String toString() {
  return 'EventListResponseDto(events: $events, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$EventListResponseDtoCopyWith<$Res> implements $EventListResponseDtoCopyWith<$Res> {
  factory _$EventListResponseDtoCopyWith(_EventListResponseDto value, $Res Function(_EventListResponseDto) _then) = __$EventListResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<EventDto> events, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$EventListResponseDtoCopyWithImpl<$Res>
    implements _$EventListResponseDtoCopyWith<$Res> {
  __$EventListResponseDtoCopyWithImpl(this._self, this._then);

  final _EventListResponseDto _self;
  final $Res Function(_EventListResponseDto) _then;

/// Create a copy of EventListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_EventListResponseDto(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<EventDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$EventAttendeeDto {

 PetSummaryDto get pet; int get status; DateTime? get respondedAt;
/// Create a copy of EventAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventAttendeeDtoCopyWith<EventAttendeeDto> get copyWith => _$EventAttendeeDtoCopyWithImpl<EventAttendeeDto>(this as EventAttendeeDto, _$identity);

  /// Serializes this EventAttendeeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventAttendeeDto&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.status, status) || other.status == status)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pet,status,respondedAt);

@override
String toString() {
  return 'EventAttendeeDto(pet: $pet, status: $status, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class $EventAttendeeDtoCopyWith<$Res>  {
  factory $EventAttendeeDtoCopyWith(EventAttendeeDto value, $Res Function(EventAttendeeDto) _then) = _$EventAttendeeDtoCopyWithImpl;
@useResult
$Res call({
 PetSummaryDto pet, int status, DateTime? respondedAt
});


$PetSummaryDtoCopyWith<$Res> get pet;

}
/// @nodoc
class _$EventAttendeeDtoCopyWithImpl<$Res>
    implements $EventAttendeeDtoCopyWith<$Res> {
  _$EventAttendeeDtoCopyWithImpl(this._self, this._then);

  final EventAttendeeDto _self;
  final $Res Function(EventAttendeeDto) _then;

/// Create a copy of EventAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pet = null,Object? status = null,Object? respondedAt = freezed,}) {
  return _then(_self.copyWith(
pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of EventAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PetSummaryDtoCopyWith<$Res> get pet {
  
  return $PetSummaryDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventAttendeeDto].
extension EventAttendeeDtoPatterns on EventAttendeeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventAttendeeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventAttendeeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventAttendeeDto value)  $default,){
final _that = this;
switch (_that) {
case _EventAttendeeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventAttendeeDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventAttendeeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PetSummaryDto pet,  int status,  DateTime? respondedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventAttendeeDto() when $default != null:
return $default(_that.pet,_that.status,_that.respondedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PetSummaryDto pet,  int status,  DateTime? respondedAt)  $default,) {final _that = this;
switch (_that) {
case _EventAttendeeDto():
return $default(_that.pet,_that.status,_that.respondedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PetSummaryDto pet,  int status,  DateTime? respondedAt)?  $default,) {final _that = this;
switch (_that) {
case _EventAttendeeDto() when $default != null:
return $default(_that.pet,_that.status,_that.respondedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventAttendeeDto extends EventAttendeeDto {
  const _EventAttendeeDto({required this.pet, this.status = 0, this.respondedAt}): super._();
  factory _EventAttendeeDto.fromJson(Map<String, dynamic> json) => _$EventAttendeeDtoFromJson(json);

@override final  PetSummaryDto pet;
@override@JsonKey() final  int status;
@override final  DateTime? respondedAt;

/// Create a copy of EventAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventAttendeeDtoCopyWith<_EventAttendeeDto> get copyWith => __$EventAttendeeDtoCopyWithImpl<_EventAttendeeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventAttendeeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventAttendeeDto&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.status, status) || other.status == status)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pet,status,respondedAt);

@override
String toString() {
  return 'EventAttendeeDto(pet: $pet, status: $status, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class _$EventAttendeeDtoCopyWith<$Res> implements $EventAttendeeDtoCopyWith<$Res> {
  factory _$EventAttendeeDtoCopyWith(_EventAttendeeDto value, $Res Function(_EventAttendeeDto) _then) = __$EventAttendeeDtoCopyWithImpl;
@override @useResult
$Res call({
 PetSummaryDto pet, int status, DateTime? respondedAt
});


@override $PetSummaryDtoCopyWith<$Res> get pet;

}
/// @nodoc
class __$EventAttendeeDtoCopyWithImpl<$Res>
    implements _$EventAttendeeDtoCopyWith<$Res> {
  __$EventAttendeeDtoCopyWithImpl(this._self, this._then);

  final _EventAttendeeDto _self;
  final $Res Function(_EventAttendeeDto) _then;

/// Create a copy of EventAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pet = null,Object? status = null,Object? respondedAt = freezed,}) {
  return _then(_EventAttendeeDto(
pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as PetSummaryDto,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of EventAttendeeDto
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
mixin _$EventAttendeeListResponseDto {

 List<EventAttendeeDto> get attendees; bool get hasMore; int? get nextPage;
/// Create a copy of EventAttendeeListResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventAttendeeListResponseDtoCopyWith<EventAttendeeListResponseDto> get copyWith => _$EventAttendeeListResponseDtoCopyWithImpl<EventAttendeeListResponseDto>(this as EventAttendeeListResponseDto, _$identity);

  /// Serializes this EventAttendeeListResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventAttendeeListResponseDto&&const DeepCollectionEquality().equals(other.attendees, attendees)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(attendees),hasMore,nextPage);

@override
String toString() {
  return 'EventAttendeeListResponseDto(attendees: $attendees, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $EventAttendeeListResponseDtoCopyWith<$Res>  {
  factory $EventAttendeeListResponseDtoCopyWith(EventAttendeeListResponseDto value, $Res Function(EventAttendeeListResponseDto) _then) = _$EventAttendeeListResponseDtoCopyWithImpl;
@useResult
$Res call({
 List<EventAttendeeDto> attendees, bool hasMore, int? nextPage
});




}
/// @nodoc
class _$EventAttendeeListResponseDtoCopyWithImpl<$Res>
    implements $EventAttendeeListResponseDtoCopyWith<$Res> {
  _$EventAttendeeListResponseDtoCopyWithImpl(this._self, this._then);

  final EventAttendeeListResponseDto _self;
  final $Res Function(EventAttendeeListResponseDto) _then;

/// Create a copy of EventAttendeeListResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attendees = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
attendees: null == attendees ? _self.attendees : attendees // ignore: cast_nullable_to_non_nullable
as List<EventAttendeeDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventAttendeeListResponseDto].
extension EventAttendeeListResponseDtoPatterns on EventAttendeeListResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventAttendeeListResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventAttendeeListResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventAttendeeListResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _EventAttendeeListResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventAttendeeListResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventAttendeeListResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EventAttendeeDto> attendees,  bool hasMore,  int? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventAttendeeListResponseDto() when $default != null:
return $default(_that.attendees,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EventAttendeeDto> attendees,  bool hasMore,  int? nextPage)  $default,) {final _that = this;
switch (_that) {
case _EventAttendeeListResponseDto():
return $default(_that.attendees,_that.hasMore,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EventAttendeeDto> attendees,  bool hasMore,  int? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _EventAttendeeListResponseDto() when $default != null:
return $default(_that.attendees,_that.hasMore,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventAttendeeListResponseDto extends EventAttendeeListResponseDto {
  const _EventAttendeeListResponseDto({final  List<EventAttendeeDto> attendees = const <EventAttendeeDto>[], this.hasMore = false, this.nextPage}): _attendees = attendees,super._();
  factory _EventAttendeeListResponseDto.fromJson(Map<String, dynamic> json) => _$EventAttendeeListResponseDtoFromJson(json);

 final  List<EventAttendeeDto> _attendees;
@override@JsonKey() List<EventAttendeeDto> get attendees {
  if (_attendees is EqualUnmodifiableListView) return _attendees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attendees);
}

@override@JsonKey() final  bool hasMore;
@override final  int? nextPage;

/// Create a copy of EventAttendeeListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventAttendeeListResponseDtoCopyWith<_EventAttendeeListResponseDto> get copyWith => __$EventAttendeeListResponseDtoCopyWithImpl<_EventAttendeeListResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventAttendeeListResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventAttendeeListResponseDto&&const DeepCollectionEquality().equals(other._attendees, _attendees)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_attendees),hasMore,nextPage);

@override
String toString() {
  return 'EventAttendeeListResponseDto(attendees: $attendees, hasMore: $hasMore, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$EventAttendeeListResponseDtoCopyWith<$Res> implements $EventAttendeeListResponseDtoCopyWith<$Res> {
  factory _$EventAttendeeListResponseDtoCopyWith(_EventAttendeeListResponseDto value, $Res Function(_EventAttendeeListResponseDto) _then) = __$EventAttendeeListResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 List<EventAttendeeDto> attendees, bool hasMore, int? nextPage
});




}
/// @nodoc
class __$EventAttendeeListResponseDtoCopyWithImpl<$Res>
    implements _$EventAttendeeListResponseDtoCopyWith<$Res> {
  __$EventAttendeeListResponseDtoCopyWithImpl(this._self, this._then);

  final _EventAttendeeListResponseDto _self;
  final $Res Function(_EventAttendeeListResponseDto) _then;

/// Create a copy of EventAttendeeListResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attendees = null,Object? hasMore = null,Object? nextPage = freezed,}) {
  return _then(_EventAttendeeListResponseDto(
attendees: null == attendees ? _self._attendees : attendees // ignore: cast_nullable_to_non_nullable
as List<EventAttendeeDto>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
