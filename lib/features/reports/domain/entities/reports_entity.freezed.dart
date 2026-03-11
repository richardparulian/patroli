// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsEntity {

 int? get id; String? get date; String? get checkIn; String? get checkOut; CreatedEntity? get createdBy; BranchEntity? get branch; String? get checkInPhoto; String? get checkOutPhoto; String? get lightsStatus; String? get bannerStatus; String? get rollingDoorStatus; String? get conditionRight; String? get conditionLeft; String? get conditionBack; String? get conditionAround; int? get statusValue; String? get statusDescription; String? get notes;
/// Create a copy of ReportsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsEntityCopyWith<ReportsEntity> get copyWith => _$ReportsEntityCopyWithImpl<ReportsEntity>(this as ReportsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.branch, branch) || other.branch == branch)&&(identical(other.checkInPhoto, checkInPhoto) || other.checkInPhoto == checkInPhoto)&&(identical(other.checkOutPhoto, checkOutPhoto) || other.checkOutPhoto == checkOutPhoto)&&(identical(other.lightsStatus, lightsStatus) || other.lightsStatus == lightsStatus)&&(identical(other.bannerStatus, bannerStatus) || other.bannerStatus == bannerStatus)&&(identical(other.rollingDoorStatus, rollingDoorStatus) || other.rollingDoorStatus == rollingDoorStatus)&&(identical(other.conditionRight, conditionRight) || other.conditionRight == conditionRight)&&(identical(other.conditionLeft, conditionLeft) || other.conditionLeft == conditionLeft)&&(identical(other.conditionBack, conditionBack) || other.conditionBack == conditionBack)&&(identical(other.conditionAround, conditionAround) || other.conditionAround == conditionAround)&&(identical(other.statusValue, statusValue) || other.statusValue == statusValue)&&(identical(other.statusDescription, statusDescription) || other.statusDescription == statusDescription)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,checkIn,checkOut,createdBy,branch,checkInPhoto,checkOutPhoto,lightsStatus,bannerStatus,rollingDoorStatus,conditionRight,conditionLeft,conditionBack,conditionAround,statusValue,statusDescription,notes);

@override
String toString() {
  return 'ReportsEntity(id: $id, date: $date, checkIn: $checkIn, checkOut: $checkOut, createdBy: $createdBy, branch: $branch, checkInPhoto: $checkInPhoto, checkOutPhoto: $checkOutPhoto, lightsStatus: $lightsStatus, bannerStatus: $bannerStatus, rollingDoorStatus: $rollingDoorStatus, conditionRight: $conditionRight, conditionLeft: $conditionLeft, conditionBack: $conditionBack, conditionAround: $conditionAround, statusValue: $statusValue, statusDescription: $statusDescription, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $ReportsEntityCopyWith<$Res>  {
  factory $ReportsEntityCopyWith(ReportsEntity value, $Res Function(ReportsEntity) _then) = _$ReportsEntityCopyWithImpl;
@useResult
$Res call({
 int? id, String? date, String? checkIn, String? checkOut, CreatedEntity? createdBy, BranchEntity? branch, String? checkInPhoto, String? checkOutPhoto, String? lightsStatus, String? bannerStatus, String? rollingDoorStatus, String? conditionRight, String? conditionLeft, String? conditionBack, String? conditionAround, int? statusValue, String? statusDescription, String? notes
});


$CreatedEntityCopyWith<$Res>? get createdBy;$BranchEntityCopyWith<$Res>? get branch;

}
/// @nodoc
class _$ReportsEntityCopyWithImpl<$Res>
    implements $ReportsEntityCopyWith<$Res> {
  _$ReportsEntityCopyWithImpl(this._self, this._then);

  final ReportsEntity _self;
  final $Res Function(ReportsEntity) _then;

/// Create a copy of ReportsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? date = freezed,Object? checkIn = freezed,Object? checkOut = freezed,Object? createdBy = freezed,Object? branch = freezed,Object? checkInPhoto = freezed,Object? checkOutPhoto = freezed,Object? lightsStatus = freezed,Object? bannerStatus = freezed,Object? rollingDoorStatus = freezed,Object? conditionRight = freezed,Object? conditionLeft = freezed,Object? conditionBack = freezed,Object? conditionAround = freezed,Object? statusValue = freezed,Object? statusDescription = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,checkIn: freezed == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as String?,checkOut: freezed == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CreatedEntity?,branch: freezed == branch ? _self.branch : branch // ignore: cast_nullable_to_non_nullable
as BranchEntity?,checkInPhoto: freezed == checkInPhoto ? _self.checkInPhoto : checkInPhoto // ignore: cast_nullable_to_non_nullable
as String?,checkOutPhoto: freezed == checkOutPhoto ? _self.checkOutPhoto : checkOutPhoto // ignore: cast_nullable_to_non_nullable
as String?,lightsStatus: freezed == lightsStatus ? _self.lightsStatus : lightsStatus // ignore: cast_nullable_to_non_nullable
as String?,bannerStatus: freezed == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as String?,rollingDoorStatus: freezed == rollingDoorStatus ? _self.rollingDoorStatus : rollingDoorStatus // ignore: cast_nullable_to_non_nullable
as String?,conditionRight: freezed == conditionRight ? _self.conditionRight : conditionRight // ignore: cast_nullable_to_non_nullable
as String?,conditionLeft: freezed == conditionLeft ? _self.conditionLeft : conditionLeft // ignore: cast_nullable_to_non_nullable
as String?,conditionBack: freezed == conditionBack ? _self.conditionBack : conditionBack // ignore: cast_nullable_to_non_nullable
as String?,conditionAround: freezed == conditionAround ? _self.conditionAround : conditionAround // ignore: cast_nullable_to_non_nullable
as String?,statusValue: freezed == statusValue ? _self.statusValue : statusValue // ignore: cast_nullable_to_non_nullable
as int?,statusDescription: freezed == statusDescription ? _self.statusDescription : statusDescription // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReportsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreatedEntityCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $CreatedEntityCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}/// Create a copy of ReportsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BranchEntityCopyWith<$Res>? get branch {
    if (_self.branch == null) {
    return null;
  }

  return $BranchEntityCopyWith<$Res>(_self.branch!, (value) {
    return _then(_self.copyWith(branch: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportsEntity].
extension ReportsEntityPatterns on ReportsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportsEntity value)  $default,){
final _that = this;
switch (_that) {
case _ReportsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ReportsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? date,  String? checkIn,  String? checkOut,  CreatedEntity? createdBy,  BranchEntity? branch,  String? checkInPhoto,  String? checkOutPhoto,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? conditionBack,  String? conditionAround,  int? statusValue,  String? statusDescription,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportsEntity() when $default != null:
return $default(_that.id,_that.date,_that.checkIn,_that.checkOut,_that.createdBy,_that.branch,_that.checkInPhoto,_that.checkOutPhoto,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.conditionBack,_that.conditionAround,_that.statusValue,_that.statusDescription,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? date,  String? checkIn,  String? checkOut,  CreatedEntity? createdBy,  BranchEntity? branch,  String? checkInPhoto,  String? checkOutPhoto,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? conditionBack,  String? conditionAround,  int? statusValue,  String? statusDescription,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _ReportsEntity():
return $default(_that.id,_that.date,_that.checkIn,_that.checkOut,_that.createdBy,_that.branch,_that.checkInPhoto,_that.checkOutPhoto,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.conditionBack,_that.conditionAround,_that.statusValue,_that.statusDescription,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? date,  String? checkIn,  String? checkOut,  CreatedEntity? createdBy,  BranchEntity? branch,  String? checkInPhoto,  String? checkOutPhoto,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? conditionBack,  String? conditionAround,  int? statusValue,  String? statusDescription,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _ReportsEntity() when $default != null:
return $default(_that.id,_that.date,_that.checkIn,_that.checkOut,_that.createdBy,_that.branch,_that.checkInPhoto,_that.checkOutPhoto,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.conditionBack,_that.conditionAround,_that.statusValue,_that.statusDescription,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _ReportsEntity extends ReportsEntity {
  const _ReportsEntity({this.id, this.date, this.checkIn, this.checkOut, this.createdBy, this.branch, this.checkInPhoto, this.checkOutPhoto, this.lightsStatus, this.bannerStatus, this.rollingDoorStatus, this.conditionRight, this.conditionLeft, this.conditionBack, this.conditionAround, this.statusValue, this.statusDescription, this.notes}): super._();
  

@override final  int? id;
@override final  String? date;
@override final  String? checkIn;
@override final  String? checkOut;
@override final  CreatedEntity? createdBy;
@override final  BranchEntity? branch;
@override final  String? checkInPhoto;
@override final  String? checkOutPhoto;
@override final  String? lightsStatus;
@override final  String? bannerStatus;
@override final  String? rollingDoorStatus;
@override final  String? conditionRight;
@override final  String? conditionLeft;
@override final  String? conditionBack;
@override final  String? conditionAround;
@override final  int? statusValue;
@override final  String? statusDescription;
@override final  String? notes;

/// Create a copy of ReportsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsEntityCopyWith<_ReportsEntity> get copyWith => __$ReportsEntityCopyWithImpl<_ReportsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.branch, branch) || other.branch == branch)&&(identical(other.checkInPhoto, checkInPhoto) || other.checkInPhoto == checkInPhoto)&&(identical(other.checkOutPhoto, checkOutPhoto) || other.checkOutPhoto == checkOutPhoto)&&(identical(other.lightsStatus, lightsStatus) || other.lightsStatus == lightsStatus)&&(identical(other.bannerStatus, bannerStatus) || other.bannerStatus == bannerStatus)&&(identical(other.rollingDoorStatus, rollingDoorStatus) || other.rollingDoorStatus == rollingDoorStatus)&&(identical(other.conditionRight, conditionRight) || other.conditionRight == conditionRight)&&(identical(other.conditionLeft, conditionLeft) || other.conditionLeft == conditionLeft)&&(identical(other.conditionBack, conditionBack) || other.conditionBack == conditionBack)&&(identical(other.conditionAround, conditionAround) || other.conditionAround == conditionAround)&&(identical(other.statusValue, statusValue) || other.statusValue == statusValue)&&(identical(other.statusDescription, statusDescription) || other.statusDescription == statusDescription)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,checkIn,checkOut,createdBy,branch,checkInPhoto,checkOutPhoto,lightsStatus,bannerStatus,rollingDoorStatus,conditionRight,conditionLeft,conditionBack,conditionAround,statusValue,statusDescription,notes);

@override
String toString() {
  return 'ReportsEntity(id: $id, date: $date, checkIn: $checkIn, checkOut: $checkOut, createdBy: $createdBy, branch: $branch, checkInPhoto: $checkInPhoto, checkOutPhoto: $checkOutPhoto, lightsStatus: $lightsStatus, bannerStatus: $bannerStatus, rollingDoorStatus: $rollingDoorStatus, conditionRight: $conditionRight, conditionLeft: $conditionLeft, conditionBack: $conditionBack, conditionAround: $conditionAround, statusValue: $statusValue, statusDescription: $statusDescription, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ReportsEntityCopyWith<$Res> implements $ReportsEntityCopyWith<$Res> {
  factory _$ReportsEntityCopyWith(_ReportsEntity value, $Res Function(_ReportsEntity) _then) = __$ReportsEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? date, String? checkIn, String? checkOut, CreatedEntity? createdBy, BranchEntity? branch, String? checkInPhoto, String? checkOutPhoto, String? lightsStatus, String? bannerStatus, String? rollingDoorStatus, String? conditionRight, String? conditionLeft, String? conditionBack, String? conditionAround, int? statusValue, String? statusDescription, String? notes
});


@override $CreatedEntityCopyWith<$Res>? get createdBy;@override $BranchEntityCopyWith<$Res>? get branch;

}
/// @nodoc
class __$ReportsEntityCopyWithImpl<$Res>
    implements _$ReportsEntityCopyWith<$Res> {
  __$ReportsEntityCopyWithImpl(this._self, this._then);

  final _ReportsEntity _self;
  final $Res Function(_ReportsEntity) _then;

/// Create a copy of ReportsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? date = freezed,Object? checkIn = freezed,Object? checkOut = freezed,Object? createdBy = freezed,Object? branch = freezed,Object? checkInPhoto = freezed,Object? checkOutPhoto = freezed,Object? lightsStatus = freezed,Object? bannerStatus = freezed,Object? rollingDoorStatus = freezed,Object? conditionRight = freezed,Object? conditionLeft = freezed,Object? conditionBack = freezed,Object? conditionAround = freezed,Object? statusValue = freezed,Object? statusDescription = freezed,Object? notes = freezed,}) {
  return _then(_ReportsEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,checkIn: freezed == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as String?,checkOut: freezed == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CreatedEntity?,branch: freezed == branch ? _self.branch : branch // ignore: cast_nullable_to_non_nullable
as BranchEntity?,checkInPhoto: freezed == checkInPhoto ? _self.checkInPhoto : checkInPhoto // ignore: cast_nullable_to_non_nullable
as String?,checkOutPhoto: freezed == checkOutPhoto ? _self.checkOutPhoto : checkOutPhoto // ignore: cast_nullable_to_non_nullable
as String?,lightsStatus: freezed == lightsStatus ? _self.lightsStatus : lightsStatus // ignore: cast_nullable_to_non_nullable
as String?,bannerStatus: freezed == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as String?,rollingDoorStatus: freezed == rollingDoorStatus ? _self.rollingDoorStatus : rollingDoorStatus // ignore: cast_nullable_to_non_nullable
as String?,conditionRight: freezed == conditionRight ? _self.conditionRight : conditionRight // ignore: cast_nullable_to_non_nullable
as String?,conditionLeft: freezed == conditionLeft ? _self.conditionLeft : conditionLeft // ignore: cast_nullable_to_non_nullable
as String?,conditionBack: freezed == conditionBack ? _self.conditionBack : conditionBack // ignore: cast_nullable_to_non_nullable
as String?,conditionAround: freezed == conditionAround ? _self.conditionAround : conditionAround // ignore: cast_nullable_to_non_nullable
as String?,statusValue: freezed == statusValue ? _self.statusValue : statusValue // ignore: cast_nullable_to_non_nullable
as int?,statusDescription: freezed == statusDescription ? _self.statusDescription : statusDescription // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReportsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreatedEntityCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $CreatedEntityCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}/// Create a copy of ReportsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BranchEntityCopyWith<$Res>? get branch {
    if (_self.branch == null) {
    return null;
  }

  return $BranchEntityCopyWith<$Res>(_self.branch!, (value) {
    return _then(_self.copyWith(branch: value));
  });
}
}

// dart format on
