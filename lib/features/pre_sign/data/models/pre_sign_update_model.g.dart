// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_sign_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreSignUpdateModel _$PreSignUpdateModelFromJson(Map<String, dynamic> json) =>
    _PreSignUpdateModel(
      statusCode: (json['status_code'] as num).toInt(),
      data: json['data'],
    );

Map<String, dynamic> _$PreSignUpdateModelToJson(_PreSignUpdateModel instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
