// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_sign_create_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PreSignCreateEntity {

 String get url; String get fileUrl;
/// Create a copy of PreSignCreateEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreSignCreateEntityCopyWith<PreSignCreateEntity> get copyWith => _$PreSignCreateEntityCopyWithImpl<PreSignCreateEntity>(this as PreSignCreateEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreSignCreateEntity&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,url,fileUrl);

@override
String toString() {
  return 'PreSignCreateEntity(url: $url, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class $PreSignCreateEntityCopyWith<$Res>  {
  factory $PreSignCreateEntityCopyWith(PreSignCreateEntity value, $Res Function(PreSignCreateEntity) _then) = _$PreSignCreateEntityCopyWithImpl;
@useResult
$Res call({
 String url, String fileUrl
});




}
/// @nodoc
class _$PreSignCreateEntityCopyWithImpl<$Res>
    implements $PreSignCreateEntityCopyWith<$Res> {
  _$PreSignCreateEntityCopyWithImpl(this._self, this._then);

  final PreSignCreateEntity _self;
  final $Res Function(PreSignCreateEntity) _then;

/// Create a copy of PreSignCreateEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? fileUrl = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PreSignCreateEntity].
extension PreSignCreateEntityPatterns on PreSignCreateEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreSignCreateEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreSignCreateEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreSignCreateEntity value)  $default,){
final _that = this;
switch (_that) {
case _PreSignCreateEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreSignCreateEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PreSignCreateEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String fileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreSignCreateEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String fileUrl)  $default,) {final _that = this;
switch (_that) {
case _PreSignCreateEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String fileUrl)?  $default,) {final _that = this;
switch (_that) {
case _PreSignCreateEntity() when $default != null:
return $default(_that.url,_that.fileUrl);case _:
  return null;

}
}

}

/// @nodoc


class _PreSignCreateEntity implements PreSignCreateEntity {
  const _PreSignCreateEntity({required this.url, required this.fileUrl});
  

@override final  String url;
@override final  String fileUrl;

/// Create a copy of PreSignCreateEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreSignCreateEntityCopyWith<_PreSignCreateEntity> get copyWith => __$PreSignCreateEntityCopyWithImpl<_PreSignCreateEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreSignCreateEntity&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,url,fileUrl);

@override
String toString() {
  return 'PreSignCreateEntity(url: $url, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class _$PreSignCreateEntityCopyWith<$Res> implements $PreSignCreateEntityCopyWith<$Res> {
  factory _$PreSignCreateEntityCopyWith(_PreSignCreateEntity value, $Res Function(_PreSignCreateEntity) _then) = __$PreSignCreateEntityCopyWithImpl;
@override @useResult
$Res call({
 String url, String fileUrl
});




}
/// @nodoc
class __$PreSignCreateEntityCopyWithImpl<$Res>
    implements _$PreSignCreateEntityCopyWith<$Res> {
  __$PreSignCreateEntityCopyWithImpl(this._self, this._then);

  final _PreSignCreateEntity _self;
  final $Res Function(_PreSignCreateEntity) _then;

/// Create a copy of PreSignCreateEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? fileUrl = null,}) {
  return _then(_PreSignCreateEntity(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
