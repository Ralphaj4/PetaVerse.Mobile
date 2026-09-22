// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeSummaryDto {

 HomePetDto get pet; HomeHeroDto get hero; HomeStatsDto get stats; List<HomeUpcomingItemDto> get upcoming;
/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSummaryDtoCopyWith<HomeSummaryDto> get copyWith => _$HomeSummaryDtoCopyWithImpl<HomeSummaryDto>(this as HomeSummaryDto, _$identity);

  /// Serializes this HomeSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSummaryDto&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.hero, hero) || other.hero == hero)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other.upcoming, upcoming));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pet,hero,stats,const DeepCollectionEquality().hash(upcoming));

@override
String toString() {
  return 'HomeSummaryDto(pet: $pet, hero: $hero, stats: $stats, upcoming: $upcoming)';
}


}

/// @nodoc
abstract mixin class $HomeSummaryDtoCopyWith<$Res>  {
  factory $HomeSummaryDtoCopyWith(HomeSummaryDto value, $Res Function(HomeSummaryDto) _then) = _$HomeSummaryDtoCopyWithImpl;
@useResult
$Res call({
 HomePetDto pet, HomeHeroDto hero, HomeStatsDto stats, List<HomeUpcomingItemDto> upcoming
});


$HomePetDtoCopyWith<$Res> get pet;$HomeHeroDtoCopyWith<$Res> get hero;$HomeStatsDtoCopyWith<$Res> get stats;

}
/// @nodoc
class _$HomeSummaryDtoCopyWithImpl<$Res>
    implements $HomeSummaryDtoCopyWith<$Res> {
  _$HomeSummaryDtoCopyWithImpl(this._self, this._then);

  final HomeSummaryDto _self;
  final $Res Function(HomeSummaryDto) _then;

/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pet = null,Object? hero = null,Object? stats = null,Object? upcoming = null,}) {
  return _then(_self.copyWith(
pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as HomePetDto,hero: null == hero ? _self.hero : hero // ignore: cast_nullable_to_non_nullable
as HomeHeroDto,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as HomeStatsDto,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<HomeUpcomingItemDto>,
  ));
}
/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomePetDtoCopyWith<$Res> get pet {
  
  return $HomePetDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeHeroDtoCopyWith<$Res> get hero {
  
  return $HomeHeroDtoCopyWith<$Res>(_self.hero, (value) {
    return _then(_self.copyWith(hero: value));
  });
}/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeStatsDtoCopyWith<$Res> get stats {
  
  return $HomeStatsDtoCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeSummaryDto].
extension HomeSummaryDtoPatterns on HomeSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomePetDto pet,  HomeHeroDto hero,  HomeStatsDto stats,  List<HomeUpcomingItemDto> upcoming)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSummaryDto() when $default != null:
return $default(_that.pet,_that.hero,_that.stats,_that.upcoming);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomePetDto pet,  HomeHeroDto hero,  HomeStatsDto stats,  List<HomeUpcomingItemDto> upcoming)  $default,) {final _that = this;
switch (_that) {
case _HomeSummaryDto():
return $default(_that.pet,_that.hero,_that.stats,_that.upcoming);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomePetDto pet,  HomeHeroDto hero,  HomeStatsDto stats,  List<HomeUpcomingItemDto> upcoming)?  $default,) {final _that = this;
switch (_that) {
case _HomeSummaryDto() when $default != null:
return $default(_that.pet,_that.hero,_that.stats,_that.upcoming);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeSummaryDto extends HomeSummaryDto {
  const _HomeSummaryDto({required this.pet, required this.hero, required this.stats, final  List<HomeUpcomingItemDto> upcoming = const <HomeUpcomingItemDto>[]}): _upcoming = upcoming,super._();
  factory _HomeSummaryDto.fromJson(Map<String, dynamic> json) => _$HomeSummaryDtoFromJson(json);

@override final  HomePetDto pet;
@override final  HomeHeroDto hero;
@override final  HomeStatsDto stats;
 final  List<HomeUpcomingItemDto> _upcoming;
@override@JsonKey() List<HomeUpcomingItemDto> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}


/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSummaryDtoCopyWith<_HomeSummaryDto> get copyWith => __$HomeSummaryDtoCopyWithImpl<_HomeSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSummaryDto&&(identical(other.pet, pet) || other.pet == pet)&&(identical(other.hero, hero) || other.hero == hero)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other._upcoming, _upcoming));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pet,hero,stats,const DeepCollectionEquality().hash(_upcoming));

@override
String toString() {
  return 'HomeSummaryDto(pet: $pet, hero: $hero, stats: $stats, upcoming: $upcoming)';
}


}

/// @nodoc
abstract mixin class _$HomeSummaryDtoCopyWith<$Res> implements $HomeSummaryDtoCopyWith<$Res> {
  factory _$HomeSummaryDtoCopyWith(_HomeSummaryDto value, $Res Function(_HomeSummaryDto) _then) = __$HomeSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 HomePetDto pet, HomeHeroDto hero, HomeStatsDto stats, List<HomeUpcomingItemDto> upcoming
});


@override $HomePetDtoCopyWith<$Res> get pet;@override $HomeHeroDtoCopyWith<$Res> get hero;@override $HomeStatsDtoCopyWith<$Res> get stats;

}
/// @nodoc
class __$HomeSummaryDtoCopyWithImpl<$Res>
    implements _$HomeSummaryDtoCopyWith<$Res> {
  __$HomeSummaryDtoCopyWithImpl(this._self, this._then);

  final _HomeSummaryDto _self;
  final $Res Function(_HomeSummaryDto) _then;

/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pet = null,Object? hero = null,Object? stats = null,Object? upcoming = null,}) {
  return _then(_HomeSummaryDto(
pet: null == pet ? _self.pet : pet // ignore: cast_nullable_to_non_nullable
as HomePetDto,hero: null == hero ? _self.hero : hero // ignore: cast_nullable_to_non_nullable
as HomeHeroDto,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as HomeStatsDto,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<HomeUpcomingItemDto>,
  ));
}

/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomePetDtoCopyWith<$Res> get pet {
  
  return $HomePetDtoCopyWith<$Res>(_self.pet, (value) {
    return _then(_self.copyWith(pet: value));
  });
}/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeHeroDtoCopyWith<$Res> get hero {
  
  return $HomeHeroDtoCopyWith<$Res>(_self.hero, (value) {
    return _then(_self.copyWith(hero: value));
  });
}/// Create a copy of HomeSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeStatsDtoCopyWith<$Res> get stats {
  
  return $HomeStatsDtoCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// @nodoc
mixin _$HomePetDto {

 int get id; String get name;
/// Create a copy of HomePetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomePetDtoCopyWith<HomePetDto> get copyWith => _$HomePetDtoCopyWithImpl<HomePetDto>(this as HomePetDto, _$identity);

  /// Serializes this HomePetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomePetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'HomePetDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $HomePetDtoCopyWith<$Res>  {
  factory $HomePetDtoCopyWith(HomePetDto value, $Res Function(HomePetDto) _then) = _$HomePetDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class _$HomePetDtoCopyWithImpl<$Res>
    implements $HomePetDtoCopyWith<$Res> {
  _$HomePetDtoCopyWithImpl(this._self, this._then);

  final HomePetDto _self;
  final $Res Function(HomePetDto) _then;

/// Create a copy of HomePetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HomePetDto].
extension HomePetDtoPatterns on HomePetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomePetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomePetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomePetDto value)  $default,){
final _that = this;
switch (_that) {
case _HomePetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomePetDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomePetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomePetDto() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name)  $default,) {final _that = this;
switch (_that) {
case _HomePetDto():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _HomePetDto() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomePetDto implements HomePetDto {
  const _HomePetDto({required this.id, this.name = ''});
  factory _HomePetDto.fromJson(Map<String, dynamic> json) => _$HomePetDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;

/// Create a copy of HomePetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomePetDtoCopyWith<_HomePetDto> get copyWith => __$HomePetDtoCopyWithImpl<_HomePetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomePetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomePetDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'HomePetDto(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$HomePetDtoCopyWith<$Res> implements $HomePetDtoCopyWith<$Res> {
  factory _$HomePetDtoCopyWith(_HomePetDto value, $Res Function(_HomePetDto) _then) = __$HomePetDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class __$HomePetDtoCopyWithImpl<$Res>
    implements _$HomePetDtoCopyWith<$Res> {
  __$HomePetDtoCopyWithImpl(this._self, this._then);

  final _HomePetDto _self;
  final $Res Function(_HomePetDto) _then;

/// Create a copy of HomePetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_HomePetDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HomeHeroDto {

 HomeScoreDto? get healthScore; HomeNextVisitDto? get nextVisit;
/// Create a copy of HomeHeroDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeHeroDtoCopyWith<HomeHeroDto> get copyWith => _$HomeHeroDtoCopyWithImpl<HomeHeroDto>(this as HomeHeroDto, _$identity);

  /// Serializes this HomeHeroDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeHeroDto&&(identical(other.healthScore, healthScore) || other.healthScore == healthScore)&&(identical(other.nextVisit, nextVisit) || other.nextVisit == nextVisit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,healthScore,nextVisit);

@override
String toString() {
  return 'HomeHeroDto(healthScore: $healthScore, nextVisit: $nextVisit)';
}


}

/// @nodoc
abstract mixin class $HomeHeroDtoCopyWith<$Res>  {
  factory $HomeHeroDtoCopyWith(HomeHeroDto value, $Res Function(HomeHeroDto) _then) = _$HomeHeroDtoCopyWithImpl;
@useResult
$Res call({
 HomeScoreDto? healthScore, HomeNextVisitDto? nextVisit
});


$HomeScoreDtoCopyWith<$Res>? get healthScore;$HomeNextVisitDtoCopyWith<$Res>? get nextVisit;

}
/// @nodoc
class _$HomeHeroDtoCopyWithImpl<$Res>
    implements $HomeHeroDtoCopyWith<$Res> {
  _$HomeHeroDtoCopyWithImpl(this._self, this._then);

  final HomeHeroDto _self;
  final $Res Function(HomeHeroDto) _then;

/// Create a copy of HomeHeroDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? healthScore = freezed,Object? nextVisit = freezed,}) {
  return _then(_self.copyWith(
healthScore: freezed == healthScore ? _self.healthScore : healthScore // ignore: cast_nullable_to_non_nullable
as HomeScoreDto?,nextVisit: freezed == nextVisit ? _self.nextVisit : nextVisit // ignore: cast_nullable_to_non_nullable
as HomeNextVisitDto?,
  ));
}
/// Create a copy of HomeHeroDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeScoreDtoCopyWith<$Res>? get healthScore {
    if (_self.healthScore == null) {
    return null;
  }

  return $HomeScoreDtoCopyWith<$Res>(_self.healthScore!, (value) {
    return _then(_self.copyWith(healthScore: value));
  });
}/// Create a copy of HomeHeroDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeNextVisitDtoCopyWith<$Res>? get nextVisit {
    if (_self.nextVisit == null) {
    return null;
  }

  return $HomeNextVisitDtoCopyWith<$Res>(_self.nextVisit!, (value) {
    return _then(_self.copyWith(nextVisit: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeHeroDto].
extension HomeHeroDtoPatterns on HomeHeroDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeHeroDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeHeroDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeHeroDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeHeroDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeHeroDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeHeroDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeScoreDto? healthScore,  HomeNextVisitDto? nextVisit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeHeroDto() when $default != null:
return $default(_that.healthScore,_that.nextVisit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeScoreDto? healthScore,  HomeNextVisitDto? nextVisit)  $default,) {final _that = this;
switch (_that) {
case _HomeHeroDto():
return $default(_that.healthScore,_that.nextVisit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeScoreDto? healthScore,  HomeNextVisitDto? nextVisit)?  $default,) {final _that = this;
switch (_that) {
case _HomeHeroDto() when $default != null:
return $default(_that.healthScore,_that.nextVisit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeHeroDto implements HomeHeroDto {
  const _HomeHeroDto({this.healthScore, this.nextVisit});
  factory _HomeHeroDto.fromJson(Map<String, dynamic> json) => _$HomeHeroDtoFromJson(json);

@override final  HomeScoreDto? healthScore;
@override final  HomeNextVisitDto? nextVisit;

/// Create a copy of HomeHeroDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeHeroDtoCopyWith<_HomeHeroDto> get copyWith => __$HomeHeroDtoCopyWithImpl<_HomeHeroDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeHeroDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeHeroDto&&(identical(other.healthScore, healthScore) || other.healthScore == healthScore)&&(identical(other.nextVisit, nextVisit) || other.nextVisit == nextVisit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,healthScore,nextVisit);

@override
String toString() {
  return 'HomeHeroDto(healthScore: $healthScore, nextVisit: $nextVisit)';
}


}

/// @nodoc
abstract mixin class _$HomeHeroDtoCopyWith<$Res> implements $HomeHeroDtoCopyWith<$Res> {
  factory _$HomeHeroDtoCopyWith(_HomeHeroDto value, $Res Function(_HomeHeroDto) _then) = __$HomeHeroDtoCopyWithImpl;
@override @useResult
$Res call({
 HomeScoreDto? healthScore, HomeNextVisitDto? nextVisit
});


@override $HomeScoreDtoCopyWith<$Res>? get healthScore;@override $HomeNextVisitDtoCopyWith<$Res>? get nextVisit;

}
/// @nodoc
class __$HomeHeroDtoCopyWithImpl<$Res>
    implements _$HomeHeroDtoCopyWith<$Res> {
  __$HomeHeroDtoCopyWithImpl(this._self, this._then);

  final _HomeHeroDto _self;
  final $Res Function(_HomeHeroDto) _then;

/// Create a copy of HomeHeroDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? healthScore = freezed,Object? nextVisit = freezed,}) {
  return _then(_HomeHeroDto(
healthScore: freezed == healthScore ? _self.healthScore : healthScore // ignore: cast_nullable_to_non_nullable
as HomeScoreDto?,nextVisit: freezed == nextVisit ? _self.nextVisit : nextVisit // ignore: cast_nullable_to_non_nullable
as HomeNextVisitDto?,
  ));
}

/// Create a copy of HomeHeroDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeScoreDtoCopyWith<$Res>? get healthScore {
    if (_self.healthScore == null) {
    return null;
  }

  return $HomeScoreDtoCopyWith<$Res>(_self.healthScore!, (value) {
    return _then(_self.copyWith(healthScore: value));
  });
}/// Create a copy of HomeHeroDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeNextVisitDtoCopyWith<$Res>? get nextVisit {
    if (_self.nextVisit == null) {
    return null;
  }

  return $HomeNextVisitDtoCopyWith<$Res>(_self.nextVisit!, (value) {
    return _then(_self.copyWith(nextVisit: value));
  });
}
}


/// @nodoc
mixin _$HomeScoreDto {

 int get value; String get band;
/// Create a copy of HomeScoreDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeScoreDtoCopyWith<HomeScoreDto> get copyWith => _$HomeScoreDtoCopyWithImpl<HomeScoreDto>(this as HomeScoreDto, _$identity);

  /// Serializes this HomeScoreDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeScoreDto&&(identical(other.value, value) || other.value == value)&&(identical(other.band, band) || other.band == band));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,band);

@override
String toString() {
  return 'HomeScoreDto(value: $value, band: $band)';
}


}

/// @nodoc
abstract mixin class $HomeScoreDtoCopyWith<$Res>  {
  factory $HomeScoreDtoCopyWith(HomeScoreDto value, $Res Function(HomeScoreDto) _then) = _$HomeScoreDtoCopyWithImpl;
@useResult
$Res call({
 int value, String band
});




}
/// @nodoc
class _$HomeScoreDtoCopyWithImpl<$Res>
    implements $HomeScoreDtoCopyWith<$Res> {
  _$HomeScoreDtoCopyWithImpl(this._self, this._then);

  final HomeScoreDto _self;
  final $Res Function(HomeScoreDto) _then;

/// Create a copy of HomeScoreDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? band = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeScoreDto].
extension HomeScoreDtoPatterns on HomeScoreDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeScoreDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeScoreDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeScoreDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeScoreDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeScoreDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeScoreDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int value,  String band)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeScoreDto() when $default != null:
return $default(_that.value,_that.band);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int value,  String band)  $default,) {final _that = this;
switch (_that) {
case _HomeScoreDto():
return $default(_that.value,_that.band);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int value,  String band)?  $default,) {final _that = this;
switch (_that) {
case _HomeScoreDto() when $default != null:
return $default(_that.value,_that.band);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeScoreDto implements HomeScoreDto {
  const _HomeScoreDto({this.value = 0, this.band = 'No data'});
  factory _HomeScoreDto.fromJson(Map<String, dynamic> json) => _$HomeScoreDtoFromJson(json);

@override@JsonKey() final  int value;
@override@JsonKey() final  String band;

/// Create a copy of HomeScoreDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeScoreDtoCopyWith<_HomeScoreDto> get copyWith => __$HomeScoreDtoCopyWithImpl<_HomeScoreDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeScoreDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeScoreDto&&(identical(other.value, value) || other.value == value)&&(identical(other.band, band) || other.band == band));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,band);

@override
String toString() {
  return 'HomeScoreDto(value: $value, band: $band)';
}


}

/// @nodoc
abstract mixin class _$HomeScoreDtoCopyWith<$Res> implements $HomeScoreDtoCopyWith<$Res> {
  factory _$HomeScoreDtoCopyWith(_HomeScoreDto value, $Res Function(_HomeScoreDto) _then) = __$HomeScoreDtoCopyWithImpl;
@override @useResult
$Res call({
 int value, String band
});




}
/// @nodoc
class __$HomeScoreDtoCopyWithImpl<$Res>
    implements _$HomeScoreDtoCopyWith<$Res> {
  __$HomeScoreDtoCopyWithImpl(this._self, this._then);

  final _HomeScoreDto _self;
  final $Res Function(_HomeScoreDto) _then;

/// Create a copy of HomeScoreDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? band = null,}) {
  return _then(_HomeScoreDto(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HomeNextVisitDto {

 int get appointmentId; int get petId; String get petName; String get title; DateTime get scheduledAt; String? get location;
/// Create a copy of HomeNextVisitDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeNextVisitDtoCopyWith<HomeNextVisitDto> get copyWith => _$HomeNextVisitDtoCopyWithImpl<HomeNextVisitDto>(this as HomeNextVisitDto, _$identity);

  /// Serializes this HomeNextVisitDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeNextVisitDto&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.title, title) || other.title == title)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,petId,petName,title,scheduledAt,location);

@override
String toString() {
  return 'HomeNextVisitDto(appointmentId: $appointmentId, petId: $petId, petName: $petName, title: $title, scheduledAt: $scheduledAt, location: $location)';
}


}

/// @nodoc
abstract mixin class $HomeNextVisitDtoCopyWith<$Res>  {
  factory $HomeNextVisitDtoCopyWith(HomeNextVisitDto value, $Res Function(HomeNextVisitDto) _then) = _$HomeNextVisitDtoCopyWithImpl;
@useResult
$Res call({
 int appointmentId, int petId, String petName, String title, DateTime scheduledAt, String? location
});




}
/// @nodoc
class _$HomeNextVisitDtoCopyWithImpl<$Res>
    implements $HomeNextVisitDtoCopyWith<$Res> {
  _$HomeNextVisitDtoCopyWithImpl(this._self, this._then);

  final HomeNextVisitDto _self;
  final $Res Function(HomeNextVisitDto) _then;

/// Create a copy of HomeNextVisitDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentId = null,Object? petId = null,Object? petName = null,Object? title = null,Object? scheduledAt = null,Object? location = freezed,}) {
  return _then(_self.copyWith(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as int,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeNextVisitDto].
extension HomeNextVisitDtoPatterns on HomeNextVisitDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeNextVisitDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeNextVisitDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeNextVisitDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeNextVisitDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeNextVisitDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeNextVisitDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int appointmentId,  int petId,  String petName,  String title,  DateTime scheduledAt,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeNextVisitDto() when $default != null:
return $default(_that.appointmentId,_that.petId,_that.petName,_that.title,_that.scheduledAt,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int appointmentId,  int petId,  String petName,  String title,  DateTime scheduledAt,  String? location)  $default,) {final _that = this;
switch (_that) {
case _HomeNextVisitDto():
return $default(_that.appointmentId,_that.petId,_that.petName,_that.title,_that.scheduledAt,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int appointmentId,  int petId,  String petName,  String title,  DateTime scheduledAt,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _HomeNextVisitDto() when $default != null:
return $default(_that.appointmentId,_that.petId,_that.petName,_that.title,_that.scheduledAt,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeNextVisitDto extends HomeNextVisitDto {
  const _HomeNextVisitDto({required this.appointmentId, required this.petId, this.petName = '', this.title = '', required this.scheduledAt, this.location}): super._();
  factory _HomeNextVisitDto.fromJson(Map<String, dynamic> json) => _$HomeNextVisitDtoFromJson(json);

@override final  int appointmentId;
@override final  int petId;
@override@JsonKey() final  String petName;
@override@JsonKey() final  String title;
@override final  DateTime scheduledAt;
@override final  String? location;

/// Create a copy of HomeNextVisitDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeNextVisitDtoCopyWith<_HomeNextVisitDto> get copyWith => __$HomeNextVisitDtoCopyWithImpl<_HomeNextVisitDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeNextVisitDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeNextVisitDto&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.title, title) || other.title == title)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentId,petId,petName,title,scheduledAt,location);

@override
String toString() {
  return 'HomeNextVisitDto(appointmentId: $appointmentId, petId: $petId, petName: $petName, title: $title, scheduledAt: $scheduledAt, location: $location)';
}


}

/// @nodoc
abstract mixin class _$HomeNextVisitDtoCopyWith<$Res> implements $HomeNextVisitDtoCopyWith<$Res> {
  factory _$HomeNextVisitDtoCopyWith(_HomeNextVisitDto value, $Res Function(_HomeNextVisitDto) _then) = __$HomeNextVisitDtoCopyWithImpl;
@override @useResult
$Res call({
 int appointmentId, int petId, String petName, String title, DateTime scheduledAt, String? location
});




}
/// @nodoc
class __$HomeNextVisitDtoCopyWithImpl<$Res>
    implements _$HomeNextVisitDtoCopyWith<$Res> {
  __$HomeNextVisitDtoCopyWithImpl(this._self, this._then);

  final _HomeNextVisitDto _self;
  final $Res Function(_HomeNextVisitDto) _then;

/// Create a copy of HomeNextVisitDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentId = null,Object? petId = null,Object? petName = null,Object? title = null,Object? scheduledAt = null,Object? location = freezed,}) {
  return _then(_HomeNextVisitDto(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as int,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HomeStatsDto {

 HomeScoreDto get health; HomeActivityDto get activity; HomeVaccinesDto get vaccines; HomeWeightDto? get weight;
/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStatsDtoCopyWith<HomeStatsDto> get copyWith => _$HomeStatsDtoCopyWithImpl<HomeStatsDto>(this as HomeStatsDto, _$identity);

  /// Serializes this HomeStatsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeStatsDto&&(identical(other.health, health) || other.health == health)&&(identical(other.activity, activity) || other.activity == activity)&&(identical(other.vaccines, vaccines) || other.vaccines == vaccines)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,health,activity,vaccines,weight);

@override
String toString() {
  return 'HomeStatsDto(health: $health, activity: $activity, vaccines: $vaccines, weight: $weight)';
}


}

/// @nodoc
abstract mixin class $HomeStatsDtoCopyWith<$Res>  {
  factory $HomeStatsDtoCopyWith(HomeStatsDto value, $Res Function(HomeStatsDto) _then) = _$HomeStatsDtoCopyWithImpl;
@useResult
$Res call({
 HomeScoreDto health, HomeActivityDto activity, HomeVaccinesDto vaccines, HomeWeightDto? weight
});


$HomeScoreDtoCopyWith<$Res> get health;$HomeActivityDtoCopyWith<$Res> get activity;$HomeVaccinesDtoCopyWith<$Res> get vaccines;$HomeWeightDtoCopyWith<$Res>? get weight;

}
/// @nodoc
class _$HomeStatsDtoCopyWithImpl<$Res>
    implements $HomeStatsDtoCopyWith<$Res> {
  _$HomeStatsDtoCopyWithImpl(this._self, this._then);

  final HomeStatsDto _self;
  final $Res Function(HomeStatsDto) _then;

/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? health = null,Object? activity = null,Object? vaccines = null,Object? weight = freezed,}) {
  return _then(_self.copyWith(
health: null == health ? _self.health : health // ignore: cast_nullable_to_non_nullable
as HomeScoreDto,activity: null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as HomeActivityDto,vaccines: null == vaccines ? _self.vaccines : vaccines // ignore: cast_nullable_to_non_nullable
as HomeVaccinesDto,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as HomeWeightDto?,
  ));
}
/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeScoreDtoCopyWith<$Res> get health {
  
  return $HomeScoreDtoCopyWith<$Res>(_self.health, (value) {
    return _then(_self.copyWith(health: value));
  });
}/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeActivityDtoCopyWith<$Res> get activity {
  
  return $HomeActivityDtoCopyWith<$Res>(_self.activity, (value) {
    return _then(_self.copyWith(activity: value));
  });
}/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeVaccinesDtoCopyWith<$Res> get vaccines {
  
  return $HomeVaccinesDtoCopyWith<$Res>(_self.vaccines, (value) {
    return _then(_self.copyWith(vaccines: value));
  });
}/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeWeightDtoCopyWith<$Res>? get weight {
    if (_self.weight == null) {
    return null;
  }

  return $HomeWeightDtoCopyWith<$Res>(_self.weight!, (value) {
    return _then(_self.copyWith(weight: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeStatsDto].
extension HomeStatsDtoPatterns on HomeStatsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeStatsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeStatsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeStatsDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeStatsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeStatsDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeStatsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeScoreDto health,  HomeActivityDto activity,  HomeVaccinesDto vaccines,  HomeWeightDto? weight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeStatsDto() when $default != null:
return $default(_that.health,_that.activity,_that.vaccines,_that.weight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeScoreDto health,  HomeActivityDto activity,  HomeVaccinesDto vaccines,  HomeWeightDto? weight)  $default,) {final _that = this;
switch (_that) {
case _HomeStatsDto():
return $default(_that.health,_that.activity,_that.vaccines,_that.weight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeScoreDto health,  HomeActivityDto activity,  HomeVaccinesDto vaccines,  HomeWeightDto? weight)?  $default,) {final _that = this;
switch (_that) {
case _HomeStatsDto() when $default != null:
return $default(_that.health,_that.activity,_that.vaccines,_that.weight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeStatsDto implements HomeStatsDto {
  const _HomeStatsDto({this.health = const HomeScoreDto(), this.activity = const HomeActivityDto(), this.vaccines = const HomeVaccinesDto(), this.weight});
  factory _HomeStatsDto.fromJson(Map<String, dynamic> json) => _$HomeStatsDtoFromJson(json);

@override@JsonKey() final  HomeScoreDto health;
@override@JsonKey() final  HomeActivityDto activity;
@override@JsonKey() final  HomeVaccinesDto vaccines;
@override final  HomeWeightDto? weight;

/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStatsDtoCopyWith<_HomeStatsDto> get copyWith => __$HomeStatsDtoCopyWithImpl<_HomeStatsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeStatsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeStatsDto&&(identical(other.health, health) || other.health == health)&&(identical(other.activity, activity) || other.activity == activity)&&(identical(other.vaccines, vaccines) || other.vaccines == vaccines)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,health,activity,vaccines,weight);

@override
String toString() {
  return 'HomeStatsDto(health: $health, activity: $activity, vaccines: $vaccines, weight: $weight)';
}


}

/// @nodoc
abstract mixin class _$HomeStatsDtoCopyWith<$Res> implements $HomeStatsDtoCopyWith<$Res> {
  factory _$HomeStatsDtoCopyWith(_HomeStatsDto value, $Res Function(_HomeStatsDto) _then) = __$HomeStatsDtoCopyWithImpl;
@override @useResult
$Res call({
 HomeScoreDto health, HomeActivityDto activity, HomeVaccinesDto vaccines, HomeWeightDto? weight
});


@override $HomeScoreDtoCopyWith<$Res> get health;@override $HomeActivityDtoCopyWith<$Res> get activity;@override $HomeVaccinesDtoCopyWith<$Res> get vaccines;@override $HomeWeightDtoCopyWith<$Res>? get weight;

}
/// @nodoc
class __$HomeStatsDtoCopyWithImpl<$Res>
    implements _$HomeStatsDtoCopyWith<$Res> {
  __$HomeStatsDtoCopyWithImpl(this._self, this._then);

  final _HomeStatsDto _self;
  final $Res Function(_HomeStatsDto) _then;

/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? health = null,Object? activity = null,Object? vaccines = null,Object? weight = freezed,}) {
  return _then(_HomeStatsDto(
health: null == health ? _self.health : health // ignore: cast_nullable_to_non_nullable
as HomeScoreDto,activity: null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as HomeActivityDto,vaccines: null == vaccines ? _self.vaccines : vaccines // ignore: cast_nullable_to_non_nullable
as HomeVaccinesDto,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as HomeWeightDto?,
  ));
}

/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeScoreDtoCopyWith<$Res> get health {
  
  return $HomeScoreDtoCopyWith<$Res>(_self.health, (value) {
    return _then(_self.copyWith(health: value));
  });
}/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeActivityDtoCopyWith<$Res> get activity {
  
  return $HomeActivityDtoCopyWith<$Res>(_self.activity, (value) {
    return _then(_self.copyWith(activity: value));
  });
}/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeVaccinesDtoCopyWith<$Res> get vaccines {
  
  return $HomeVaccinesDtoCopyWith<$Res>(_self.vaccines, (value) {
    return _then(_self.copyWith(vaccines: value));
  });
}/// Create a copy of HomeStatsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeWeightDtoCopyWith<$Res>? get weight {
    if (_self.weight == null) {
    return null;
  }

  return $HomeWeightDtoCopyWith<$Res>(_self.weight!, (value) {
    return _then(_self.copyWith(weight: value));
  });
}
}


/// @nodoc
mixin _$HomeActivityDto {

 int get minutes; int get activeDays; int get windowDays;
/// Create a copy of HomeActivityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeActivityDtoCopyWith<HomeActivityDto> get copyWith => _$HomeActivityDtoCopyWithImpl<HomeActivityDto>(this as HomeActivityDto, _$identity);

  /// Serializes this HomeActivityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeActivityDto&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays)&&(identical(other.windowDays, windowDays) || other.windowDays == windowDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minutes,activeDays,windowDays);

@override
String toString() {
  return 'HomeActivityDto(minutes: $minutes, activeDays: $activeDays, windowDays: $windowDays)';
}


}

/// @nodoc
abstract mixin class $HomeActivityDtoCopyWith<$Res>  {
  factory $HomeActivityDtoCopyWith(HomeActivityDto value, $Res Function(HomeActivityDto) _then) = _$HomeActivityDtoCopyWithImpl;
@useResult
$Res call({
 int minutes, int activeDays, int windowDays
});




}
/// @nodoc
class _$HomeActivityDtoCopyWithImpl<$Res>
    implements $HomeActivityDtoCopyWith<$Res> {
  _$HomeActivityDtoCopyWithImpl(this._self, this._then);

  final HomeActivityDto _self;
  final $Res Function(HomeActivityDto) _then;

/// Create a copy of HomeActivityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minutes = null,Object? activeDays = null,Object? windowDays = null,}) {
  return _then(_self.copyWith(
minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,windowDays: null == windowDays ? _self.windowDays : windowDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeActivityDto].
extension HomeActivityDtoPatterns on HomeActivityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeActivityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeActivityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeActivityDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeActivityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeActivityDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeActivityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int minutes,  int activeDays,  int windowDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeActivityDto() when $default != null:
return $default(_that.minutes,_that.activeDays,_that.windowDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int minutes,  int activeDays,  int windowDays)  $default,) {final _that = this;
switch (_that) {
case _HomeActivityDto():
return $default(_that.minutes,_that.activeDays,_that.windowDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int minutes,  int activeDays,  int windowDays)?  $default,) {final _that = this;
switch (_that) {
case _HomeActivityDto() when $default != null:
return $default(_that.minutes,_that.activeDays,_that.windowDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeActivityDto extends HomeActivityDto {
  const _HomeActivityDto({this.minutes = 0, this.activeDays = 0, this.windowDays = 7}): super._();
  factory _HomeActivityDto.fromJson(Map<String, dynamic> json) => _$HomeActivityDtoFromJson(json);

@override@JsonKey() final  int minutes;
@override@JsonKey() final  int activeDays;
@override@JsonKey() final  int windowDays;

/// Create a copy of HomeActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeActivityDtoCopyWith<_HomeActivityDto> get copyWith => __$HomeActivityDtoCopyWithImpl<_HomeActivityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeActivityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeActivityDto&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays)&&(identical(other.windowDays, windowDays) || other.windowDays == windowDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minutes,activeDays,windowDays);

@override
String toString() {
  return 'HomeActivityDto(minutes: $minutes, activeDays: $activeDays, windowDays: $windowDays)';
}


}

/// @nodoc
abstract mixin class _$HomeActivityDtoCopyWith<$Res> implements $HomeActivityDtoCopyWith<$Res> {
  factory _$HomeActivityDtoCopyWith(_HomeActivityDto value, $Res Function(_HomeActivityDto) _then) = __$HomeActivityDtoCopyWithImpl;
@override @useResult
$Res call({
 int minutes, int activeDays, int windowDays
});




}
/// @nodoc
class __$HomeActivityDtoCopyWithImpl<$Res>
    implements _$HomeActivityDtoCopyWith<$Res> {
  __$HomeActivityDtoCopyWithImpl(this._self, this._then);

  final _HomeActivityDto _self;
  final $Res Function(_HomeActivityDto) _then;

/// Create a copy of HomeActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minutes = null,Object? activeDays = null,Object? windowDays = null,}) {
  return _then(_HomeActivityDto(
minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,windowDays: null == windowDays ? _self.windowDays : windowDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$HomeVaccinesDto {

 int get upcomingCount;
/// Create a copy of HomeVaccinesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeVaccinesDtoCopyWith<HomeVaccinesDto> get copyWith => _$HomeVaccinesDtoCopyWithImpl<HomeVaccinesDto>(this as HomeVaccinesDto, _$identity);

  /// Serializes this HomeVaccinesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeVaccinesDto&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upcomingCount);

@override
String toString() {
  return 'HomeVaccinesDto(upcomingCount: $upcomingCount)';
}


}

/// @nodoc
abstract mixin class $HomeVaccinesDtoCopyWith<$Res>  {
  factory $HomeVaccinesDtoCopyWith(HomeVaccinesDto value, $Res Function(HomeVaccinesDto) _then) = _$HomeVaccinesDtoCopyWithImpl;
@useResult
$Res call({
 int upcomingCount
});




}
/// @nodoc
class _$HomeVaccinesDtoCopyWithImpl<$Res>
    implements $HomeVaccinesDtoCopyWith<$Res> {
  _$HomeVaccinesDtoCopyWithImpl(this._self, this._then);

  final HomeVaccinesDto _self;
  final $Res Function(HomeVaccinesDto) _then;

/// Create a copy of HomeVaccinesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upcomingCount = null,}) {
  return _then(_self.copyWith(
upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeVaccinesDto].
extension HomeVaccinesDtoPatterns on HomeVaccinesDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeVaccinesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeVaccinesDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeVaccinesDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeVaccinesDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeVaccinesDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeVaccinesDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int upcomingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeVaccinesDto() when $default != null:
return $default(_that.upcomingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int upcomingCount)  $default,) {final _that = this;
switch (_that) {
case _HomeVaccinesDto():
return $default(_that.upcomingCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int upcomingCount)?  $default,) {final _that = this;
switch (_that) {
case _HomeVaccinesDto() when $default != null:
return $default(_that.upcomingCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeVaccinesDto implements HomeVaccinesDto {
  const _HomeVaccinesDto({this.upcomingCount = 0});
  factory _HomeVaccinesDto.fromJson(Map<String, dynamic> json) => _$HomeVaccinesDtoFromJson(json);

@override@JsonKey() final  int upcomingCount;

/// Create a copy of HomeVaccinesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeVaccinesDtoCopyWith<_HomeVaccinesDto> get copyWith => __$HomeVaccinesDtoCopyWithImpl<_HomeVaccinesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeVaccinesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeVaccinesDto&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upcomingCount);

@override
String toString() {
  return 'HomeVaccinesDto(upcomingCount: $upcomingCount)';
}


}

/// @nodoc
abstract mixin class _$HomeVaccinesDtoCopyWith<$Res> implements $HomeVaccinesDtoCopyWith<$Res> {
  factory _$HomeVaccinesDtoCopyWith(_HomeVaccinesDto value, $Res Function(_HomeVaccinesDto) _then) = __$HomeVaccinesDtoCopyWithImpl;
@override @useResult
$Res call({
 int upcomingCount
});




}
/// @nodoc
class __$HomeVaccinesDtoCopyWithImpl<$Res>
    implements _$HomeVaccinesDtoCopyWith<$Res> {
  __$HomeVaccinesDtoCopyWithImpl(this._self, this._then);

  final _HomeVaccinesDto _self;
  final $Res Function(_HomeVaccinesDto) _then;

/// Create a copy of HomeVaccinesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upcomingCount = null,}) {
  return _then(_HomeVaccinesDto(
upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$HomeWeightDto {

 double get value; String get unit; String? get trend;
/// Create a copy of HomeWeightDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeWeightDtoCopyWith<HomeWeightDto> get copyWith => _$HomeWeightDtoCopyWithImpl<HomeWeightDto>(this as HomeWeightDto, _$identity);

  /// Serializes this HomeWeightDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWeightDto&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.trend, trend) || other.trend == trend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,unit,trend);

@override
String toString() {
  return 'HomeWeightDto(value: $value, unit: $unit, trend: $trend)';
}


}

/// @nodoc
abstract mixin class $HomeWeightDtoCopyWith<$Res>  {
  factory $HomeWeightDtoCopyWith(HomeWeightDto value, $Res Function(HomeWeightDto) _then) = _$HomeWeightDtoCopyWithImpl;
@useResult
$Res call({
 double value, String unit, String? trend
});




}
/// @nodoc
class _$HomeWeightDtoCopyWithImpl<$Res>
    implements $HomeWeightDtoCopyWith<$Res> {
  _$HomeWeightDtoCopyWithImpl(this._self, this._then);

  final HomeWeightDto _self;
  final $Res Function(HomeWeightDto) _then;

/// Create a copy of HomeWeightDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? unit = null,Object? trend = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,trend: freezed == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeWeightDto].
extension HomeWeightDtoPatterns on HomeWeightDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeWeightDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeWeightDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeWeightDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeWeightDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeWeightDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeWeightDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double value,  String unit,  String? trend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeWeightDto() when $default != null:
return $default(_that.value,_that.unit,_that.trend);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double value,  String unit,  String? trend)  $default,) {final _that = this;
switch (_that) {
case _HomeWeightDto():
return $default(_that.value,_that.unit,_that.trend);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double value,  String unit,  String? trend)?  $default,) {final _that = this;
switch (_that) {
case _HomeWeightDto() when $default != null:
return $default(_that.value,_that.unit,_that.trend);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeWeightDto extends HomeWeightDto {
  const _HomeWeightDto({this.value = 0, this.unit = 'kg', this.trend}): super._();
  factory _HomeWeightDto.fromJson(Map<String, dynamic> json) => _$HomeWeightDtoFromJson(json);

@override@JsonKey() final  double value;
@override@JsonKey() final  String unit;
@override final  String? trend;

/// Create a copy of HomeWeightDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeWeightDtoCopyWith<_HomeWeightDto> get copyWith => __$HomeWeightDtoCopyWithImpl<_HomeWeightDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeWeightDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeWeightDto&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.trend, trend) || other.trend == trend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,unit,trend);

@override
String toString() {
  return 'HomeWeightDto(value: $value, unit: $unit, trend: $trend)';
}


}

/// @nodoc
abstract mixin class _$HomeWeightDtoCopyWith<$Res> implements $HomeWeightDtoCopyWith<$Res> {
  factory _$HomeWeightDtoCopyWith(_HomeWeightDto value, $Res Function(_HomeWeightDto) _then) = __$HomeWeightDtoCopyWithImpl;
@override @useResult
$Res call({
 double value, String unit, String? trend
});




}
/// @nodoc
class __$HomeWeightDtoCopyWithImpl<$Res>
    implements _$HomeWeightDtoCopyWith<$Res> {
  __$HomeWeightDtoCopyWithImpl(this._self, this._then);

  final _HomeWeightDto _self;
  final $Res Function(_HomeWeightDto) _then;

/// Create a copy of HomeWeightDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? unit = null,Object? trend = freezed,}) {
  return _then(_HomeWeightDto(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,trend: freezed == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HomeUpcomingItemDto {

 String get kind; int get sourceId; int get petId; String get petName; String get title; DateTime get dueDate; bool get isOverdue;
/// Create a copy of HomeUpcomingItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeUpcomingItemDtoCopyWith<HomeUpcomingItemDto> get copyWith => _$HomeUpcomingItemDtoCopyWithImpl<HomeUpcomingItemDto>(this as HomeUpcomingItemDto, _$identity);

  /// Serializes this HomeUpcomingItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeUpcomingItemDto&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.title, title) || other.title == title)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,sourceId,petId,petName,title,dueDate,isOverdue);

@override
String toString() {
  return 'HomeUpcomingItemDto(kind: $kind, sourceId: $sourceId, petId: $petId, petName: $petName, title: $title, dueDate: $dueDate, isOverdue: $isOverdue)';
}


}

/// @nodoc
abstract mixin class $HomeUpcomingItemDtoCopyWith<$Res>  {
  factory $HomeUpcomingItemDtoCopyWith(HomeUpcomingItemDto value, $Res Function(HomeUpcomingItemDto) _then) = _$HomeUpcomingItemDtoCopyWithImpl;
@useResult
$Res call({
 String kind, int sourceId, int petId, String petName, String title, DateTime dueDate, bool isOverdue
});




}
/// @nodoc
class _$HomeUpcomingItemDtoCopyWithImpl<$Res>
    implements $HomeUpcomingItemDtoCopyWith<$Res> {
  _$HomeUpcomingItemDtoCopyWithImpl(this._self, this._then);

  final HomeUpcomingItemDto _self;
  final $Res Function(HomeUpcomingItemDto) _then;

/// Create a copy of HomeUpcomingItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? sourceId = null,Object? petId = null,Object? petName = null,Object? title = null,Object? dueDate = null,Object? isOverdue = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as int,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeUpcomingItemDto].
extension HomeUpcomingItemDtoPatterns on HomeUpcomingItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeUpcomingItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeUpcomingItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeUpcomingItemDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeUpcomingItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeUpcomingItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeUpcomingItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String kind,  int sourceId,  int petId,  String petName,  String title,  DateTime dueDate,  bool isOverdue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeUpcomingItemDto() when $default != null:
return $default(_that.kind,_that.sourceId,_that.petId,_that.petName,_that.title,_that.dueDate,_that.isOverdue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String kind,  int sourceId,  int petId,  String petName,  String title,  DateTime dueDate,  bool isOverdue)  $default,) {final _that = this;
switch (_that) {
case _HomeUpcomingItemDto():
return $default(_that.kind,_that.sourceId,_that.petId,_that.petName,_that.title,_that.dueDate,_that.isOverdue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String kind,  int sourceId,  int petId,  String petName,  String title,  DateTime dueDate,  bool isOverdue)?  $default,) {final _that = this;
switch (_that) {
case _HomeUpcomingItemDto() when $default != null:
return $default(_that.kind,_that.sourceId,_that.petId,_that.petName,_that.title,_that.dueDate,_that.isOverdue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeUpcomingItemDto extends HomeUpcomingItemDto {
  const _HomeUpcomingItemDto({this.kind = 'medication', this.sourceId = 0, this.petId = 0, this.petName = '', this.title = '', required this.dueDate, this.isOverdue = false}): super._();
  factory _HomeUpcomingItemDto.fromJson(Map<String, dynamic> json) => _$HomeUpcomingItemDtoFromJson(json);

@override@JsonKey() final  String kind;
@override@JsonKey() final  int sourceId;
@override@JsonKey() final  int petId;
@override@JsonKey() final  String petName;
@override@JsonKey() final  String title;
@override final  DateTime dueDate;
@override@JsonKey() final  bool isOverdue;

/// Create a copy of HomeUpcomingItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeUpcomingItemDtoCopyWith<_HomeUpcomingItemDto> get copyWith => __$HomeUpcomingItemDtoCopyWithImpl<_HomeUpcomingItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeUpcomingItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeUpcomingItemDto&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.title, title) || other.title == title)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,sourceId,petId,petName,title,dueDate,isOverdue);

@override
String toString() {
  return 'HomeUpcomingItemDto(kind: $kind, sourceId: $sourceId, petId: $petId, petName: $petName, title: $title, dueDate: $dueDate, isOverdue: $isOverdue)';
}


}

/// @nodoc
abstract mixin class _$HomeUpcomingItemDtoCopyWith<$Res> implements $HomeUpcomingItemDtoCopyWith<$Res> {
  factory _$HomeUpcomingItemDtoCopyWith(_HomeUpcomingItemDto value, $Res Function(_HomeUpcomingItemDto) _then) = __$HomeUpcomingItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String kind, int sourceId, int petId, String petName, String title, DateTime dueDate, bool isOverdue
});




}
/// @nodoc
class __$HomeUpcomingItemDtoCopyWithImpl<$Res>
    implements _$HomeUpcomingItemDtoCopyWith<$Res> {
  __$HomeUpcomingItemDtoCopyWithImpl(this._self, this._then);

  final _HomeUpcomingItemDto _self;
  final $Res Function(_HomeUpcomingItemDto) _then;

/// Create a copy of HomeUpcomingItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? sourceId = null,Object? petId = null,Object? petName = null,Object? title = null,Object? dueDate = null,Object? isOverdue = null,}) {
  return _then(_HomeUpcomingItemDto(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as int,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
