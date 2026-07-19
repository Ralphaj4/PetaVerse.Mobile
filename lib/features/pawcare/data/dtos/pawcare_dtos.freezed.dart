// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pawcare_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeightRecordDto {

 int get id; double get weight; String get unit; DateTime get recordedDate; String? get notes;
/// Create a copy of WeightRecordDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeightRecordDtoCopyWith<WeightRecordDto> get copyWith => _$WeightRecordDtoCopyWithImpl<WeightRecordDto>(this as WeightRecordDto, _$identity);

  /// Serializes this WeightRecordDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeightRecordDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.recordedDate, recordedDate) || other.recordedDate == recordedDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weight,unit,recordedDate,notes);

@override
String toString() {
  return 'WeightRecordDto(id: $id, weight: $weight, unit: $unit, recordedDate: $recordedDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $WeightRecordDtoCopyWith<$Res>  {
  factory $WeightRecordDtoCopyWith(WeightRecordDto value, $Res Function(WeightRecordDto) _then) = _$WeightRecordDtoCopyWithImpl;
@useResult
$Res call({
 int id, double weight, String unit, DateTime recordedDate, String? notes
});




}
/// @nodoc
class _$WeightRecordDtoCopyWithImpl<$Res>
    implements $WeightRecordDtoCopyWith<$Res> {
  _$WeightRecordDtoCopyWithImpl(this._self, this._then);

  final WeightRecordDto _self;
  final $Res Function(WeightRecordDto) _then;

/// Create a copy of WeightRecordDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weight = null,Object? unit = null,Object? recordedDate = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,recordedDate: null == recordedDate ? _self.recordedDate : recordedDate // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeightRecordDto].
extension WeightRecordDtoPatterns on WeightRecordDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeightRecordDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeightRecordDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeightRecordDto value)  $default,){
final _that = this;
switch (_that) {
case _WeightRecordDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeightRecordDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeightRecordDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  double weight,  String unit,  DateTime recordedDate,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeightRecordDto() when $default != null:
return $default(_that.id,_that.weight,_that.unit,_that.recordedDate,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  double weight,  String unit,  DateTime recordedDate,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _WeightRecordDto():
return $default(_that.id,_that.weight,_that.unit,_that.recordedDate,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  double weight,  String unit,  DateTime recordedDate,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _WeightRecordDto() when $default != null:
return $default(_that.id,_that.weight,_that.unit,_that.recordedDate,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeightRecordDto extends WeightRecordDto {
  const _WeightRecordDto({required this.id, this.weight = 0, this.unit = 'kg', required this.recordedDate, this.notes}): super._();
  factory _WeightRecordDto.fromJson(Map<String, dynamic> json) => _$WeightRecordDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  double weight;
@override@JsonKey() final  String unit;
@override final  DateTime recordedDate;
@override final  String? notes;

/// Create a copy of WeightRecordDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeightRecordDtoCopyWith<_WeightRecordDto> get copyWith => __$WeightRecordDtoCopyWithImpl<_WeightRecordDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeightRecordDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeightRecordDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.recordedDate, recordedDate) || other.recordedDate == recordedDate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weight,unit,recordedDate,notes);

@override
String toString() {
  return 'WeightRecordDto(id: $id, weight: $weight, unit: $unit, recordedDate: $recordedDate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$WeightRecordDtoCopyWith<$Res> implements $WeightRecordDtoCopyWith<$Res> {
  factory _$WeightRecordDtoCopyWith(_WeightRecordDto value, $Res Function(_WeightRecordDto) _then) = __$WeightRecordDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, double weight, String unit, DateTime recordedDate, String? notes
});




}
/// @nodoc
class __$WeightRecordDtoCopyWithImpl<$Res>
    implements _$WeightRecordDtoCopyWith<$Res> {
  __$WeightRecordDtoCopyWithImpl(this._self, this._then);

  final _WeightRecordDto _self;
  final $Res Function(_WeightRecordDto) _then;

/// Create a copy of WeightRecordDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weight = null,Object? unit = null,Object? recordedDate = null,Object? notes = freezed,}) {
  return _then(_WeightRecordDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,recordedDate: null == recordedDate ? _self.recordedDate : recordedDate // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MedicationDto {

 int get id; String get medicationName; int get frequencyDays; DateTime get nextDueDate; DateTime? get lastGivenDate; DateTime? get startDate; DateTime? get endDate; bool get isActive; bool get isDueSoon; bool get isOverdue; String? get notes;
/// Create a copy of MedicationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicationDtoCopyWith<MedicationDto> get copyWith => _$MedicationDtoCopyWithImpl<MedicationDto>(this as MedicationDto, _$identity);

  /// Serializes this MedicationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.medicationName, medicationName) || other.medicationName == medicationName)&&(identical(other.frequencyDays, frequencyDays) || other.frequencyDays == frequencyDays)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.lastGivenDate, lastGivenDate) || other.lastGivenDate == lastGivenDate)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDueSoon, isDueSoon) || other.isDueSoon == isDueSoon)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,medicationName,frequencyDays,nextDueDate,lastGivenDate,startDate,endDate,isActive,isDueSoon,isOverdue,notes);

@override
String toString() {
  return 'MedicationDto(id: $id, medicationName: $medicationName, frequencyDays: $frequencyDays, nextDueDate: $nextDueDate, lastGivenDate: $lastGivenDate, startDate: $startDate, endDate: $endDate, isActive: $isActive, isDueSoon: $isDueSoon, isOverdue: $isOverdue, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $MedicationDtoCopyWith<$Res>  {
  factory $MedicationDtoCopyWith(MedicationDto value, $Res Function(MedicationDto) _then) = _$MedicationDtoCopyWithImpl;
@useResult
$Res call({
 int id, String medicationName, int frequencyDays, DateTime nextDueDate, DateTime? lastGivenDate, DateTime? startDate, DateTime? endDate, bool isActive, bool isDueSoon, bool isOverdue, String? notes
});




}
/// @nodoc
class _$MedicationDtoCopyWithImpl<$Res>
    implements $MedicationDtoCopyWith<$Res> {
  _$MedicationDtoCopyWithImpl(this._self, this._then);

  final MedicationDto _self;
  final $Res Function(MedicationDto) _then;

/// Create a copy of MedicationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? medicationName = null,Object? frequencyDays = null,Object? nextDueDate = null,Object? lastGivenDate = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isActive = null,Object? isDueSoon = null,Object? isOverdue = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,medicationName: null == medicationName ? _self.medicationName : medicationName // ignore: cast_nullable_to_non_nullable
as String,frequencyDays: null == frequencyDays ? _self.frequencyDays : frequencyDays // ignore: cast_nullable_to_non_nullable
as int,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastGivenDate: freezed == lastGivenDate ? _self.lastGivenDate : lastGivenDate // ignore: cast_nullable_to_non_nullable
as DateTime?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDueSoon: null == isDueSoon ? _self.isDueSoon : isDueSoon // ignore: cast_nullable_to_non_nullable
as bool,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicationDto].
extension MedicationDtoPatterns on MedicationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicationDto value)  $default,){
final _that = this;
switch (_that) {
case _MedicationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicationDto value)?  $default,){
final _that = this;
switch (_that) {
case _MedicationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String medicationName,  int frequencyDays,  DateTime nextDueDate,  DateTime? lastGivenDate,  DateTime? startDate,  DateTime? endDate,  bool isActive,  bool isDueSoon,  bool isOverdue,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicationDto() when $default != null:
return $default(_that.id,_that.medicationName,_that.frequencyDays,_that.nextDueDate,_that.lastGivenDate,_that.startDate,_that.endDate,_that.isActive,_that.isDueSoon,_that.isOverdue,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String medicationName,  int frequencyDays,  DateTime nextDueDate,  DateTime? lastGivenDate,  DateTime? startDate,  DateTime? endDate,  bool isActive,  bool isDueSoon,  bool isOverdue,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _MedicationDto():
return $default(_that.id,_that.medicationName,_that.frequencyDays,_that.nextDueDate,_that.lastGivenDate,_that.startDate,_that.endDate,_that.isActive,_that.isDueSoon,_that.isOverdue,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String medicationName,  int frequencyDays,  DateTime nextDueDate,  DateTime? lastGivenDate,  DateTime? startDate,  DateTime? endDate,  bool isActive,  bool isDueSoon,  bool isOverdue,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _MedicationDto() when $default != null:
return $default(_that.id,_that.medicationName,_that.frequencyDays,_that.nextDueDate,_that.lastGivenDate,_that.startDate,_that.endDate,_that.isActive,_that.isDueSoon,_that.isOverdue,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MedicationDto extends MedicationDto {
  const _MedicationDto({required this.id, this.medicationName = '', this.frequencyDays = 1, required this.nextDueDate, this.lastGivenDate, this.startDate, this.endDate, this.isActive = true, this.isDueSoon = false, this.isOverdue = false, this.notes}): super._();
  factory _MedicationDto.fromJson(Map<String, dynamic> json) => _$MedicationDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String medicationName;
@override@JsonKey() final  int frequencyDays;
@override final  DateTime nextDueDate;
@override final  DateTime? lastGivenDate;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isDueSoon;
@override@JsonKey() final  bool isOverdue;
@override final  String? notes;

/// Create a copy of MedicationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicationDtoCopyWith<_MedicationDto> get copyWith => __$MedicationDtoCopyWithImpl<_MedicationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedicationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.medicationName, medicationName) || other.medicationName == medicationName)&&(identical(other.frequencyDays, frequencyDays) || other.frequencyDays == frequencyDays)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.lastGivenDate, lastGivenDate) || other.lastGivenDate == lastGivenDate)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDueSoon, isDueSoon) || other.isDueSoon == isDueSoon)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,medicationName,frequencyDays,nextDueDate,lastGivenDate,startDate,endDate,isActive,isDueSoon,isOverdue,notes);

@override
String toString() {
  return 'MedicationDto(id: $id, medicationName: $medicationName, frequencyDays: $frequencyDays, nextDueDate: $nextDueDate, lastGivenDate: $lastGivenDate, startDate: $startDate, endDate: $endDate, isActive: $isActive, isDueSoon: $isDueSoon, isOverdue: $isOverdue, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$MedicationDtoCopyWith<$Res> implements $MedicationDtoCopyWith<$Res> {
  factory _$MedicationDtoCopyWith(_MedicationDto value, $Res Function(_MedicationDto) _then) = __$MedicationDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String medicationName, int frequencyDays, DateTime nextDueDate, DateTime? lastGivenDate, DateTime? startDate, DateTime? endDate, bool isActive, bool isDueSoon, bool isOverdue, String? notes
});




}
/// @nodoc
class __$MedicationDtoCopyWithImpl<$Res>
    implements _$MedicationDtoCopyWith<$Res> {
  __$MedicationDtoCopyWithImpl(this._self, this._then);

  final _MedicationDto _self;
  final $Res Function(_MedicationDto) _then;

/// Create a copy of MedicationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? medicationName = null,Object? frequencyDays = null,Object? nextDueDate = null,Object? lastGivenDate = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isActive = null,Object? isDueSoon = null,Object? isOverdue = null,Object? notes = freezed,}) {
  return _then(_MedicationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,medicationName: null == medicationName ? _self.medicationName : medicationName // ignore: cast_nullable_to_non_nullable
as String,frequencyDays: null == frequencyDays ? _self.frequencyDays : frequencyDays // ignore: cast_nullable_to_non_nullable
as int,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastGivenDate: freezed == lastGivenDate ? _self.lastGivenDate : lastGivenDate // ignore: cast_nullable_to_non_nullable
as DateTime?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDueSoon: null == isDueSoon ? _self.isDueSoon : isDueSoon // ignore: cast_nullable_to_non_nullable
as bool,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpcomingMedicationDto {

 int get medicationHistoryId; int get petId; String get petName; String get medicationName; DateTime get nextDueDate; int get daysUntilDue; bool get isOverdue;
/// Create a copy of UpcomingMedicationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingMedicationDtoCopyWith<UpcomingMedicationDto> get copyWith => _$UpcomingMedicationDtoCopyWithImpl<UpcomingMedicationDto>(this as UpcomingMedicationDto, _$identity);

  /// Serializes this UpcomingMedicationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingMedicationDto&&(identical(other.medicationHistoryId, medicationHistoryId) || other.medicationHistoryId == medicationHistoryId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.medicationName, medicationName) || other.medicationName == medicationName)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.daysUntilDue, daysUntilDue) || other.daysUntilDue == daysUntilDue)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,medicationHistoryId,petId,petName,medicationName,nextDueDate,daysUntilDue,isOverdue);

@override
String toString() {
  return 'UpcomingMedicationDto(medicationHistoryId: $medicationHistoryId, petId: $petId, petName: $petName, medicationName: $medicationName, nextDueDate: $nextDueDate, daysUntilDue: $daysUntilDue, isOverdue: $isOverdue)';
}


}

/// @nodoc
abstract mixin class $UpcomingMedicationDtoCopyWith<$Res>  {
  factory $UpcomingMedicationDtoCopyWith(UpcomingMedicationDto value, $Res Function(UpcomingMedicationDto) _then) = _$UpcomingMedicationDtoCopyWithImpl;
@useResult
$Res call({
 int medicationHistoryId, int petId, String petName, String medicationName, DateTime nextDueDate, int daysUntilDue, bool isOverdue
});




}
/// @nodoc
class _$UpcomingMedicationDtoCopyWithImpl<$Res>
    implements $UpcomingMedicationDtoCopyWith<$Res> {
  _$UpcomingMedicationDtoCopyWithImpl(this._self, this._then);

  final UpcomingMedicationDto _self;
  final $Res Function(UpcomingMedicationDto) _then;

/// Create a copy of UpcomingMedicationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? medicationHistoryId = null,Object? petId = null,Object? petName = null,Object? medicationName = null,Object? nextDueDate = null,Object? daysUntilDue = null,Object? isOverdue = null,}) {
  return _then(_self.copyWith(
medicationHistoryId: null == medicationHistoryId ? _self.medicationHistoryId : medicationHistoryId // ignore: cast_nullable_to_non_nullable
as int,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,medicationName: null == medicationName ? _self.medicationName : medicationName // ignore: cast_nullable_to_non_nullable
as String,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,daysUntilDue: null == daysUntilDue ? _self.daysUntilDue : daysUntilDue // ignore: cast_nullable_to_non_nullable
as int,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UpcomingMedicationDto].
extension UpcomingMedicationDtoPatterns on UpcomingMedicationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingMedicationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingMedicationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingMedicationDto value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingMedicationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingMedicationDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingMedicationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int medicationHistoryId,  int petId,  String petName,  String medicationName,  DateTime nextDueDate,  int daysUntilDue,  bool isOverdue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingMedicationDto() when $default != null:
return $default(_that.medicationHistoryId,_that.petId,_that.petName,_that.medicationName,_that.nextDueDate,_that.daysUntilDue,_that.isOverdue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int medicationHistoryId,  int petId,  String petName,  String medicationName,  DateTime nextDueDate,  int daysUntilDue,  bool isOverdue)  $default,) {final _that = this;
switch (_that) {
case _UpcomingMedicationDto():
return $default(_that.medicationHistoryId,_that.petId,_that.petName,_that.medicationName,_that.nextDueDate,_that.daysUntilDue,_that.isOverdue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int medicationHistoryId,  int petId,  String petName,  String medicationName,  DateTime nextDueDate,  int daysUntilDue,  bool isOverdue)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingMedicationDto() when $default != null:
return $default(_that.medicationHistoryId,_that.petId,_that.petName,_that.medicationName,_that.nextDueDate,_that.daysUntilDue,_that.isOverdue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpcomingMedicationDto extends UpcomingMedicationDto {
  const _UpcomingMedicationDto({required this.medicationHistoryId, required this.petId, this.petName = '', this.medicationName = '', required this.nextDueDate, this.daysUntilDue = 0, this.isOverdue = false}): super._();
  factory _UpcomingMedicationDto.fromJson(Map<String, dynamic> json) => _$UpcomingMedicationDtoFromJson(json);

@override final  int medicationHistoryId;
@override final  int petId;
@override@JsonKey() final  String petName;
@override@JsonKey() final  String medicationName;
@override final  DateTime nextDueDate;
@override@JsonKey() final  int daysUntilDue;
@override@JsonKey() final  bool isOverdue;

/// Create a copy of UpcomingMedicationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingMedicationDtoCopyWith<_UpcomingMedicationDto> get copyWith => __$UpcomingMedicationDtoCopyWithImpl<_UpcomingMedicationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpcomingMedicationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingMedicationDto&&(identical(other.medicationHistoryId, medicationHistoryId) || other.medicationHistoryId == medicationHistoryId)&&(identical(other.petId, petId) || other.petId == petId)&&(identical(other.petName, petName) || other.petName == petName)&&(identical(other.medicationName, medicationName) || other.medicationName == medicationName)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.daysUntilDue, daysUntilDue) || other.daysUntilDue == daysUntilDue)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,medicationHistoryId,petId,petName,medicationName,nextDueDate,daysUntilDue,isOverdue);

@override
String toString() {
  return 'UpcomingMedicationDto(medicationHistoryId: $medicationHistoryId, petId: $petId, petName: $petName, medicationName: $medicationName, nextDueDate: $nextDueDate, daysUntilDue: $daysUntilDue, isOverdue: $isOverdue)';
}


}

/// @nodoc
abstract mixin class _$UpcomingMedicationDtoCopyWith<$Res> implements $UpcomingMedicationDtoCopyWith<$Res> {
  factory _$UpcomingMedicationDtoCopyWith(_UpcomingMedicationDto value, $Res Function(_UpcomingMedicationDto) _then) = __$UpcomingMedicationDtoCopyWithImpl;
@override @useResult
$Res call({
 int medicationHistoryId, int petId, String petName, String medicationName, DateTime nextDueDate, int daysUntilDue, bool isOverdue
});




}
/// @nodoc
class __$UpcomingMedicationDtoCopyWithImpl<$Res>
    implements _$UpcomingMedicationDtoCopyWith<$Res> {
  __$UpcomingMedicationDtoCopyWithImpl(this._self, this._then);

  final _UpcomingMedicationDto _self;
  final $Res Function(_UpcomingMedicationDto) _then;

/// Create a copy of UpcomingMedicationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? medicationHistoryId = null,Object? petId = null,Object? petName = null,Object? medicationName = null,Object? nextDueDate = null,Object? daysUntilDue = null,Object? isOverdue = null,}) {
  return _then(_UpcomingMedicationDto(
medicationHistoryId: null == medicationHistoryId ? _self.medicationHistoryId : medicationHistoryId // ignore: cast_nullable_to_non_nullable
as int,petId: null == petId ? _self.petId : petId // ignore: cast_nullable_to_non_nullable
as int,petName: null == petName ? _self.petName : petName // ignore: cast_nullable_to_non_nullable
as String,medicationName: null == medicationName ? _self.medicationName : medicationName // ignore: cast_nullable_to_non_nullable
as String,nextDueDate: null == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime,daysUntilDue: null == daysUntilDue ? _self.daysUntilDue : daysUntilDue // ignore: cast_nullable_to_non_nullable
as int,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$VaccinationDto {

 int get id; String get vaccineName; DateTime get dateAdministered; DateTime? get nextDueDate; String? get vetName; String? get notes; String? get documentUrl;
/// Create a copy of VaccinationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaccinationDtoCopyWith<VaccinationDto> get copyWith => _$VaccinationDtoCopyWithImpl<VaccinationDto>(this as VaccinationDto, _$identity);

  /// Serializes this VaccinationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaccinationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.vaccineName, vaccineName) || other.vaccineName == vaccineName)&&(identical(other.dateAdministered, dateAdministered) || other.dateAdministered == dateAdministered)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.vetName, vetName) || other.vetName == vetName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.documentUrl, documentUrl) || other.documentUrl == documentUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vaccineName,dateAdministered,nextDueDate,vetName,notes,documentUrl);

@override
String toString() {
  return 'VaccinationDto(id: $id, vaccineName: $vaccineName, dateAdministered: $dateAdministered, nextDueDate: $nextDueDate, vetName: $vetName, notes: $notes, documentUrl: $documentUrl)';
}


}

/// @nodoc
abstract mixin class $VaccinationDtoCopyWith<$Res>  {
  factory $VaccinationDtoCopyWith(VaccinationDto value, $Res Function(VaccinationDto) _then) = _$VaccinationDtoCopyWithImpl;
@useResult
$Res call({
 int id, String vaccineName, DateTime dateAdministered, DateTime? nextDueDate, String? vetName, String? notes, String? documentUrl
});




}
/// @nodoc
class _$VaccinationDtoCopyWithImpl<$Res>
    implements $VaccinationDtoCopyWith<$Res> {
  _$VaccinationDtoCopyWithImpl(this._self, this._then);

  final VaccinationDto _self;
  final $Res Function(VaccinationDto) _then;

/// Create a copy of VaccinationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vaccineName = null,Object? dateAdministered = null,Object? nextDueDate = freezed,Object? vetName = freezed,Object? notes = freezed,Object? documentUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,vaccineName: null == vaccineName ? _self.vaccineName : vaccineName // ignore: cast_nullable_to_non_nullable
as String,dateAdministered: null == dateAdministered ? _self.dateAdministered : dateAdministered // ignore: cast_nullable_to_non_nullable
as DateTime,nextDueDate: freezed == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,vetName: freezed == vetName ? _self.vetName : vetName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,documentUrl: freezed == documentUrl ? _self.documentUrl : documentUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VaccinationDto].
extension VaccinationDtoPatterns on VaccinationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaccinationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaccinationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaccinationDto value)  $default,){
final _that = this;
switch (_that) {
case _VaccinationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaccinationDto value)?  $default,){
final _that = this;
switch (_that) {
case _VaccinationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String vaccineName,  DateTime dateAdministered,  DateTime? nextDueDate,  String? vetName,  String? notes,  String? documentUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaccinationDto() when $default != null:
return $default(_that.id,_that.vaccineName,_that.dateAdministered,_that.nextDueDate,_that.vetName,_that.notes,_that.documentUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String vaccineName,  DateTime dateAdministered,  DateTime? nextDueDate,  String? vetName,  String? notes,  String? documentUrl)  $default,) {final _that = this;
switch (_that) {
case _VaccinationDto():
return $default(_that.id,_that.vaccineName,_that.dateAdministered,_that.nextDueDate,_that.vetName,_that.notes,_that.documentUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String vaccineName,  DateTime dateAdministered,  DateTime? nextDueDate,  String? vetName,  String? notes,  String? documentUrl)?  $default,) {final _that = this;
switch (_that) {
case _VaccinationDto() when $default != null:
return $default(_that.id,_that.vaccineName,_that.dateAdministered,_that.nextDueDate,_that.vetName,_that.notes,_that.documentUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VaccinationDto extends VaccinationDto {
  const _VaccinationDto({required this.id, this.vaccineName = '', required this.dateAdministered, this.nextDueDate, this.vetName, this.notes, this.documentUrl}): super._();
  factory _VaccinationDto.fromJson(Map<String, dynamic> json) => _$VaccinationDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String vaccineName;
@override final  DateTime dateAdministered;
@override final  DateTime? nextDueDate;
@override final  String? vetName;
@override final  String? notes;
@override final  String? documentUrl;

/// Create a copy of VaccinationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaccinationDtoCopyWith<_VaccinationDto> get copyWith => __$VaccinationDtoCopyWithImpl<_VaccinationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaccinationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaccinationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.vaccineName, vaccineName) || other.vaccineName == vaccineName)&&(identical(other.dateAdministered, dateAdministered) || other.dateAdministered == dateAdministered)&&(identical(other.nextDueDate, nextDueDate) || other.nextDueDate == nextDueDate)&&(identical(other.vetName, vetName) || other.vetName == vetName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.documentUrl, documentUrl) || other.documentUrl == documentUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vaccineName,dateAdministered,nextDueDate,vetName,notes,documentUrl);

@override
String toString() {
  return 'VaccinationDto(id: $id, vaccineName: $vaccineName, dateAdministered: $dateAdministered, nextDueDate: $nextDueDate, vetName: $vetName, notes: $notes, documentUrl: $documentUrl)';
}


}

/// @nodoc
abstract mixin class _$VaccinationDtoCopyWith<$Res> implements $VaccinationDtoCopyWith<$Res> {
  factory _$VaccinationDtoCopyWith(_VaccinationDto value, $Res Function(_VaccinationDto) _then) = __$VaccinationDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String vaccineName, DateTime dateAdministered, DateTime? nextDueDate, String? vetName, String? notes, String? documentUrl
});




}
/// @nodoc
class __$VaccinationDtoCopyWithImpl<$Res>
    implements _$VaccinationDtoCopyWith<$Res> {
  __$VaccinationDtoCopyWithImpl(this._self, this._then);

  final _VaccinationDto _self;
  final $Res Function(_VaccinationDto) _then;

/// Create a copy of VaccinationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vaccineName = null,Object? dateAdministered = null,Object? nextDueDate = freezed,Object? vetName = freezed,Object? notes = freezed,Object? documentUrl = freezed,}) {
  return _then(_VaccinationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,vaccineName: null == vaccineName ? _self.vaccineName : vaccineName // ignore: cast_nullable_to_non_nullable
as String,dateAdministered: null == dateAdministered ? _self.dateAdministered : dateAdministered // ignore: cast_nullable_to_non_nullable
as DateTime,nextDueDate: freezed == nextDueDate ? _self.nextDueDate : nextDueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,vetName: freezed == vetName ? _self.vetName : vetName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,documentUrl: freezed == documentUrl ? _self.documentUrl : documentUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MedicationLookupDto {

 int get id; String get name; String? get dosage; String? get frequency;
/// Create a copy of MedicationLookupDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicationLookupDtoCopyWith<MedicationLookupDto> get copyWith => _$MedicationLookupDtoCopyWithImpl<MedicationLookupDto>(this as MedicationLookupDto, _$identity);

  /// Serializes this MedicationLookupDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicationLookupDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dosage, dosage) || other.dosage == dosage)&&(identical(other.frequency, frequency) || other.frequency == frequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,dosage,frequency);

@override
String toString() {
  return 'MedicationLookupDto(id: $id, name: $name, dosage: $dosage, frequency: $frequency)';
}


}

/// @nodoc
abstract mixin class $MedicationLookupDtoCopyWith<$Res>  {
  factory $MedicationLookupDtoCopyWith(MedicationLookupDto value, $Res Function(MedicationLookupDto) _then) = _$MedicationLookupDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? dosage, String? frequency
});




}
/// @nodoc
class _$MedicationLookupDtoCopyWithImpl<$Res>
    implements $MedicationLookupDtoCopyWith<$Res> {
  _$MedicationLookupDtoCopyWithImpl(this._self, this._then);

  final MedicationLookupDto _self;
  final $Res Function(MedicationLookupDto) _then;

/// Create a copy of MedicationLookupDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? dosage = freezed,Object? frequency = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dosage: freezed == dosage ? _self.dosage : dosage // ignore: cast_nullable_to_non_nullable
as String?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicationLookupDto].
extension MedicationLookupDtoPatterns on MedicationLookupDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicationLookupDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicationLookupDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicationLookupDto value)  $default,){
final _that = this;
switch (_that) {
case _MedicationLookupDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicationLookupDto value)?  $default,){
final _that = this;
switch (_that) {
case _MedicationLookupDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? dosage,  String? frequency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicationLookupDto() when $default != null:
return $default(_that.id,_that.name,_that.dosage,_that.frequency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? dosage,  String? frequency)  $default,) {final _that = this;
switch (_that) {
case _MedicationLookupDto():
return $default(_that.id,_that.name,_that.dosage,_that.frequency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? dosage,  String? frequency)?  $default,) {final _that = this;
switch (_that) {
case _MedicationLookupDto() when $default != null:
return $default(_that.id,_that.name,_that.dosage,_that.frequency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MedicationLookupDto extends MedicationLookupDto {
  const _MedicationLookupDto({required this.id, this.name = '', this.dosage, this.frequency}): super._();
  factory _MedicationLookupDto.fromJson(Map<String, dynamic> json) => _$MedicationLookupDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? dosage;
@override final  String? frequency;

/// Create a copy of MedicationLookupDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicationLookupDtoCopyWith<_MedicationLookupDto> get copyWith => __$MedicationLookupDtoCopyWithImpl<_MedicationLookupDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedicationLookupDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicationLookupDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dosage, dosage) || other.dosage == dosage)&&(identical(other.frequency, frequency) || other.frequency == frequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,dosage,frequency);

@override
String toString() {
  return 'MedicationLookupDto(id: $id, name: $name, dosage: $dosage, frequency: $frequency)';
}


}

/// @nodoc
abstract mixin class _$MedicationLookupDtoCopyWith<$Res> implements $MedicationLookupDtoCopyWith<$Res> {
  factory _$MedicationLookupDtoCopyWith(_MedicationLookupDto value, $Res Function(_MedicationLookupDto) _then) = __$MedicationLookupDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? dosage, String? frequency
});




}
/// @nodoc
class __$MedicationLookupDtoCopyWithImpl<$Res>
    implements _$MedicationLookupDtoCopyWith<$Res> {
  __$MedicationLookupDtoCopyWithImpl(this._self, this._then);

  final _MedicationLookupDto _self;
  final $Res Function(_MedicationLookupDto) _then;

/// Create a copy of MedicationLookupDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? dosage = freezed,Object? frequency = freezed,}) {
  return _then(_MedicationLookupDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dosage: freezed == dosage ? _self.dosage : dosage // ignore: cast_nullable_to_non_nullable
as String?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$VaccineLookupDto {

 int get id; String get name; String? get syndicateCode;
/// Create a copy of VaccineLookupDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaccineLookupDtoCopyWith<VaccineLookupDto> get copyWith => _$VaccineLookupDtoCopyWithImpl<VaccineLookupDto>(this as VaccineLookupDto, _$identity);

  /// Serializes this VaccineLookupDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaccineLookupDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.syndicateCode, syndicateCode) || other.syndicateCode == syndicateCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,syndicateCode);

@override
String toString() {
  return 'VaccineLookupDto(id: $id, name: $name, syndicateCode: $syndicateCode)';
}


}

/// @nodoc
abstract mixin class $VaccineLookupDtoCopyWith<$Res>  {
  factory $VaccineLookupDtoCopyWith(VaccineLookupDto value, $Res Function(VaccineLookupDto) _then) = _$VaccineLookupDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? syndicateCode
});




}
/// @nodoc
class _$VaccineLookupDtoCopyWithImpl<$Res>
    implements $VaccineLookupDtoCopyWith<$Res> {
  _$VaccineLookupDtoCopyWithImpl(this._self, this._then);

  final VaccineLookupDto _self;
  final $Res Function(VaccineLookupDto) _then;

/// Create a copy of VaccineLookupDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? syndicateCode = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,syndicateCode: freezed == syndicateCode ? _self.syndicateCode : syndicateCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VaccineLookupDto].
extension VaccineLookupDtoPatterns on VaccineLookupDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaccineLookupDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaccineLookupDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaccineLookupDto value)  $default,){
final _that = this;
switch (_that) {
case _VaccineLookupDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaccineLookupDto value)?  $default,){
final _that = this;
switch (_that) {
case _VaccineLookupDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? syndicateCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaccineLookupDto() when $default != null:
return $default(_that.id,_that.name,_that.syndicateCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? syndicateCode)  $default,) {final _that = this;
switch (_that) {
case _VaccineLookupDto():
return $default(_that.id,_that.name,_that.syndicateCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? syndicateCode)?  $default,) {final _that = this;
switch (_that) {
case _VaccineLookupDto() when $default != null:
return $default(_that.id,_that.name,_that.syndicateCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VaccineLookupDto extends VaccineLookupDto {
  const _VaccineLookupDto({required this.id, this.name = '', this.syndicateCode}): super._();
  factory _VaccineLookupDto.fromJson(Map<String, dynamic> json) => _$VaccineLookupDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? syndicateCode;

/// Create a copy of VaccineLookupDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaccineLookupDtoCopyWith<_VaccineLookupDto> get copyWith => __$VaccineLookupDtoCopyWithImpl<_VaccineLookupDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaccineLookupDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaccineLookupDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.syndicateCode, syndicateCode) || other.syndicateCode == syndicateCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,syndicateCode);

@override
String toString() {
  return 'VaccineLookupDto(id: $id, name: $name, syndicateCode: $syndicateCode)';
}


}

/// @nodoc
abstract mixin class _$VaccineLookupDtoCopyWith<$Res> implements $VaccineLookupDtoCopyWith<$Res> {
  factory _$VaccineLookupDtoCopyWith(_VaccineLookupDto value, $Res Function(_VaccineLookupDto) _then) = __$VaccineLookupDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? syndicateCode
});




}
/// @nodoc
class __$VaccineLookupDtoCopyWithImpl<$Res>
    implements _$VaccineLookupDtoCopyWith<$Res> {
  __$VaccineLookupDtoCopyWithImpl(this._self, this._then);

  final _VaccineLookupDto _self;
  final $Res Function(_VaccineLookupDto) _then;

/// Create a copy of VaccineLookupDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? syndicateCode = freezed,}) {
  return _then(_VaccineLookupDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,syndicateCode: freezed == syndicateCode ? _self.syndicateCode : syndicateCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
