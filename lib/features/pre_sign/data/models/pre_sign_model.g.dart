// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_sign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreSignModel _$PreSignModelFromJson(Map<String, dynamic> json) =>
    _PreSignModel(
      url: json['url'] as String,
      fileUrl: json['file_url'] as String,
      headers: HeadersModel.fromJson(json['headers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreSignModelToJson(_PreSignModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'file_url': instance.fileUrl,
      'headers': instance.headers,
    };

_HeadersModel _$HeadersModelFromJson(Map<String, dynamic> json) =>
    _HeadersModel(
      host: (json['host'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HeadersModelToJson(_HeadersModel instance) =>
    <String, dynamic>{'host': instance.host};
