// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_sign_create_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreSignCreateModel {

 String? get url; String? get fileUrl;
/// Create a copy of PreSignCreateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreSignCreateModelCopyWith<PreSignCreateModel> get copyWith => _$PreSignCreateModelCopyWithImpl<PreSignCreateModel>(this as PreSignCreateModel, _$identity);

  /// Serializes this PreSignCreateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreSignCreateModel&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,fileUrl);

@override
String toString() {
  return 'PreSignCreateModel(url: $url, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class $PreSignCreateModelCopyWith<$Res>  {
  factory $PreSignCreateModelCopyWith(PreSignCreateModel value, $Res Function(PreSignCreateModel) _then) = _$PreSignCreateModelCopyWithImpl;
@useResult
$Res call({
 String? url, String? fileUrl
});




}
/// @nodoc
class _$PreSignCreateModelCopyWithImpl<$Res>
    implements $PreSignCreateModelCopyWith<$Res> {
  _$PreSignCreateModelCopyWithImpl(this._self, this._then);

  final PreSignCreateModel _self;
  final $Res Function(PreSignCreateModel) _then;

/// Create a copy of PreSignCreateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? fileUrl = freezed,}) {
  return _then(_self.copyWith(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PreSignCreateModel].
extension PreSignCreateModelPatterns on PreSignCreateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreSignCreateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreSignCreateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreSignCreateModel value)  $default,){
final _that = this;
switch (_that) {
case _PreSignCreateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreSignCreateModel value)?  $default,){
final _that = this;
switch (_that) {
case _PreSignCreateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url,  String? fileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreSignCreateModel() when $default != null:
return $default(_that.url,_that.fileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url,  String? fileUrl)  $default,) {final _that = this;
switch (_that) {
case _PreSignCreateModel():
return $default(_that.url,_that.fileUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url,  String? fileUrl)?  $default,) {final _that = this;
switch (_that) {
case _PreSignCreateModel() when $default != null:
return $default(_that.url,_that.fileUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreSignCreateModel extends PreSignCreateModel {
  const _PreSignCreateModel({this.url, this.fileUrl}): super._();
  factory _PreSignCreateModel.fromJson(Map<String, dynamic> json) => _$PreSignCreateModelFromJson(json);

@override final  String? url;
@override final  String? fileUrl;

/// Create a copy of PreSignCreateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreSignCreateModelCopyWith<_PreSignCreateModel> get copyWith => __$PreSignCreateModelCopyWithImpl<_PreSignCreateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreSignCreateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreSignCreateModel&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,fileUrl);

@override
String toString() {
  return 'PreSignCreateModel(url: $url, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class _$PreSignCreateModelCopyWith<$Res> implements $PreSignCreateModelCopyWith<$Res> {
  factory _$PreSignCreateModelCopyWith(_PreSignCreateModel value, $Res Function(_PreSignCreateModel) _then) = __$PreSignCreateModelCopyWithImpl;
@override @useResult
$Res call({
 String? url, String? fileUrl
});




}
/// @nodoc
class __$PreSignCreateModelCopyWithImpl<$Res>
    implements _$PreSignCreateModelCopyWith<$Res> {
  __$PreSignCreateModelCopyWithImpl(this._self, this._then);

  final _PreSignCreateModel _self;
  final $Res Function(_PreSignCreateModel) _then;

/// Create a copy of PreSignCreateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? fileUrl = freezed,}) {
  return _then(_PreSignCreateModel(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
