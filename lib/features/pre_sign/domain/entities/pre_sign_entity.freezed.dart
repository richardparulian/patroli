// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_sign_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PreSignEntity {

 String get url; String get fileUrl; HeadersModel get headers;
/// Create a copy of PreSignEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreSignEntityCopyWith<PreSignEntity> get copyWith => _$PreSignEntityCopyWithImpl<PreSignEntity>(this as PreSignEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreSignEntity&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.headers, headers) || other.headers == headers));
}


@override
int get hashCode => Object.hash(runtimeType,url,fileUrl,headers);

@override
String toString() {
  return 'PreSignEntity(url: $url, fileUrl: $fileUrl, headers: $headers)';
}


}

/// @nodoc
abstract mixin class $PreSignEntityCopyWith<$Res>  {
  factory $PreSignEntityCopyWith(PreSignEntity value, $Res Function(PreSignEntity) _then) = _$PreSignEntityCopyWithImpl;
@useResult
$Res call({
 String url, String fileUrl, HeadersModel headers
});


$HeadersModelCopyWith<$Res> get headers;

}
/// @nodoc
class _$PreSignEntityCopyWithImpl<$Res>
    implements $PreSignEntityCopyWith<$Res> {
  _$PreSignEntityCopyWithImpl(this._self, this._then);

  final PreSignEntity _self;
  final $Res Function(PreSignEntity) _then;

/// Create a copy of PreSignEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? fileUrl = null,Object? headers = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as HeadersModel,
  ));
}
/// Create a copy of PreSignEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadersModelCopyWith<$Res> get headers {
  
  return $HeadersModelCopyWith<$Res>(_self.headers, (value) {
    return _then(_self.copyWith(headers: value));
  });
}
}


/// Adds pattern-matching-related methods to [PreSignEntity].
extension PreSignEntityPatterns on PreSignEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreSignEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreSignEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreSignEntity value)  $default,){
final _that = this;
switch (_that) {
case _PreSignEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreSignEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PreSignEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String fileUrl,  HeadersModel headers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreSignEntity() when $default != null:
return $default(_that.url,_that.fileUrl,_that.headers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String fileUrl,  HeadersModel headers)  $default,) {final _that = this;
switch (_that) {
case _PreSignEntity():
return $default(_that.url,_that.fileUrl,_that.headers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String fileUrl,  HeadersModel headers)?  $default,) {final _that = this;
switch (_that) {
case _PreSignEntity() when $default != null:
return $default(_that.url,_that.fileUrl,_that.headers);case _:
  return null;

}
}

}

/// @nodoc


class _PreSignEntity extends PreSignEntity {
  const _PreSignEntity({required this.url, required this.fileUrl, required this.headers}): super._();
  

@override final  String url;
@override final  String fileUrl;
@override final  HeadersModel headers;

/// Create a copy of PreSignEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreSignEntityCopyWith<_PreSignEntity> get copyWith => __$PreSignEntityCopyWithImpl<_PreSignEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreSignEntity&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.headers, headers) || other.headers == headers));
}


@override
int get hashCode => Object.hash(runtimeType,url,fileUrl,headers);

@override
String toString() {
  return 'PreSignEntity(url: $url, fileUrl: $fileUrl, headers: $headers)';
}


}

/// @nodoc
abstract mixin class _$PreSignEntityCopyWith<$Res> implements $PreSignEntityCopyWith<$Res> {
  factory _$PreSignEntityCopyWith(_PreSignEntity value, $Res Function(_PreSignEntity) _then) = __$PreSignEntityCopyWithImpl;
@override @useResult
$Res call({
 String url, String fileUrl, HeadersModel headers
});


@override $HeadersModelCopyWith<$Res> get headers;

}
/// @nodoc
class __$PreSignEntityCopyWithImpl<$Res>
    implements _$PreSignEntityCopyWith<$Res> {
  __$PreSignEntityCopyWithImpl(this._self, this._then);

  final _PreSignEntity _self;
  final $Res Function(_PreSignEntity) _then;

/// Create a copy of PreSignEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? fileUrl = null,Object? headers = null,}) {
  return _then(_PreSignEntity(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as HeadersModel,
  ));
}

/// Create a copy of PreSignEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadersModelCopyWith<$Res> get headers {
  
  return $HeadersModelCopyWith<$Res>(_self.headers, (value) {
    return _then(_self.copyWith(headers: value));
  });
}
}

// dart format on
