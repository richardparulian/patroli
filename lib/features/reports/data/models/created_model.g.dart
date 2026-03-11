// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatedModel _$CreatedModelFromJson(Map<String, dynamic> json) =>
    _CreatedModel(
      id: (json['id'] as num?)?.toInt(),
      ssoId: (json['sso_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      username: json['username'] as String?,
      role: (json['role'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreatedModelToJson(_CreatedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sso_id': instance.ssoId,
      'name': instance.name,
      'username': instance.username,
      'role': instance.role,
    };
