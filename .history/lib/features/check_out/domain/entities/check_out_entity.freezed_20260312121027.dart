// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_out_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckOutEntity {

 int? get id; int? get branchId; int? get createdBy; String? get selfieCheckIn; String? get selfieCheckOut; String? get checkOutAt; String? get date; int? get status; String? get lightsStatus; String? get bannerStatus; String? get rollingDoorStatus; String? get conditionRight; String? get conditionLeft; String? get conditionBack; String? get conditionAround; String? get notes; String? get createdAt; String? get updatedAt;
/// Create a copy of CheckOutEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckOutEntityCopyWith<CheckOutEntity> get copyWith => _$CheckOutEntityCopyWithImpl<CheckOutEntity>(this as CheckOutEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckOutEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.selfieCheckIn, selfieCheckIn) || other.selfieCheckIn == selfieCheckIn)&&(identical(other.selfieCheckOut, selfieCheckOut) || other.selfieCheckOut == selfieCheckOut)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.lightsStatus, lightsStatus) || other.lightsStatus == lightsStatus)&&(identical(other.bannerStatus, bannerStatus) || other.bannerStatus == bannerStatus)&&(identical(other.rollingDoorStatus, rollingDoorStatus) || other.rollingDoorStatus == rollingDoorStatus)&&(identical(other.conditionRight, conditionRight) || other.conditionRight == conditionRight)&&(identical(other.conditionLeft, conditionLeft) || other.conditionLeft == conditionLeft)&&(identical(other.conditionBack, conditionBack) || other.conditionBack == conditionBack)&&(identical(other.conditionAround, conditionAround) || other.conditionAround == conditionAround)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,branchId,createdBy,selfieCheckIn,selfieCheckOut,checkOutAt,date,status,lightsStatus,bannerStatus,rollingDoorStatus,conditionRight,conditionLeft,conditionBack,conditionAround,notes,createdAt,updatedAt);

@override
String toString() {
  return 'CheckOutEntity(id: $id, branchId: $branchId, createdBy: $createdBy, selfieCheckIn: $selfieCheckIn, selfieCheckOut: $selfieCheckOut, checkOutAt: $checkOutAt, date: $date, status: $status, lightsStatus: $lightsStatus, bannerStatus: $bannerStatus, rollingDoorStatus: $rollingDoorStatus, conditionRight: $conditionRight, conditionLeft: $conditionLeft, conditionBack: $conditionBack, conditionAround: $conditionAround, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CheckOutEntityCopyWith<$Res>  {
  factory $CheckOutEntityCopyWith(CheckOutEntity value, $Res Function(CheckOutEntity) _then) = _$CheckOutEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int? branchId, int? createdBy, String? selfieCheckIn, String? selfieCheckOut, String? checkOutAt, String? date, int? status, String? lightsStatus, String? bannerStatus, String? rollingDoorStatus, String? conditionRight, String? conditionLeft, String? conditionBack, String? conditionAround, String? notes, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$CheckOutEntityCopyWithImpl<$Res>
    implements $CheckOutEntityCopyWith<$Res> {
  _$CheckOutEntityCopyWithImpl(this._self, this._then);

  final CheckOutEntity _self;
  final $Res Function(CheckOutEntity) _then;

/// Create a copy of CheckOutEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? branchId = freezed,Object? createdBy = freezed,Object? selfieCheckIn = freezed,Object? selfieCheckOut = freezed,Object? checkOutAt = freezed,Object? date = freezed,Object? status = freezed,Object? lightsStatus = freezed,Object? bannerStatus = freezed,Object? rollingDoorStatus = freezed,Object? conditionRight = freezed,Object? conditionLeft = freezed,Object? conditionBack = freezed,Object? conditionAround = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,selfieCheckIn: freezed == selfieCheckIn ? _self.selfieCheckIn : selfieCheckIn // ignore: cast_nullable_to_non_nullable
as String?,selfieCheckOut: freezed == selfieCheckOut ? _self.selfieCheckOut : selfieCheckOut // ignore: cast_nullable_to_non_nullable
as String?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,lightsStatus: freezed == lightsStatus ? _self.lightsStatus : lightsStatus // ignore: cast_nullable_to_non_nullable
as String?,bannerStatus: freezed == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as String?,rollingDoorStatus: freezed == rollingDoorStatus ? _self.rollingDoorStatus : rollingDoorStatus // ignore: cast_nullable_to_non_nullable
as String?,conditionRight: freezed == conditionRight ? _self.conditionRight : conditionRight // ignore: cast_nullable_to_non_nullable
as String?,conditionLeft: freezed == conditionLeft ? _self.conditionLeft : conditionLeft // ignore: cast_nullable_to_non_nullable
as String?,conditionBack: freezed == conditionBack ? _self.conditionBack : conditionBack // ignore: cast_nullable_to_non_nullable
as String?,conditionAround: freezed == conditionAround ? _self.conditionAround : conditionAround // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckOutEntity].
extension CheckOutEntityPatterns on CheckOutEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckOutEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckOutEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckOutEntity value)  $default,){
final _that = this;
switch (_that) {
case _CheckOutEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckOutEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CheckOutEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? branchId,  int? createdBy,  String? selfieCheckIn,  String? selfieCheckOut,  String? checkOutAt,  String? date,  int? status,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? conditionBack,  String? conditionAround,  String? notes,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckOutEntity() when $default != null:
return $default(_that.id,_that.branchId,_that.createdBy,_that.selfieCheckIn,_that.selfieCheckOut,_that.checkOutAt,_that.date,_that.status,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.conditionBack,_that.conditionAround,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? branchId,  int? createdBy,  String? selfieCheckIn,  String? selfieCheckOut,  String? checkOutAt,  String? date,  int? status,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? conditionBack,  String? conditionAround,  String? notes,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CheckOutEntity():
return $default(_that.id,_that.branchId,_that.createdBy,_that.selfieCheckIn,_that.selfieCheckOut,_that.checkOutAt,_that.date,_that.status,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.conditionBack,_that.conditionAround,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? branchId,  int? createdBy,  String? selfieCheckIn,  String? selfieCheckOut,  String? checkOutAt,  String? date,  int? status,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? conditionBack,  String? conditionAround,  String? notes,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CheckOutEntity() when $default != null:
return $default(_that.id,_that.branchId,_that.createdBy,_that.selfieCheckIn,_that.selfieCheckOut,_that.checkOutAt,_that.date,_that.status,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.conditionBack,_that.conditionAround,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CheckOutEntity implements CheckOutEntity {
  const _CheckOutEntity({this.id, this.branchId, this.createdBy, this.selfieCheckIn, this.selfieCheckOut, this.checkOutAt, this.date, this.status, this.lightsStatus, this.bannerStatus, this.rollingDoorStatus, this.conditionRight, this.conditionLeft, this.conditionBack, this.conditionAround, this.notes, this.createdAt, this.updatedAt});
  

@override final  int? id;
@override final  int? branchId;
@override final  int? createdBy;
@override final  String? selfieCheckIn;
@override final  String? selfieCheckOut;
@override final  String? checkOutAt;
@override final  String? date;
@override final  int? status;
@override final  String? lightsStatus;
@override final  String? bannerStatus;
@override final  String? rollingDoorStatus;
@override final  String? conditionRight;
@override final  String? conditionLeft;
@override final  String? conditionBack;
@override final  String? conditionAround;
@override final  String? notes;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of CheckOutEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckOutEntityCopyWith<_CheckOutEntity> get copyWith => __$CheckOutEntityCopyWithImpl<_CheckOutEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckOutEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.selfieCheckIn, selfieCheckIn) || other.selfieCheckIn == selfieCheckIn)&&(identical(other.selfieCheckOut, selfieCheckOut) || other.selfieCheckOut == selfieCheckOut)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.lightsStatus, lightsStatus) || other.lightsStatus == lightsStatus)&&(identical(other.bannerStatus, bannerStatus) || other.bannerStatus == bannerStatus)&&(identical(other.rollingDoorStatus, rollingDoorStatus) || other.rollingDoorStatus == rollingDoorStatus)&&(identical(other.conditionRight, conditionRight) || other.conditionRight == conditionRight)&&(identical(other.conditionLeft, conditionLeft) || other.conditionLeft == conditionLeft)&&(identical(other.conditionBack, conditionBack) || other.conditionBack == conditionBack)&&(identical(other.conditionAround, conditionAround) || other.conditionAround == conditionAround)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,branchId,createdBy,selfieCheckIn,selfieCheckOut,checkOutAt,date,status,lightsStatus,bannerStatus,rollingDoorStatus,conditionRight,conditionLeft,conditionBack,conditionAround,notes,createdAt,updatedAt);

@override
String toString() {
  return 'CheckOutEntity(id: $id, branchId: $branchId, createdBy: $createdBy, selfieCheckIn: $selfieCheckIn, selfieCheckOut: $selfieCheckOut, checkOutAt: $checkOutAt, date: $date, status: $status, lightsStatus: $lightsStatus, bannerStatus: $bannerStatus, rollingDoorStatus: $rollingDoorStatus, conditionRight: $conditionRight, conditionLeft: $conditionLeft, conditionBack: $conditionBack, conditionAround: $conditionAround, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CheckOutEntityCopyWith<$Res> implements $CheckOutEntityCopyWith<$Res> {
  factory _$CheckOutEntityCopyWith(_CheckOutEntity value, $Res Function(_CheckOutEntity) _then) = __$CheckOutEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? branchId, int? createdBy, String? selfieCheckIn, String? selfieCheckOut, String? checkOutAt, String? date, int? status, String? lightsStatus, String? bannerStatus, String? rollingDoorStatus, String? conditionRight, String? conditionLeft, String? conditionBack, String? conditionAround, String? notes, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$CheckOutEntityCopyWithImpl<$Res>
    implements _$CheckOutEntityCopyWith<$Res> {
  __$CheckOutEntityCopyWithImpl(this._self, this._then);

  final _CheckOutEntity _self;
  final $Res Function(_CheckOutEntity) _then;

/// Create a copy of CheckOutEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? branchId = freezed,Object? createdBy = freezed,Object? selfieCheckIn = freezed,Object? selfieCheckOut = freezed,Object? checkOutAt = freezed,Object? date = freezed,Object? status = freezed,Object? lightsStatus = freezed,Object? bannerStatus = freezed,Object? rollingDoorStatus = freezed,Object? conditionRight = freezed,Object? conditionLeft = freezed,Object? conditionBack = freezed,Object? conditionAround = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CheckOutEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,selfieCheckIn: freezed == selfieCheckIn ? _self.selfieCheckIn : selfieCheckIn // ignore: cast_nullable_to_non_nullable
as String?,selfieCheckOut: freezed == selfieCheckOut ? _self.selfieCheckOut : selfieCheckOut // ignore: cast_nullable_to_non_nullable
as String?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,lightsStatus: freezed == lightsStatus ? _self.lightsStatus : lightsStatus // ignore: cast_nullable_to_non_nullable
as String?,bannerStatus: freezed == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as String?,rollingDoorStatus: freezed == rollingDoorStatus ? _self.rollingDoorStatus : rollingDoorStatus // ignore: cast_nullable_to_non_nullable
as String?,conditionRight: freezed == conditionRight ? _self.conditionRight : conditionRight // ignore: cast_nullable_to_non_nullable
as String?,conditionLeft: freezed == conditionLeft ? _self.conditionLeft : conditionLeft // ignore: cast_nullable_to_non_nullable
as String?,conditionBack: freezed == conditionBack ? _self.conditionBack : conditionBack // ignore: cast_nullable_to_non_nullable
as String?,conditionAround: freezed == conditionAround ? _self.conditionAround : conditionAround // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
