// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attention.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttentionEntity {

 int? get id; int? get branchId; String? get notes; String? get conditionRightNotes; String? get conditionLeftNotes; String? get conditionBackNotes; String? get conditionAroundNotes; int? get requireAttentions; int? get conditionRightType; int? get conditionLeftType; int? get conditionBackType; int? get conditionAroundType;
/// Create a copy of AttentionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttentionEntityCopyWith<AttentionEntity> get copyWith => _$AttentionEntityCopyWithImpl<AttentionEntity>(this as AttentionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttentionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.conditionRightNotes, conditionRightNotes) || other.conditionRightNotes == conditionRightNotes)&&(identical(other.conditionLeftNotes, conditionLeftNotes) || other.conditionLeftNotes == conditionLeftNotes)&&(identical(other.conditionBackNotes, conditionBackNotes) || other.conditionBackNotes == conditionBackNotes)&&(identical(other.conditionAroundNotes, conditionAroundNotes) || other.conditionAroundNotes == conditionAroundNotes)&&(identical(other.requireAttentions, requireAttentions) || other.requireAttentions == requireAttentions)&&(identical(other.conditionRightType, conditionRightType) || other.conditionRightType == conditionRightType)&&(identical(other.conditionLeftType, conditionLeftType) || other.conditionLeftType == conditionLeftType)&&(identical(other.conditionBackType, conditionBackType) || other.conditionBackType == conditionBackType)&&(identical(other.conditionAroundType, conditionAroundType) || other.conditionAroundType == conditionAroundType));
}


@override
int get hashCode => Object.hash(runtimeType,id,branchId,notes,conditionRightNotes,conditionLeftNotes,conditionBackNotes,conditionAroundNotes,requireAttentions,conditionRightType,conditionLeftType,conditionBackType,conditionAroundType);

@override
String toString() {
  return 'AttentionEntity(id: $id, branchId: $branchId, notes: $notes, conditionRightNotes: $conditionRightNotes, conditionLeftNotes: $conditionLeftNotes, conditionBackNotes: $conditionBackNotes, conditionAroundNotes: $conditionAroundNotes, requireAttentions: $requireAttentions, conditionRightType: $conditionRightType, conditionLeftType: $conditionLeftType, conditionBackType: $conditionBackType, conditionAroundType: $conditionAroundType)';
}


}

/// @nodoc
abstract mixin class $AttentionEntityCopyWith<$Res>  {
  factory $AttentionEntityCopyWith(AttentionEntity value, $Res Function(AttentionEntity) _then) = _$AttentionEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int? branchId, String? notes, String? conditionRightNotes, String? conditionLeftNotes, String? conditionBackNotes, String? conditionAroundNotes, int? requireAttentions, int? conditionRightType, int? conditionLeftType, int? conditionBackType, int? conditionAroundType
});




}
/// @nodoc
class _$AttentionEntityCopyWithImpl<$Res>
    implements $AttentionEntityCopyWith<$Res> {
  _$AttentionEntityCopyWithImpl(this._self, this._then);

  final AttentionEntity _self;
  final $Res Function(AttentionEntity) _then;

/// Create a copy of AttentionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? branchId = freezed,Object? notes = freezed,Object? conditionRightNotes = freezed,Object? conditionLeftNotes = freezed,Object? conditionBackNotes = freezed,Object? conditionAroundNotes = freezed,Object? requireAttentions = freezed,Object? conditionRightType = freezed,Object? conditionLeftType = freezed,Object? conditionBackType = freezed,Object? conditionAroundType = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,conditionRightNotes: freezed == conditionRightNotes ? _self.conditionRightNotes : conditionRightNotes // ignore: cast_nullable_to_non_nullable
as String?,conditionLeftNotes: freezed == conditionLeftNotes ? _self.conditionLeftNotes : conditionLeftNotes // ignore: cast_nullable_to_non_nullable
as String?,conditionBackNotes: freezed == conditionBackNotes ? _self.conditionBackNotes : conditionBackNotes // ignore: cast_nullable_to_non_nullable
as String?,conditionAroundNotes: freezed == conditionAroundNotes ? _self.conditionAroundNotes : conditionAroundNotes // ignore: cast_nullable_to_non_nullable
as String?,requireAttentions: freezed == requireAttentions ? _self.requireAttentions : requireAttentions // ignore: cast_nullable_to_non_nullable
as int?,conditionRightType: freezed == conditionRightType ? _self.conditionRightType : conditionRightType // ignore: cast_nullable_to_non_nullable
as int?,conditionLeftType: freezed == conditionLeftType ? _self.conditionLeftType : conditionLeftType // ignore: cast_nullable_to_non_nullable
as int?,conditionBackType: freezed == conditionBackType ? _self.conditionBackType : conditionBackType // ignore: cast_nullable_to_non_nullable
as int?,conditionAroundType: freezed == conditionAroundType ? _self.conditionAroundType : conditionAroundType // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttentionEntity].
extension AttentionEntityPatterns on AttentionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttentionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttentionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttentionEntity value)  $default,){
final _that = this;
switch (_that) {
case _AttentionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttentionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AttentionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? branchId,  String? notes,  String? conditionRightNotes,  String? conditionLeftNotes,  String? conditionBackNotes,  String? conditionAroundNotes,  int? requireAttentions,  int? conditionRightType,  int? conditionLeftType,  int? conditionBackType,  int? conditionAroundType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttentionEntity() when $default != null:
return $default(_that.id,_that.branchId,_that.notes,_that.conditionRightNotes,_that.conditionLeftNotes,_that.conditionBackNotes,_that.conditionAroundNotes,_that.requireAttentions,_that.conditionRightType,_that.conditionLeftType,_that.conditionBackType,_that.conditionAroundType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? branchId,  String? notes,  String? conditionRightNotes,  String? conditionLeftNotes,  String? conditionBackNotes,  String? conditionAroundNotes,  int? requireAttentions,  int? conditionRightType,  int? conditionLeftType,  int? conditionBackType,  int? conditionAroundType)  $default,) {final _that = this;
switch (_that) {
case _AttentionEntity():
return $default(_that.id,_that.branchId,_that.notes,_that.conditionRightNotes,_that.conditionLeftNotes,_that.conditionBackNotes,_that.conditionAroundNotes,_that.requireAttentions,_that.conditionRightType,_that.conditionLeftType,_that.conditionBackType,_that.conditionAroundType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? branchId,  String? notes,  String? conditionRightNotes,  String? conditionLeftNotes,  String? conditionBackNotes,  String? conditionAroundNotes,  int? requireAttentions,  int? conditionRightType,  int? conditionLeftType,  int? conditionBackType,  int? conditionAroundType)?  $default,) {final _that = this;
switch (_that) {
case _AttentionEntity() when $default != null:
return $default(_that.id,_that.branchId,_that.notes,_that.conditionRightNotes,_that.conditionLeftNotes,_that.conditionBackNotes,_that.conditionAroundNotes,_that.requireAttentions,_that.conditionRightType,_that.conditionLeftType,_that.conditionBackType,_that.conditionAroundType);case _:
  return null;

}
}

}

/// @nodoc


class _AttentionEntity extends AttentionEntity {
  const _AttentionEntity({this.id, this.branchId, this.notes, this.conditionRightNotes, this.conditionLeftNotes, this.conditionBackNotes, this.conditionAroundNotes, this.requireAttentions, this.conditionRightType, this.conditionLeftType, this.conditionBackType, this.conditionAroundType}): super._();
  

@override final  int? id;
@override final  int? branchId;
@override final  String? notes;
@override final  String? conditionRightNotes;
@override final  String? conditionLeftNotes;
@override final  String? conditionBackNotes;
@override final  String? conditionAroundNotes;
@override final  int? requireAttentions;
@override final  int? conditionRightType;
@override final  int? conditionLeftType;
@override final  int? conditionBackType;
@override final  int? conditionAroundType;

/// Create a copy of AttentionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttentionEntityCopyWith<_AttentionEntity> get copyWith => __$AttentionEntityCopyWithImpl<_AttentionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttentionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.conditionRightNotes, conditionRightNotes) || other.conditionRightNotes == conditionRightNotes)&&(identical(other.conditionLeftNotes, conditionLeftNotes) || other.conditionLeftNotes == conditionLeftNotes)&&(identical(other.conditionBackNotes, conditionBackNotes) || other.conditionBackNotes == conditionBackNotes)&&(identical(other.conditionAroundNotes, conditionAroundNotes) || other.conditionAroundNotes == conditionAroundNotes)&&(identical(other.requireAttentions, requireAttentions) || other.requireAttentions == requireAttentions)&&(identical(other.conditionRightType, conditionRightType) || other.conditionRightType == conditionRightType)&&(identical(other.conditionLeftType, conditionLeftType) || other.conditionLeftType == conditionLeftType)&&(identical(other.conditionBackType, conditionBackType) || other.conditionBackType == conditionBackType)&&(identical(other.conditionAroundType, conditionAroundType) || other.conditionAroundType == conditionAroundType));
}


@override
int get hashCode => Object.hash(runtimeType,id,branchId,notes,conditionRightNotes,conditionLeftNotes,conditionBackNotes,conditionAroundNotes,requireAttentions,conditionRightType,conditionLeftType,conditionBackType,conditionAroundType);

@override
String toString() {
  return 'AttentionEntity(id: $id, branchId: $branchId, notes: $notes, conditionRightNotes: $conditionRightNotes, conditionLeftNotes: $conditionLeftNotes, conditionBackNotes: $conditionBackNotes, conditionAroundNotes: $conditionAroundNotes, requireAttentions: $requireAttentions, conditionRightType: $conditionRightType, conditionLeftType: $conditionLeftType, conditionBackType: $conditionBackType, conditionAroundType: $conditionAroundType)';
}


}

/// @nodoc
abstract mixin class _$AttentionEntityCopyWith<$Res> implements $AttentionEntityCopyWith<$Res> {
  factory _$AttentionEntityCopyWith(_AttentionEntity value, $Res Function(_AttentionEntity) _then) = __$AttentionEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? branchId, String? notes, String? conditionRightNotes, String? conditionLeftNotes, String? conditionBackNotes, String? conditionAroundNotes, int? requireAttentions, int? conditionRightType, int? conditionLeftType, int? conditionBackType, int? conditionAroundType
});




}
/// @nodoc
class __$AttentionEntityCopyWithImpl<$Res>
    implements _$AttentionEntityCopyWith<$Res> {
  __$AttentionEntityCopyWithImpl(this._self, this._then);

  final _AttentionEntity _self;
  final $Res Function(_AttentionEntity) _then;

/// Create a copy of AttentionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? branchId = freezed,Object? notes = freezed,Object? conditionRightNotes = freezed,Object? conditionLeftNotes = freezed,Object? conditionBackNotes = freezed,Object? conditionAroundNotes = freezed,Object? requireAttentions = freezed,Object? conditionRightType = freezed,Object? conditionLeftType = freezed,Object? conditionBackType = freezed,Object? conditionAroundType = freezed,}) {
  return _then(_AttentionEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,conditionRightNotes: freezed == conditionRightNotes ? _self.conditionRightNotes : conditionRightNotes // ignore: cast_nullable_to_non_nullable
as String?,conditionLeftNotes: freezed == conditionLeftNotes ? _self.conditionLeftNotes : conditionLeftNotes // ignore: cast_nullable_to_non_nullable
as String?,conditionBackNotes: freezed == conditionBackNotes ? _self.conditionBackNotes : conditionBackNotes // ignore: cast_nullable_to_non_nullable
as String?,conditionAroundNotes: freezed == conditionAroundNotes ? _self.conditionAroundNotes : conditionAroundNotes // ignore: cast_nullable_to_non_nullable
as String?,requireAttentions: freezed == requireAttentions ? _self.requireAttentions : requireAttentions // ignore: cast_nullable_to_non_nullable
as int?,conditionRightType: freezed == conditionRightType ? _self.conditionRightType : conditionRightType // ignore: cast_nullable_to_non_nullable
as int?,conditionLeftType: freezed == conditionLeftType ? _self.conditionLeftType : conditionLeftType // ignore: cast_nullable_to_non_nullable
as int?,conditionBackType: freezed == conditionBackType ? _self.conditionBackType : conditionBackType // ignore: cast_nullable_to_non_nullable
as int?,conditionAroundType: freezed == conditionAroundType ? _self.conditionAroundType : conditionAroundType // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
