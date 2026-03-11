// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_sign_update_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PreSignUpdateEntity {

 int? get statusCode; dynamic get data;
/// Create a copy of PreSignUpdateEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreSignUpdateEntityCopyWith<PreSignUpdateEntity> get copyWith => _$PreSignUpdateEntityCopyWithImpl<PreSignUpdateEntity>(this as PreSignUpdateEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreSignUpdateEntity&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'PreSignUpdateEntity(statusCode: $statusCode, data: $data)';
}


}

/// @nodoc
abstract mixin class $PreSignUpdateEntityCopyWith<$Res>  {
  factory $PreSignUpdateEntityCopyWith(PreSignUpdateEntity value, $Res Function(PreSignUpdateEntity) _then) = _$PreSignUpdateEntityCopyWithImpl;
@useResult
$Res call({
 int? statusCode, dynamic data
});




}
/// @nodoc
class _$PreSignUpdateEntityCopyWithImpl<$Res>
    implements $PreSignUpdateEntityCopyWith<$Res> {
  _$PreSignUpdateEntityCopyWithImpl(this._self, this._then);

  final PreSignUpdateEntity _self;
  final $Res Function(PreSignUpdateEntity) _then;

/// Create a copy of PreSignUpdateEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [PreSignUpdateEntity].
extension PreSignUpdateEntityPatterns on PreSignUpdateEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreSignUpdateEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreSignUpdateEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreSignUpdateEntity value)  $default,){
final _that = this;
switch (_that) {
case _PreSignUpdateEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreSignUpdateEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PreSignUpdateEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? statusCode,  dynamic data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreSignUpdateEntity() when $default != null:
return $default(_that.statusCode,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? statusCode,  dynamic data)  $default,) {final _that = this;
switch (_that) {
case _PreSignUpdateEntity():
return $default(_that.statusCode,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? statusCode,  dynamic data)?  $default,) {final _that = this;
switch (_that) {
case _PreSignUpdateEntity() when $default != null:
return $default(_that.statusCode,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _PreSignUpdateEntity implements PreSignUpdateEntity {
  const _PreSignUpdateEntity({this.statusCode, required this.data});
  

@override final  int? statusCode;
@override final  dynamic data;

/// Create a copy of PreSignUpdateEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreSignUpdateEntityCopyWith<_PreSignUpdateEntity> get copyWith => __$PreSignUpdateEntityCopyWithImpl<_PreSignUpdateEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreSignUpdateEntity&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'PreSignUpdateEntity(statusCode: $statusCode, data: $data)';
}


}

/// @nodoc
abstract mixin class _$PreSignUpdateEntityCopyWith<$Res> implements $PreSignUpdateEntityCopyWith<$Res> {
  factory _$PreSignUpdateEntityCopyWith(_PreSignUpdateEntity value, $Res Function(_PreSignUpdateEntity) _then) = __$PreSignUpdateEntityCopyWithImpl;
@override @useResult
$Res call({
 int? statusCode, dynamic data
});




}
/// @nodoc
class __$PreSignUpdateEntityCopyWithImpl<$Res>
    implements _$PreSignUpdateEntityCopyWith<$Res> {
  __$PreSignUpdateEntityCopyWithImpl(this._self, this._then);

  final _PreSignUpdateEntity _self;
  final $Res Function(_PreSignUpdateEntity) _then;

/// Create a copy of PreSignUpdateEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = freezed,Object? data = freezed,}) {
  return _then(_PreSignUpdateEntity(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
