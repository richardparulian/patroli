// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_sign_update_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreSignUpdateModel {

 int? get statusCode; dynamic get data;
/// Create a copy of PreSignUpdateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreSignUpdateModelCopyWith<PreSignUpdateModel> get copyWith => _$PreSignUpdateModelCopyWithImpl<PreSignUpdateModel>(this as PreSignUpdateModel, _$identity);

  /// Serializes this PreSignUpdateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreSignUpdateModel&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'PreSignUpdateModel(statusCode: $statusCode, data: $data)';
}


}

/// @nodoc
abstract mixin class $PreSignUpdateModelCopyWith<$Res>  {
  factory $PreSignUpdateModelCopyWith(PreSignUpdateModel value, $Res Function(PreSignUpdateModel) _then) = _$PreSignUpdateModelCopyWithImpl;
@useResult
$Res call({
 int? statusCode, dynamic data
});




}
/// @nodoc
class _$PreSignUpdateModelCopyWithImpl<$Res>
    implements $PreSignUpdateModelCopyWith<$Res> {
  _$PreSignUpdateModelCopyWithImpl(this._self, this._then);

  final PreSignUpdateModel _self;
  final $Res Function(PreSignUpdateModel) _then;

/// Create a copy of PreSignUpdateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [PreSignUpdateModel].
extension PreSignUpdateModelPatterns on PreSignUpdateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreSignUpdateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreSignUpdateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreSignUpdateModel value)  $default,){
final _that = this;
switch (_that) {
case _PreSignUpdateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreSignUpdateModel value)?  $default,){
final _that = this;
switch (_that) {
case _PreSignUpdateModel() when $default != null:
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
case _PreSignUpdateModel() when $default != null:
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
case _PreSignUpdateModel():
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
case _PreSignUpdateModel() when $default != null:
return $default(_that.statusCode,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreSignUpdateModel extends PreSignUpdateModel {
  const _PreSignUpdateModel({this.statusCode, this.data}): super._();
  factory _PreSignUpdateModel.fromJson(Map<String, dynamic> json) => _$PreSignUpdateModelFromJson(json);

@override final  int? statusCode;
@override final  dynamic data;

/// Create a copy of PreSignUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreSignUpdateModelCopyWith<_PreSignUpdateModel> get copyWith => __$PreSignUpdateModelCopyWithImpl<_PreSignUpdateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreSignUpdateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreSignUpdateModel&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'PreSignUpdateModel(statusCode: $statusCode, data: $data)';
}


}

/// @nodoc
abstract mixin class _$PreSignUpdateModelCopyWith<$Res> implements $PreSignUpdateModelCopyWith<$Res> {
  factory _$PreSignUpdateModelCopyWith(_PreSignUpdateModel value, $Res Function(_PreSignUpdateModel) _then) = __$PreSignUpdateModelCopyWithImpl;
@override @useResult
$Res call({
 int? statusCode, dynamic data
});




}
/// @nodoc
class __$PreSignUpdateModelCopyWithImpl<$Res>
    implements _$PreSignUpdateModelCopyWith<$Res> {
  __$PreSignUpdateModelCopyWithImpl(this._self, this._then);

  final _PreSignUpdateModel _self;
  final $Res Function(_PreSignUpdateModel) _then;

/// Create a copy of PreSignUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = freezed,Object? data = freezed,}) {
  return _then(_PreSignUpdateModel(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
