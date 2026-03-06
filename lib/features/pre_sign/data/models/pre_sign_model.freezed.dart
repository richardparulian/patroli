// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_sign_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreSignModel {

 String get url; String get fileUrl; HeadersModel get headers;
/// Create a copy of PreSignModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreSignModelCopyWith<PreSignModel> get copyWith => _$PreSignModelCopyWithImpl<PreSignModel>(this as PreSignModel, _$identity);

  /// Serializes this PreSignModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreSignModel&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.headers, headers) || other.headers == headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,fileUrl,headers);

@override
String toString() {
  return 'PreSignModel(url: $url, fileUrl: $fileUrl, headers: $headers)';
}


}

/// @nodoc
abstract mixin class $PreSignModelCopyWith<$Res>  {
  factory $PreSignModelCopyWith(PreSignModel value, $Res Function(PreSignModel) _then) = _$PreSignModelCopyWithImpl;
@useResult
$Res call({
 String url, String fileUrl, HeadersModel headers
});


$HeadersModelCopyWith<$Res> get headers;

}
/// @nodoc
class _$PreSignModelCopyWithImpl<$Res>
    implements $PreSignModelCopyWith<$Res> {
  _$PreSignModelCopyWithImpl(this._self, this._then);

  final PreSignModel _self;
  final $Res Function(PreSignModel) _then;

/// Create a copy of PreSignModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? fileUrl = null,Object? headers = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as HeadersModel,
  ));
}
/// Create a copy of PreSignModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadersModelCopyWith<$Res> get headers {
  
  return $HeadersModelCopyWith<$Res>(_self.headers, (value) {
    return _then(_self.copyWith(headers: value));
  });
}
}


/// Adds pattern-matching-related methods to [PreSignModel].
extension PreSignModelPatterns on PreSignModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreSignModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreSignModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreSignModel value)  $default,){
final _that = this;
switch (_that) {
case _PreSignModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreSignModel value)?  $default,){
final _that = this;
switch (_that) {
case _PreSignModel() when $default != null:
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
case _PreSignModel() when $default != null:
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
case _PreSignModel():
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
case _PreSignModel() when $default != null:
return $default(_that.url,_that.fileUrl,_that.headers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreSignModel extends PreSignModel {
  const _PreSignModel({required this.url, required this.fileUrl, required this.headers}): super._();
  factory _PreSignModel.fromJson(Map<String, dynamic> json) => _$PreSignModelFromJson(json);

@override final  String url;
@override final  String fileUrl;
@override final  HeadersModel headers;

/// Create a copy of PreSignModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreSignModelCopyWith<_PreSignModel> get copyWith => __$PreSignModelCopyWithImpl<_PreSignModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreSignModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreSignModel&&(identical(other.url, url) || other.url == url)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.headers, headers) || other.headers == headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,fileUrl,headers);

@override
String toString() {
  return 'PreSignModel(url: $url, fileUrl: $fileUrl, headers: $headers)';
}


}

/// @nodoc
abstract mixin class _$PreSignModelCopyWith<$Res> implements $PreSignModelCopyWith<$Res> {
  factory _$PreSignModelCopyWith(_PreSignModel value, $Res Function(_PreSignModel) _then) = __$PreSignModelCopyWithImpl;
@override @useResult
$Res call({
 String url, String fileUrl, HeadersModel headers
});


@override $HeadersModelCopyWith<$Res> get headers;

}
/// @nodoc
class __$PreSignModelCopyWithImpl<$Res>
    implements _$PreSignModelCopyWith<$Res> {
  __$PreSignModelCopyWithImpl(this._self, this._then);

  final _PreSignModel _self;
  final $Res Function(_PreSignModel) _then;

/// Create a copy of PreSignModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? fileUrl = null,Object? headers = null,}) {
  return _then(_PreSignModel(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as HeadersModel,
  ));
}

/// Create a copy of PreSignModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadersModelCopyWith<$Res> get headers {
  
  return $HeadersModelCopyWith<$Res>(_self.headers, (value) {
    return _then(_self.copyWith(headers: value));
  });
}
}


/// @nodoc
mixin _$HeadersModel {

 List<String> get host;
/// Create a copy of HeadersModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadersModelCopyWith<HeadersModel> get copyWith => _$HeadersModelCopyWithImpl<HeadersModel>(this as HeadersModel, _$identity);

  /// Serializes this HeadersModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadersModel&&const DeepCollectionEquality().equals(other.host, host));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(host));

@override
String toString() {
  return 'HeadersModel(host: $host)';
}


}

/// @nodoc
abstract mixin class $HeadersModelCopyWith<$Res>  {
  factory $HeadersModelCopyWith(HeadersModel value, $Res Function(HeadersModel) _then) = _$HeadersModelCopyWithImpl;
@useResult
$Res call({
 List<String> host
});




}
/// @nodoc
class _$HeadersModelCopyWithImpl<$Res>
    implements $HeadersModelCopyWith<$Res> {
  _$HeadersModelCopyWithImpl(this._self, this._then);

  final HeadersModel _self;
  final $Res Function(HeadersModel) _then;

/// Create a copy of HeadersModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? host = null,}) {
  return _then(_self.copyWith(
host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadersModel].
extension HeadersModelPatterns on HeadersModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeadersModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeadersModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeadersModel value)  $default,){
final _that = this;
switch (_that) {
case _HeadersModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeadersModel value)?  $default,){
final _that = this;
switch (_that) {
case _HeadersModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> host)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadersModel() when $default != null:
return $default(_that.host);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> host)  $default,) {final _that = this;
switch (_that) {
case _HeadersModel():
return $default(_that.host);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> host)?  $default,) {final _that = this;
switch (_that) {
case _HeadersModel() when $default != null:
return $default(_that.host);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeadersModel extends HeadersModel {
  const _HeadersModel({required final  List<String> host}): _host = host,super._();
  factory _HeadersModel.fromJson(Map<String, dynamic> json) => _$HeadersModelFromJson(json);

 final  List<String> _host;
@override List<String> get host {
  if (_host is EqualUnmodifiableListView) return _host;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_host);
}


/// Create a copy of HeadersModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeadersModelCopyWith<_HeadersModel> get copyWith => __$HeadersModelCopyWithImpl<_HeadersModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeadersModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadersModel&&const DeepCollectionEquality().equals(other._host, _host));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_host));

@override
String toString() {
  return 'HeadersModel(host: $host)';
}


}

/// @nodoc
abstract mixin class _$HeadersModelCopyWith<$Res> implements $HeadersModelCopyWith<$Res> {
  factory _$HeadersModelCopyWith(_HeadersModel value, $Res Function(_HeadersModel) _then) = __$HeadersModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> host
});




}
/// @nodoc
class __$HeadersModelCopyWithImpl<$Res>
    implements _$HeadersModelCopyWith<$Res> {
  __$HeadersModelCopyWithImpl(this._self, this._then);

  final _HeadersModel _self;
  final $Res Function(_HeadersModel) _then;

/// Create a copy of HeadersModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? host = null,}) {
  return _then(_HeadersModel(
host: null == host ? _self._host : host // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
