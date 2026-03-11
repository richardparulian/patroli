// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'created_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatedEntity {

 int? get id; int? get ssoId; String? get name; String? get username; int? get role;
/// Create a copy of CreatedEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatedEntityCopyWith<CreatedEntity> get copyWith => _$CreatedEntityCopyWithImpl<CreatedEntity>(this as CreatedEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatedEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.ssoId, ssoId) || other.ssoId == ssoId)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,id,ssoId,name,username,role);

@override
String toString() {
  return 'CreatedEntity(id: $id, ssoId: $ssoId, name: $name, username: $username, role: $role)';
}


}

/// @nodoc
abstract mixin class $CreatedEntityCopyWith<$Res>  {
  factory $CreatedEntityCopyWith(CreatedEntity value, $Res Function(CreatedEntity) _then) = _$CreatedEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int? ssoId, String? name, String? username, int? role
});




}
/// @nodoc
class _$CreatedEntityCopyWithImpl<$Res>
    implements $CreatedEntityCopyWith<$Res> {
  _$CreatedEntityCopyWithImpl(this._self, this._then);

  final CreatedEntity _self;
  final $Res Function(CreatedEntity) _then;

/// Create a copy of CreatedEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? ssoId = freezed,Object? name = freezed,Object? username = freezed,Object? role = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,ssoId: freezed == ssoId ? _self.ssoId : ssoId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatedEntity].
extension CreatedEntityPatterns on CreatedEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatedEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatedEntity value)  $default,){
final _that = this;
switch (_that) {
case _CreatedEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatedEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CreatedEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? ssoId,  String? name,  String? username,  int? role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatedEntity() when $default != null:
return $default(_that.id,_that.ssoId,_that.name,_that.username,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? ssoId,  String? name,  String? username,  int? role)  $default,) {final _that = this;
switch (_that) {
case _CreatedEntity():
return $default(_that.id,_that.ssoId,_that.name,_that.username,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? ssoId,  String? name,  String? username,  int? role)?  $default,) {final _that = this;
switch (_that) {
case _CreatedEntity() when $default != null:
return $default(_that.id,_that.ssoId,_that.name,_that.username,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _CreatedEntity extends CreatedEntity {
  const _CreatedEntity({this.id, this.ssoId, this.name, this.username, this.role}): super._();
  

@override final  int? id;
@override final  int? ssoId;
@override final  String? name;
@override final  String? username;
@override final  int? role;

/// Create a copy of CreatedEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedEntityCopyWith<_CreatedEntity> get copyWith => __$CreatedEntityCopyWithImpl<_CreatedEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.ssoId, ssoId) || other.ssoId == ssoId)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,id,ssoId,name,username,role);

@override
String toString() {
  return 'CreatedEntity(id: $id, ssoId: $ssoId, name: $name, username: $username, role: $role)';
}


}

/// @nodoc
abstract mixin class _$CreatedEntityCopyWith<$Res> implements $CreatedEntityCopyWith<$Res> {
  factory _$CreatedEntityCopyWith(_CreatedEntity value, $Res Function(_CreatedEntity) _then) = __$CreatedEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? ssoId, String? name, String? username, int? role
});




}
/// @nodoc
class __$CreatedEntityCopyWithImpl<$Res>
    implements _$CreatedEntityCopyWith<$Res> {
  __$CreatedEntityCopyWithImpl(this._self, this._then);

  final _CreatedEntity _self;
  final $Res Function(_CreatedEntity) _then;

/// Create a copy of CreatedEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? ssoId = freezed,Object? name = freezed,Object? username = freezed,Object? role = freezed,}) {
  return _then(_CreatedEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,ssoId: freezed == ssoId ? _self.ssoId : ssoId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
