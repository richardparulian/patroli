// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  ssoId: (json['sso_id'] as num).toInt(),
  name: json['name'] as String,
  username: json['username'] as String,
  role: (json['role'] as num).toInt(),
  shouldChangePassword: json['should_change_password'] as bool?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'sso_id': instance.ssoId,
  'name': instance.name,
  'username': instance.username,
  'role': instance.role,
  'should_change_password': instance.shouldChangePassword,
};
