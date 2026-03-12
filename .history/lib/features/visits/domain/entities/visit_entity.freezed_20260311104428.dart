// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VisitEntity {

 int? get id; String? get date; String? get checkIn; String? get checkOut; String? get checkInPhoto; String? get checkOutPhoto; String? get lightsStatus; String? get bannerStatus; String? get rollingDoorStatus; String? get conditionRight; String? get conditionLeft; String? get conditionBack; String? get conditionArround; String? get notes; int? get statusValue; String? get statusDescription;
/// Create a copy of VisitEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisitEntityCopyWith<VisitEntity> get copyWith => _$VisitEntityCopyWithImpl<VisitEntity>(this as VisitEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut)&&(identical(other.checkInPhoto, checkInPhoto) || other.checkInPhoto == checkInPhoto)&&(identical(other.checkOutPhoto, checkOutPhoto) || other.checkOutPhoto == checkOutPhoto)&&(identical(other.lightsStatus, lightsStatus) || other.lightsStatus == lightsStatus)&&(identical(other.bannerStatus, bannerStatus) || other.bannerStatus == bannerStatus)&&(identical(other.rollingDoorStatus, rollingDoorStatus) || other.rollingDoorStatus == rollingDoorStatus)&&(identical(other.conditionRight, conditionRight) || other.conditionRight == conditionRight)&&(identical(other.conditionLeft, conditionLeft) || other.conditionLeft == conditionLeft)&&(identical(other.conditionBack, conditionBack) || other.conditionBack == conditionBack)&&(identical(other.conditionArround, conditionArround) || other.conditionArround == conditionArround)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.statusValue, statusValue) || other.statusValue == statusValue)&&(identical(other.statusDescription, statusDescription) || other.statusDescription == statusDescription));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,checkIn,checkOut,checkInPhoto,checkOutPhoto,lightsStatus,bannerStatus,rollingDoorStatus,conditionRight,conditionLeft,conditionBack,conditionArround,notes,statusValue,statusDescription);

@override
String toString() {
  return 'VisitEntity(id: $id, date: $date, checkIn: $checkIn, checkOut: $checkOut, checkInPhoto: $checkInPhoto, checkOutPhoto: $checkOutPhoto, lightsStatus: $lightsStatus, bannerStatus: $bannerStatus, rollingDoorStatus: $rollingDoorStatus, conditionRight: $conditionRight, conditionLeft: $conditionLeft, conditionBack: $conditionBack, conditionArround: $conditionArround, notes: $notes, statusValue: $statusValue, statusDescription: $statusDescription)';
}


}

/// @nodoc
abstract mixin class $VisitEntityCopyWith<$Res>  {
  factory $VisitEntityCopyWith(VisitEntity value, $Res Function(VisitEntity) _then) = _$VisitEntityCopyWithImpl;
@useResult
$Res call({
 int? id, String? date, String? checkIn, String? checkOut, String? checkInPhoto, String? checkOutPhoto, String? lightsStatus, String? bannerStatus, String? rollingDoorStatus, String? conditionRight, String? conditionLeft, String? conditionBack, String? conditionArround, String? notes, int? statusValue, String? statusDescription
});




}
/// @nodoc
class _$VisitEntityCopyWithImpl<$Res>
    implements $VisitEntityCopyWith<$Res> {
  _$VisitEntityCopyWithImpl(this._self, this._then);

  final VisitEntity _self;
  final $Res Function(VisitEntity) _then;

/// Create a copy of VisitEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? date = freezed,Object? checkIn = freezed,Object? checkOut = freezed,Object? checkInPhoto = freezed,Object? checkOutPhoto = freezed,Object? lightsStatus = freezed,Object? bannerStatus = freezed,Object? rollingDoorStatus = freezed,Object? conditionRight = freezed,Object? conditionLeft = freezed,Object? conditionBack = freezed,Object? conditionArround = freezed,Object? notes = freezed,Object? statusValue = freezed,Object? statusDescription = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,checkIn: freezed == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as String?,checkOut: freezed == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as String?,checkInPhoto: freezed == checkInPhoto ? _self.checkInPhoto : checkInPhoto // ignore: cast_nullable_to_non_nullable
as String?,checkOutPhoto: freezed == checkOutPhoto ? _self.checkOutPhoto : checkOutPhoto // ignore: cast_nullable_to_non_nullable
as String?,lightsStatus: freezed == lightsStatus ? _self.lightsStatus : lightsStatus // ignore: cast_nullable_to_non_nullable
as String?,bannerStatus: freezed == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as String?,rollingDoorStatus: freezed == rollingDoorStatus ? _self.rollingDoorStatus : rollingDoorStatus // ignore: cast_nullable_to_non_nullable
as String?,conditionRight: freezed == conditionRight ? _self.conditionRight : conditionRight // ignore: cast_nullable_to_non_nullable
as String?,conditionLeft: freezed == conditionLeft ? _self.conditionLeft : conditionLeft // ignore: cast_nullable_to_non_nullable
as String?,conditionBack: freezed == conditionBack ? _self.conditionBack : conditionBack // ignore: cast_nullable_to_non_nullable
as String?,conditionArround: freezed == conditionArround ? _self.conditionArround : conditionArround // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,statusValue: freezed == statusValue ? _self.statusValue : statusValue // ignore: cast_nullable_to_non_nullable
as int?,statusDescription: freezed == statusDescription ? _self.statusDescription : statusDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VisitEntity].
extension VisitEntityPatterns on VisitEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisitEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisitEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisitEntity value)  $default,){
final _that = this;
switch (_that) {
case _VisitEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisitEntity value)?  $default,){
final _that = this;
switch (_that) {
case _VisitEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? date,  String? checkIn,  String? checkOut,  String? checkInPhoto,  String? checkOutPhoto,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? conditionBack,  String? conditionArround,  String? notes,  int? statusValue,  String? statusDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisitEntity() when $default != null:
return $default(_that.id,_that.date,_that.checkIn,_that.checkOut,_that.checkInPhoto,_that.checkOutPhoto,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.conditionBack,_that.conditionArround,_that.notes,_that.statusValue,_that.statusDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? date,  String? checkIn,  String? checkOut,  String? checkInPhoto,  String? checkOutPhoto,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? conditionBack,  String? conditionArround,  String? notes,  int? statusValue,  String? statusDescription)  $default,) {final _that = this;
switch (_that) {
case _VisitEntity():
return $default(_that.id,_that.date,_that.checkIn,_that.checkOut,_that.checkInPhoto,_that.checkOutPhoto,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.conditionBack,_that.conditionArround,_that.notes,_that.statusValue,_that.statusDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? date,  String? checkIn,  String? checkOut,  String? checkInPhoto,  String? checkOutPhoto,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? conditionBack,  String? conditionArround,  String? notes,  int? statusValue,  String? statusDescription)?  $default,) {final _that = this;
switch (_that) {
case _VisitEntity() when $default != null:
return $default(_that.id,_that.date,_that.checkIn,_that.checkOut,_that.checkInPhoto,_that.checkOutPhoto,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.conditionBack,_that.conditionArround,_that.notes,_that.statusValue,_that.statusDescription);case _:
  return null;

}
}

}

/// @nodoc


class _VisitEntity implements VisitEntity {
  const _VisitEntity({this.id, this.date, this.checkIn, this.checkOut, this.checkInPhoto, this.checkOutPhoto, this.lightsStatus, this.bannerStatus, this.rollingDoorStatus, this.conditionRight, this.conditionLeft, this.conditionBack, this.conditionArround, this.notes, this.statusValue, this.statusDescription});
  

@override final  int? id;
@override final  String? date;
@override final  String? checkIn;
@override final  String? checkOut;
@override final  String? checkInPhoto;
@override final  String? checkOutPhoto;
@override final  String? lightsStatus;
@override final  String? bannerStatus;
@override final  String? rollingDoorStatus;
@override final  String? conditionRight;
@override final  String? conditionLeft;
@override final  String? conditionBack;
@override final  String? conditionArround;
@override final  String? notes;
@override final  int? statusValue;
@override final  String? statusDescription;

/// Create a copy of VisitEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisitEntityCopyWith<_VisitEntity> get copyWith => __$VisitEntityCopyWithImpl<_VisitEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisitEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut)&&(identical(other.checkInPhoto, checkInPhoto) || other.checkInPhoto == checkInPhoto)&&(identical(other.checkOutPhoto, checkOutPhoto) || other.checkOutPhoto == checkOutPhoto)&&(identical(other.lightsStatus, lightsStatus) || other.lightsStatus == lightsStatus)&&(identical(other.bannerStatus, bannerStatus) || other.bannerStatus == bannerStatus)&&(identical(other.rollingDoorStatus, rollingDoorStatus) || other.rollingDoorStatus == rollingDoorStatus)&&(identical(other.conditionRight, conditionRight) || other.conditionRight == conditionRight)&&(identical(other.conditionLeft, conditionLeft) || other.conditionLeft == conditionLeft)&&(identical(other.conditionBack, conditionBack) || other.conditionBack == conditionBack)&&(identical(other.conditionArround, conditionArround) || other.conditionArround == conditionArround)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.statusValue, statusValue) || other.statusValue == statusValue)&&(identical(other.statusDescription, statusDescription) || other.statusDescription == statusDescription));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,checkIn,checkOut,checkInPhoto,checkOutPhoto,lightsStatus,bannerStatus,rollingDoorStatus,conditionRight,conditionLeft,conditionBack,conditionArround,notes,statusValue,statusDescription);

@override
String toString() {
  return 'VisitEntity(id: $id, date: $date, checkIn: $checkIn, checkOut: $checkOut, checkInPhoto: $checkInPhoto, checkOutPhoto: $checkOutPhoto, lightsStatus: $lightsStatus, bannerStatus: $bannerStatus, rollingDoorStatus: $rollingDoorStatus, conditionRight: $conditionRight, conditionLeft: $conditionLeft, conditionBack: $conditionBack, conditionArround: $conditionArround, notes: $notes, statusValue: $statusValue, statusDescription: $statusDescription)';
}


}

/// @nodoc
abstract mixin class _$VisitEntityCopyWith<$Res> implements $VisitEntityCopyWith<$Res> {
  factory _$VisitEntityCopyWith(_VisitEntity value, $Res Function(_VisitEntity) _then) = __$VisitEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? date, String? checkIn, String? checkOut, String? checkInPhoto, String? checkOutPhoto, String? lightsStatus, String? bannerStatus, String? rollingDoorStatus, String? conditionRight, String? conditionLeft, String? conditionBack, String? conditionArround, String? notes, int? statusValue, String? statusDescription
});




}
/// @nodoc
class __$VisitEntityCopyWithImpl<$Res>
    implements _$VisitEntityCopyWith<$Res> {
  __$VisitEntityCopyWithImpl(this._self, this._then);

  final _VisitEntity _self;
  final $Res Function(_VisitEntity) _then;

/// Create a copy of VisitEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? date = freezed,Object? checkIn = freezed,Object? checkOut = freezed,Object? checkInPhoto = freezed,Object? checkOutPhoto = freezed,Object? lightsStatus = freezed,Object? bannerStatus = freezed,Object? rollingDoorStatus = freezed,Object? conditionRight = freezed,Object? conditionLeft = freezed,Object? conditionBack = freezed,Object? conditionArround = freezed,Object? notes = freezed,Object? statusValue = freezed,Object? statusDescription = freezed,}) {
  return _then(_VisitEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,checkIn: freezed == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as String?,checkOut: freezed == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as String?,checkInPhoto: freezed == checkInPhoto ? _self.checkInPhoto : checkInPhoto // ignore: cast_nullable_to_non_nullable
as String?,checkOutPhoto: freezed == checkOutPhoto ? _self.checkOutPhoto : checkOutPhoto // ignore: cast_nullable_to_non_nullable
as String?,lightsStatus: freezed == lightsStatus ? _self.lightsStatus : lightsStatus // ignore: cast_nullable_to_non_nullable
as String?,bannerStatus: freezed == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as String?,rollingDoorStatus: freezed == rollingDoorStatus ? _self.rollingDoorStatus : rollingDoorStatus // ignore: cast_nullable_to_non_nullable
as String?,conditionRight: freezed == conditionRight ? _self.conditionRight : conditionRight // ignore: cast_nullable_to_non_nullable
as String?,conditionLeft: freezed == conditionLeft ? _self.conditionLeft : conditionLeft // ignore: cast_nullable_to_non_nullable
as String?,conditionBack: freezed == conditionBack ? _self.conditionBack : conditionBack // ignore: cast_nullable_to_non_nullable
as String?,conditionArround: freezed == conditionArround ? _self.conditionArround : conditionArround // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,statusValue: freezed == statusValue ? _self.statusValue : statusValue // ignore: cast_nullable_to_non_nullable
as int?,statusDescription: freezed == statusDescription ? _self.statusDescription : statusDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
