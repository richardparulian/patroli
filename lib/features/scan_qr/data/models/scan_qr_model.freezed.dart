// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_qr_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScanQrModel {

 int get id; String? get name; int? get kanitId; String? get kanitUsername; String? get kanitName; int? get kacabId; String? get kacabUsername; String? get kacabName; int? get areaManagerId; String? get areaManagerUsername; String? get areaManagerName; String? get qrCode;
/// Create a copy of ScanQrModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanQrModelCopyWith<ScanQrModel> get copyWith => _$ScanQrModelCopyWithImpl<ScanQrModel>(this as ScanQrModel, _$identity);

  /// Serializes this ScanQrModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanQrModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kanitId, kanitId) || other.kanitId == kanitId)&&(identical(other.kanitUsername, kanitUsername) || other.kanitUsername == kanitUsername)&&(identical(other.kanitName, kanitName) || other.kanitName == kanitName)&&(identical(other.kacabId, kacabId) || other.kacabId == kacabId)&&(identical(other.kacabUsername, kacabUsername) || other.kacabUsername == kacabUsername)&&(identical(other.kacabName, kacabName) || other.kacabName == kacabName)&&(identical(other.areaManagerId, areaManagerId) || other.areaManagerId == areaManagerId)&&(identical(other.areaManagerUsername, areaManagerUsername) || other.areaManagerUsername == areaManagerUsername)&&(identical(other.areaManagerName, areaManagerName) || other.areaManagerName == areaManagerName)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kanitId,kanitUsername,kanitName,kacabId,kacabUsername,kacabName,areaManagerId,areaManagerUsername,areaManagerName,qrCode);

@override
String toString() {
  return 'ScanQrModel(id: $id, name: $name, kanitId: $kanitId, kanitUsername: $kanitUsername, kanitName: $kanitName, kacabId: $kacabId, kacabUsername: $kacabUsername, kacabName: $kacabName, areaManagerId: $areaManagerId, areaManagerUsername: $areaManagerUsername, areaManagerName: $areaManagerName, qrCode: $qrCode)';
}


}

/// @nodoc
abstract mixin class $ScanQrModelCopyWith<$Res>  {
  factory $ScanQrModelCopyWith(ScanQrModel value, $Res Function(ScanQrModel) _then) = _$ScanQrModelCopyWithImpl;
@useResult
$Res call({
 int id, String? name, int? kanitId, String? kanitUsername, String? kanitName, int? kacabId, String? kacabUsername, String? kacabName, int? areaManagerId, String? areaManagerUsername, String? areaManagerName, String? qrCode
});




}
/// @nodoc
class _$ScanQrModelCopyWithImpl<$Res>
    implements $ScanQrModelCopyWith<$Res> {
  _$ScanQrModelCopyWithImpl(this._self, this._then);

  final ScanQrModel _self;
  final $Res Function(ScanQrModel) _then;

/// Create a copy of ScanQrModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? kanitId = freezed,Object? kanitUsername = freezed,Object? kanitName = freezed,Object? kacabId = freezed,Object? kacabUsername = freezed,Object? kacabName = freezed,Object? areaManagerId = freezed,Object? areaManagerUsername = freezed,Object? areaManagerName = freezed,Object? qrCode = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,kanitId: freezed == kanitId ? _self.kanitId : kanitId // ignore: cast_nullable_to_non_nullable
as int?,kanitUsername: freezed == kanitUsername ? _self.kanitUsername : kanitUsername // ignore: cast_nullable_to_non_nullable
as String?,kanitName: freezed == kanitName ? _self.kanitName : kanitName // ignore: cast_nullable_to_non_nullable
as String?,kacabId: freezed == kacabId ? _self.kacabId : kacabId // ignore: cast_nullable_to_non_nullable
as int?,kacabUsername: freezed == kacabUsername ? _self.kacabUsername : kacabUsername // ignore: cast_nullable_to_non_nullable
as String?,kacabName: freezed == kacabName ? _self.kacabName : kacabName // ignore: cast_nullable_to_non_nullable
as String?,areaManagerId: freezed == areaManagerId ? _self.areaManagerId : areaManagerId // ignore: cast_nullable_to_non_nullable
as int?,areaManagerUsername: freezed == areaManagerUsername ? _self.areaManagerUsername : areaManagerUsername // ignore: cast_nullable_to_non_nullable
as String?,areaManagerName: freezed == areaManagerName ? _self.areaManagerName : areaManagerName // ignore: cast_nullable_to_non_nullable
as String?,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanQrModel].
extension ScanQrModelPatterns on ScanQrModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanQrModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanQrModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanQrModel value)  $default,){
final _that = this;
switch (_that) {
case _ScanQrModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanQrModel value)?  $default,){
final _that = this;
switch (_that) {
case _ScanQrModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  int? kanitId,  String? kanitUsername,  String? kanitName,  int? kacabId,  String? kacabUsername,  String? kacabName,  int? areaManagerId,  String? areaManagerUsername,  String? areaManagerName,  String? qrCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanQrModel() when $default != null:
return $default(_that.id,_that.name,_that.kanitId,_that.kanitUsername,_that.kanitName,_that.kacabId,_that.kacabUsername,_that.kacabName,_that.areaManagerId,_that.areaManagerUsername,_that.areaManagerName,_that.qrCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  int? kanitId,  String? kanitUsername,  String? kanitName,  int? kacabId,  String? kacabUsername,  String? kacabName,  int? areaManagerId,  String? areaManagerUsername,  String? areaManagerName,  String? qrCode)  $default,) {final _that = this;
switch (_that) {
case _ScanQrModel():
return $default(_that.id,_that.name,_that.kanitId,_that.kanitUsername,_that.kanitName,_that.kacabId,_that.kacabUsername,_that.kacabName,_that.areaManagerId,_that.areaManagerUsername,_that.areaManagerName,_that.qrCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  int? kanitId,  String? kanitUsername,  String? kanitName,  int? kacabId,  String? kacabUsername,  String? kacabName,  int? areaManagerId,  String? areaManagerUsername,  String? areaManagerName,  String? qrCode)?  $default,) {final _that = this;
switch (_that) {
case _ScanQrModel() when $default != null:
return $default(_that.id,_that.name,_that.kanitId,_that.kanitUsername,_that.kanitName,_that.kacabId,_that.kacabUsername,_that.kacabName,_that.areaManagerId,_that.areaManagerUsername,_that.areaManagerName,_that.qrCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanQrModel extends ScanQrModel {
  const _ScanQrModel({required this.id, this.name, this.kanitId, this.kanitUsername, this.kanitName, this.kacabId, this.kacabUsername, this.kacabName, this.areaManagerId, this.areaManagerUsername, this.areaManagerName, this.qrCode}): super._();
  factory _ScanQrModel.fromJson(Map<String, dynamic> json) => _$ScanQrModelFromJson(json);

@override final  int id;
@override final  String? name;
@override final  int? kanitId;
@override final  String? kanitUsername;
@override final  String? kanitName;
@override final  int? kacabId;
@override final  String? kacabUsername;
@override final  String? kacabName;
@override final  int? areaManagerId;
@override final  String? areaManagerUsername;
@override final  String? areaManagerName;
@override final  String? qrCode;

/// Create a copy of ScanQrModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanQrModelCopyWith<_ScanQrModel> get copyWith => __$ScanQrModelCopyWithImpl<_ScanQrModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanQrModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanQrModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kanitId, kanitId) || other.kanitId == kanitId)&&(identical(other.kanitUsername, kanitUsername) || other.kanitUsername == kanitUsername)&&(identical(other.kanitName, kanitName) || other.kanitName == kanitName)&&(identical(other.kacabId, kacabId) || other.kacabId == kacabId)&&(identical(other.kacabUsername, kacabUsername) || other.kacabUsername == kacabUsername)&&(identical(other.kacabName, kacabName) || other.kacabName == kacabName)&&(identical(other.areaManagerId, areaManagerId) || other.areaManagerId == areaManagerId)&&(identical(other.areaManagerUsername, areaManagerUsername) || other.areaManagerUsername == areaManagerUsername)&&(identical(other.areaManagerName, areaManagerName) || other.areaManagerName == areaManagerName)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kanitId,kanitUsername,kanitName,kacabId,kacabUsername,kacabName,areaManagerId,areaManagerUsername,areaManagerName,qrCode);

@override
String toString() {
  return 'ScanQrModel(id: $id, name: $name, kanitId: $kanitId, kanitUsername: $kanitUsername, kanitName: $kanitName, kacabId: $kacabId, kacabUsername: $kacabUsername, kacabName: $kacabName, areaManagerId: $areaManagerId, areaManagerUsername: $areaManagerUsername, areaManagerName: $areaManagerName, qrCode: $qrCode)';
}


}

/// @nodoc
abstract mixin class _$ScanQrModelCopyWith<$Res> implements $ScanQrModelCopyWith<$Res> {
  factory _$ScanQrModelCopyWith(_ScanQrModel value, $Res Function(_ScanQrModel) _then) = __$ScanQrModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, int? kanitId, String? kanitUsername, String? kanitName, int? kacabId, String? kacabUsername, String? kacabName, int? areaManagerId, String? areaManagerUsername, String? areaManagerName, String? qrCode
});




}
/// @nodoc
class __$ScanQrModelCopyWithImpl<$Res>
    implements _$ScanQrModelCopyWith<$Res> {
  __$ScanQrModelCopyWithImpl(this._self, this._then);

  final _ScanQrModel _self;
  final $Res Function(_ScanQrModel) _then;

/// Create a copy of ScanQrModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? kanitId = freezed,Object? kanitUsername = freezed,Object? kanitName = freezed,Object? kacabId = freezed,Object? kacabUsername = freezed,Object? kacabName = freezed,Object? areaManagerId = freezed,Object? areaManagerUsername = freezed,Object? areaManagerName = freezed,Object? qrCode = freezed,}) {
  return _then(_ScanQrModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,kanitId: freezed == kanitId ? _self.kanitId : kanitId // ignore: cast_nullable_to_non_nullable
as int?,kanitUsername: freezed == kanitUsername ? _self.kanitUsername : kanitUsername // ignore: cast_nullable_to_non_nullable
as String?,kanitName: freezed == kanitName ? _self.kanitName : kanitName // ignore: cast_nullable_to_non_nullable
as String?,kacabId: freezed == kacabId ? _self.kacabId : kacabId // ignore: cast_nullable_to_non_nullable
as int?,kacabUsername: freezed == kacabUsername ? _self.kacabUsername : kacabUsername // ignore: cast_nullable_to_non_nullable
as String?,kacabName: freezed == kacabName ? _self.kacabName : kacabName // ignore: cast_nullable_to_non_nullable
as String?,areaManagerId: freezed == areaManagerId ? _self.areaManagerId : areaManagerId // ignore: cast_nullable_to_non_nullable
as int?,areaManagerUsername: freezed == areaManagerUsername ? _self.areaManagerUsername : areaManagerUsername // ignore: cast_nullable_to_non_nullable
as String?,areaManagerName: freezed == areaManagerName ? _self.areaManagerName : areaManagerName // ignore: cast_nullable_to_non_nullable
as String?,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
