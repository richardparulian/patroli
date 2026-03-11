// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'created_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatedModel {

 int? get id; int? get ssoId; String? get name; String? get username; int? get role;
/// Create a copy of CreatedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatedModelCopyWith<CreatedModel> get copyWith => _$CreatedModelCopyWithImpl<CreatedModel>(this as CreatedModel, _$identity);

  /// Serializes this CreatedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatedModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ssoId, ssoId) || other.ssoId == ssoId)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ssoId,name,username,role);

@override
String toString() {
  return 'CreatedModel(id: $id, ssoId: $ssoId, name: $name, username: $username, role: $role)';
}


}

/// @nodoc
abstract mixin class $CreatedModelCopyWith<$Res>  {
  factory $CreatedModelCopyWith(CreatedModel value, $Res Function(CreatedModel) _then) = _$CreatedModelCopyWithImpl;
@useResult
$Res call({
 int? id, int? ssoId, String? name, String? username, int? role
});




}
/// @nodoc
class _$CreatedModelCopyWithImpl<$Res>
    implements $CreatedModelCopyWith<$Res> {
  _$CreatedModelCopyWithImpl(this._self, this._then);

  final CreatedModel _self;
  final $Res Function(CreatedModel) _then;

/// Create a copy of CreatedModel
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


/// Adds pattern-matching-related methods to [CreatedModel].
extension CreatedModelPatterns on CreatedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatedModel value)  $default,){
final _that = this;
switch (_that) {
case _CreatedModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatedModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreatedModel() when $default != null:
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
case _CreatedModel() when $default != null:
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
case _CreatedModel():
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
case _CreatedModel() when $default != null:
return $default(_that.id,_that.ssoId,_that.name,_that.username,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatedModel extends CreatedModel {
  const _CreatedModel({this.id, this.ssoId, this.name, this.username, this.role}): super._();
  factory _CreatedModel.fromJson(Map<String, dynamic> json) => _$CreatedModelFromJson(json);

@override final  int? id;
@override final  int? ssoId;
@override final  String? name;
@override final  String? username;
@override final  int? role;

/// Create a copy of CreatedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedModelCopyWith<_CreatedModel> get copyWith => __$CreatedModelCopyWithImpl<_CreatedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ssoId, ssoId) || other.ssoId == ssoId)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ssoId,name,username,role);

@override
String toString() {
  return 'CreatedModel(id: $id, ssoId: $ssoId, name: $name, username: $username, role: $role)';
}


}

/// @nodoc
abstract mixin class _$CreatedModelCopyWith<$Res> implements $CreatedModelCopyWith<$Res> {
  factory _$CreatedModelCopyWith(_CreatedModel value, $Res Function(_CreatedModel) _then) = __$CreatedModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? ssoId, String? name, String? username, int? role
});




}
/// @nodoc
class __$CreatedModelCopyWithImpl<$Res>
    implements _$CreatedModelCopyWith<$Res> {
  __$CreatedModelCopyWithImpl(this._self, this._then);

  final _CreatedModel _self;
  final $Res Function(_CreatedModel) _then;

/// Create a copy of CreatedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? ssoId = freezed,Object? name = freezed,Object? username = freezed,Object? role = freezed,}) {
  return _then(_CreatedModel(
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
