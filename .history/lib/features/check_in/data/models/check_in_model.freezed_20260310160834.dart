// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckInModel {

 int get id; String? get date; String? get checkIn; String? get checkOut; String? get checkInPhoto; String? get checkOutPhoto; String? get lightsStatus; String? get bannerStatus; String? get rollingDoorStatus; String? get conditionRight; String? get conditionLeft; String? get kanitUsername; String? get conditionBack; String? get conditionArround; int? get statusValue; String? get statusDescription; String? get notes;
/// Create a copy of CheckInModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckInModelCopyWith<CheckInModel> get copyWith => _$CheckInModelCopyWithImpl<CheckInModel>(this as CheckInModel, _$identity);

  /// Serializes this CheckInModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckInModel&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut)&&(identical(other.checkInPhoto, checkInPhoto) || other.checkInPhoto == checkInPhoto)&&(identical(other.checkOutPhoto, checkOutPhoto) || other.checkOutPhoto == checkOutPhoto)&&(identical(other.lightsStatus, lightsStatus) || other.lightsStatus == lightsStatus)&&(identical(other.bannerStatus, bannerStatus) || other.bannerStatus == bannerStatus)&&(identical(other.rollingDoorStatus, rollingDoorStatus) || other.rollingDoorStatus == rollingDoorStatus)&&(identical(other.conditionRight, conditionRight) || other.conditionRight == conditionRight)&&(identical(other.conditionLeft, conditionLeft) || other.conditionLeft == conditionLeft)&&(identical(other.kanitUsername, kanitUsername) || other.kanitUsername == kanitUsername)&&(identical(other.conditionBack, conditionBack) || other.conditionBack == conditionBack)&&(identical(other.conditionArround, conditionArround) || other.conditionArround == conditionArround)&&(identical(other.statusValue, statusValue) || other.statusValue == statusValue)&&(identical(other.statusDescription, statusDescription) || other.statusDescription == statusDescription)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,checkIn,checkOut,checkInPhoto,checkOutPhoto,lightsStatus,bannerStatus,rollingDoorStatus,conditionRight,conditionLeft,kanitUsername,conditionBack,conditionArround,statusValue,statusDescription,notes);

@override
String toString() {
  return 'CheckInModel(id: $id, date: $date, checkIn: $checkIn, checkOut: $checkOut, checkInPhoto: $checkInPhoto, checkOutPhoto: $checkOutPhoto, lightsStatus: $lightsStatus, bannerStatus: $bannerStatus, rollingDoorStatus: $rollingDoorStatus, conditionRight: $conditionRight, conditionLeft: $conditionLeft, kanitUsername: $kanitUsername, conditionBack: $conditionBack, conditionArround: $conditionArround, statusValue: $statusValue, statusDescription: $statusDescription, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $CheckInModelCopyWith<$Res>  {
  factory $CheckInModelCopyWith(CheckInModel value, $Res Function(CheckInModel) _then) = _$CheckInModelCopyWithImpl;
@useResult
$Res call({
 int id, String? date, String? checkIn, String? checkOut, String? checkInPhoto, String? checkOutPhoto, String? lightsStatus, String? bannerStatus, String? rollingDoorStatus, String? conditionRight, String? conditionLeft, String? kanitUsername, String? conditionBack, String? conditionArround, int? statusValue, String? statusDescription, String? notes
});




}
/// @nodoc
class _$CheckInModelCopyWithImpl<$Res>
    implements $CheckInModelCopyWith<$Res> {
  _$CheckInModelCopyWithImpl(this._self, this._then);

  final CheckInModel _self;
  final $Res Function(CheckInModel) _then;

/// Create a copy of CheckInModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = freezed,Object? checkIn = freezed,Object? checkOut = freezed,Object? checkInPhoto = freezed,Object? checkOutPhoto = freezed,Object? lightsStatus = freezed,Object? bannerStatus = freezed,Object? rollingDoorStatus = freezed,Object? conditionRight = freezed,Object? conditionLeft = freezed,Object? kanitUsername = freezed,Object? conditionBack = freezed,Object? conditionArround = freezed,Object? statusValue = freezed,Object? statusDescription = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,checkIn: freezed == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as String?,checkOut: freezed == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as String?,checkInPhoto: freezed == checkInPhoto ? _self.checkInPhoto : checkInPhoto // ignore: cast_nullable_to_non_nullable
as String?,checkOutPhoto: freezed == checkOutPhoto ? _self.checkOutPhoto : checkOutPhoto // ignore: cast_nullable_to_non_nullable
as String?,lightsStatus: freezed == lightsStatus ? _self.lightsStatus : lightsStatus // ignore: cast_nullable_to_non_nullable
as String?,bannerStatus: freezed == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as String?,rollingDoorStatus: freezed == rollingDoorStatus ? _self.rollingDoorStatus : rollingDoorStatus // ignore: cast_nullable_to_non_nullable
as String?,conditionRight: freezed == conditionRight ? _self.conditionRight : conditionRight // ignore: cast_nullable_to_non_nullable
as String?,conditionLeft: freezed == conditionLeft ? _self.conditionLeft : conditionLeft // ignore: cast_nullable_to_non_nullable
as String?,kanitUsername: freezed == kanitUsername ? _self.kanitUsername : kanitUsername // ignore: cast_nullable_to_non_nullable
as String?,conditionBack: freezed == conditionBack ? _self.conditionBack : conditionBack // ignore: cast_nullable_to_non_nullable
as String?,conditionArround: freezed == conditionArround ? _self.conditionArround : conditionArround // ignore: cast_nullable_to_non_nullable
as String?,statusValue: freezed == statusValue ? _self.statusValue : statusValue // ignore: cast_nullable_to_non_nullable
as int?,statusDescription: freezed == statusDescription ? _self.statusDescription : statusDescription // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckInModel].
extension CheckInModelPatterns on CheckInModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckInModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckInModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckInModel value)  $default,){
final _that = this;
switch (_that) {
case _CheckInModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckInModel value)?  $default,){
final _that = this;
switch (_that) {
case _CheckInModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? date,  String? checkIn,  String? checkOut,  String? checkInPhoto,  String? checkOutPhoto,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? kanitUsername,  String? conditionBack,  String? conditionArround,  int? statusValue,  String? statusDescription,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckInModel() when $default != null:
return $default(_that.id,_that.date,_that.checkIn,_that.checkOut,_that.checkInPhoto,_that.checkOutPhoto,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.kanitUsername,_that.conditionBack,_that.conditionArround,_that.statusValue,_that.statusDescription,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? date,  String? checkIn,  String? checkOut,  String? checkInPhoto,  String? checkOutPhoto,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? kanitUsername,  String? conditionBack,  String? conditionArround,  int? statusValue,  String? statusDescription,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _CheckInModel():
return $default(_that.id,_that.date,_that.checkIn,_that.checkOut,_that.checkInPhoto,_that.checkOutPhoto,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.kanitUsername,_that.conditionBack,_that.conditionArround,_that.statusValue,_that.statusDescription,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? date,  String? checkIn,  String? checkOut,  String? checkInPhoto,  String? checkOutPhoto,  String? lightsStatus,  String? bannerStatus,  String? rollingDoorStatus,  String? conditionRight,  String? conditionLeft,  String? kanitUsername,  String? conditionBack,  String? conditionArround,  int? statusValue,  String? statusDescription,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _CheckInModel() when $default != null:
return $default(_that.id,_that.date,_that.checkIn,_that.checkOut,_that.checkInPhoto,_that.checkOutPhoto,_that.lightsStatus,_that.bannerStatus,_that.rollingDoorStatus,_that.conditionRight,_that.conditionLeft,_that.kanitUsername,_that.conditionBack,_that.conditionArround,_that.statusValue,_that.statusDescription,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckInModel extends CheckInModel {
  const _CheckInModel({required this.id, this.date, this.checkIn, this.checkOut, this.checkInPhoto, this.checkOutPhoto, this.lightsStatus, this.bannerStatus, this.rollingDoorStatus, this.conditionRight, this.conditionLeft, this.kanitUsername, this.conditionBack, this.conditionArround, this.statusValue, this.statusDescription, this.notes}): super._();
  factory _CheckInModel.fromJson(Map<String, dynamic> json) => _$CheckInModelFromJson(json);

@override final  int id;
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
@override final  String? kanitUsername;
@override final  String? conditionBack;
@override final  String? conditionArround;
@override final  int? statusValue;
@override final  String? statusDescription;
@override final  String? notes;

/// Create a copy of CheckInModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInModelCopyWith<_CheckInModel> get copyWith => __$CheckInModelCopyWithImpl<_CheckInModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckInModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInModel&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn)&&(identical(other.checkOut, checkOut) || other.checkOut == checkOut)&&(identical(other.checkInPhoto, checkInPhoto) || other.checkInPhoto == checkInPhoto)&&(identical(other.checkOutPhoto, checkOutPhoto) || other.checkOutPhoto == checkOutPhoto)&&(identical(other.lightsStatus, lightsStatus) || other.lightsStatus == lightsStatus)&&(identical(other.bannerStatus, bannerStatus) || other.bannerStatus == bannerStatus)&&(identical(other.rollingDoorStatus, rollingDoorStatus) || other.rollingDoorStatus == rollingDoorStatus)&&(identical(other.conditionRight, conditionRight) || other.conditionRight == conditionRight)&&(identical(other.conditionLeft, conditionLeft) || other.conditionLeft == conditionLeft)&&(identical(other.kanitUsername, kanitUsername) || other.kanitUsername == kanitUsername)&&(identical(other.conditionBack, conditionBack) || other.conditionBack == conditionBack)&&(identical(other.conditionArround, conditionArround) || other.conditionArround == conditionArround)&&(identical(other.statusValue, statusValue) || other.statusValue == statusValue)&&(identical(other.statusDescription, statusDescription) || other.statusDescription == statusDescription)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,checkIn,checkOut,checkInPhoto,checkOutPhoto,lightsStatus,bannerStatus,rollingDoorStatus,conditionRight,conditionLeft,kanitUsername,conditionBack,conditionArround,statusValue,statusDescription,notes);

@override
String toString() {
  return 'CheckInModel(id: $id, date: $date, checkIn: $checkIn, checkOut: $checkOut, checkInPhoto: $checkInPhoto, checkOutPhoto: $checkOutPhoto, lightsStatus: $lightsStatus, bannerStatus: $bannerStatus, rollingDoorStatus: $rollingDoorStatus, conditionRight: $conditionRight, conditionLeft: $conditionLeft, kanitUsername: $kanitUsername, conditionBack: $conditionBack, conditionArround: $conditionArround, statusValue: $statusValue, statusDescription: $statusDescription, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$CheckInModelCopyWith<$Res> implements $CheckInModelCopyWith<$Res> {
  factory _$CheckInModelCopyWith(_CheckInModel value, $Res Function(_CheckInModel) _then) = __$CheckInModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String? date, String? checkIn, String? checkOut, String? checkInPhoto, String? checkOutPhoto, String? lightsStatus, String? bannerStatus, String? rollingDoorStatus, String? conditionRight, String? conditionLeft, String? kanitUsername, String? conditionBack, String? conditionArround, int? statusValue, String? statusDescription, String? notes
});




}
/// @nodoc
class __$CheckInModelCopyWithImpl<$Res>
    implements _$CheckInModelCopyWith<$Res> {
  __$CheckInModelCopyWithImpl(this._self, this._then);

  final _CheckInModel _self;
  final $Res Function(_CheckInModel) _then;

/// Create a copy of CheckInModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = freezed,Object? checkIn = freezed,Object? checkOut = freezed,Object? checkInPhoto = freezed,Object? checkOutPhoto = freezed,Object? lightsStatus = freezed,Object? bannerStatus = freezed,Object? rollingDoorStatus = freezed,Object? conditionRight = freezed,Object? conditionLeft = freezed,Object? kanitUsername = freezed,Object? conditionBack = freezed,Object? conditionArround = freezed,Object? statusValue = freezed,Object? statusDescription = freezed,Object? notes = freezed,}) {
  return _then(_CheckInModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,checkIn: freezed == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as String?,checkOut: freezed == checkOut ? _self.checkOut : checkOut // ignore: cast_nullable_to_non_nullable
as String?,checkInPhoto: freezed == checkInPhoto ? _self.checkInPhoto : checkInPhoto // ignore: cast_nullable_to_non_nullable
as String?,checkOutPhoto: freezed == checkOutPhoto ? _self.checkOutPhoto : checkOutPhoto // ignore: cast_nullable_to_non_nullable
as String?,lightsStatus: freezed == lightsStatus ? _self.lightsStatus : lightsStatus // ignore: cast_nullable_to_non_nullable
as String?,bannerStatus: freezed == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as String?,rollingDoorStatus: freezed == rollingDoorStatus ? _self.rollingDoorStatus : rollingDoorStatus // ignore: cast_nullable_to_non_nullable
as String?,conditionRight: freezed == conditionRight ? _self.conditionRight : conditionRight // ignore: cast_nullable_to_non_nullable
as String?,conditionLeft: freezed == conditionLeft ? _self.conditionLeft : conditionLeft // ignore: cast_nullable_to_non_nullable
as String?,kanitUsername: freezed == kanitUsername ? _self.kanitUsername : kanitUsername // ignore: cast_nullable_to_non_nullable
as String?,conditionBack: freezed == conditionBack ? _self.conditionBack : conditionBack // ignore: cast_nullable_to_non_nullable
as String?,conditionArround: freezed == conditionArround ? _self.conditionArround : conditionArround // ignore: cast_nullable_to_non_nullable
as String?,statusValue: freezed == statusValue ? _self.statusValue : statusValue // ignore: cast_nullable_to_non_nullable
as int?,statusDescription: freezed == statusDescription ? _self.statusDescription : statusDescription // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
