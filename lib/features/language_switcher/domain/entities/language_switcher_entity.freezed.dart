// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_switcher_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LanguageSwitcherEntity {

 String get languageCode; String get displayName; bool get isSelected;
/// Create a copy of LanguageSwitcherEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageSwitcherEntityCopyWith<LanguageSwitcherEntity> get copyWith => _$LanguageSwitcherEntityCopyWithImpl<LanguageSwitcherEntity>(this as LanguageSwitcherEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageSwitcherEntity&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode,displayName,isSelected);

@override
String toString() {
  return 'LanguageSwitcherEntity(languageCode: $languageCode, displayName: $displayName, isSelected: $isSelected)';
}


}

/// @nodoc
abstract mixin class $LanguageSwitcherEntityCopyWith<$Res>  {
  factory $LanguageSwitcherEntityCopyWith(LanguageSwitcherEntity value, $Res Function(LanguageSwitcherEntity) _then) = _$LanguageSwitcherEntityCopyWithImpl;
@useResult
$Res call({
 String languageCode, String displayName, bool isSelected
});




}
/// @nodoc
class _$LanguageSwitcherEntityCopyWithImpl<$Res>
    implements $LanguageSwitcherEntityCopyWith<$Res> {
  _$LanguageSwitcherEntityCopyWithImpl(this._self, this._then);

  final LanguageSwitcherEntity _self;
  final $Res Function(LanguageSwitcherEntity) _then;

/// Create a copy of LanguageSwitcherEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageCode = null,Object? displayName = null,Object? isSelected = null,}) {
  return _then(_self.copyWith(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguageSwitcherEntity].
extension LanguageSwitcherEntityPatterns on LanguageSwitcherEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LanguageSwitcherEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LanguageSwitcherEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LanguageSwitcherEntity value)  $default,){
final _that = this;
switch (_that) {
case _LanguageSwitcherEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LanguageSwitcherEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LanguageSwitcherEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String languageCode,  String displayName,  bool isSelected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LanguageSwitcherEntity() when $default != null:
return $default(_that.languageCode,_that.displayName,_that.isSelected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String languageCode,  String displayName,  bool isSelected)  $default,) {final _that = this;
switch (_that) {
case _LanguageSwitcherEntity():
return $default(_that.languageCode,_that.displayName,_that.isSelected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String languageCode,  String displayName,  bool isSelected)?  $default,) {final _that = this;
switch (_that) {
case _LanguageSwitcherEntity() when $default != null:
return $default(_that.languageCode,_that.displayName,_that.isSelected);case _:
  return null;

}
}

}

/// @nodoc


class _LanguageSwitcherEntity implements LanguageSwitcherEntity {
  const _LanguageSwitcherEntity({required this.languageCode, required this.displayName, required this.isSelected});
  

@override final  String languageCode;
@override final  String displayName;
@override final  bool isSelected;

/// Create a copy of LanguageSwitcherEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageSwitcherEntityCopyWith<_LanguageSwitcherEntity> get copyWith => __$LanguageSwitcherEntityCopyWithImpl<_LanguageSwitcherEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanguageSwitcherEntity&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode,displayName,isSelected);

@override
String toString() {
  return 'LanguageSwitcherEntity(languageCode: $languageCode, displayName: $displayName, isSelected: $isSelected)';
}


}

/// @nodoc
abstract mixin class _$LanguageSwitcherEntityCopyWith<$Res> implements $LanguageSwitcherEntityCopyWith<$Res> {
  factory _$LanguageSwitcherEntityCopyWith(_LanguageSwitcherEntity value, $Res Function(_LanguageSwitcherEntity) _then) = __$LanguageSwitcherEntityCopyWithImpl;
@override @useResult
$Res call({
 String languageCode, String displayName, bool isSelected
});




}
/// @nodoc
class __$LanguageSwitcherEntityCopyWithImpl<$Res>
    implements _$LanguageSwitcherEntityCopyWith<$Res> {
  __$LanguageSwitcherEntityCopyWithImpl(this._self, this._then);

  final _LanguageSwitcherEntity _self;
  final $Res Function(_LanguageSwitcherEntity) _then;

/// Create a copy of LanguageSwitcherEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageCode = null,Object? displayName = null,Object? isSelected = null,}) {
  return _then(_LanguageSwitcherEntity(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
