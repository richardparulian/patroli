// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_sign_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreSignResponse _$PreSignResponseFromJson(Map<String, dynamic> json) =>
    PreSignResponse(
      data: PreSignData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreSignResponseToJson(PreSignResponse instance) =>
    <String, dynamic>{'data': instance.data};

PreSignData _$PreSignDataFromJson(Map<String, dynamic> json) => PreSignData(
  url: json['url'] as String,
  fileUrl: json['file_url'] as String,
);

Map<String, dynamic> _$PreSignDataToJson(PreSignData instance) =>
    <String, dynamic>{'url': instance.url, 'file_url': instance.fileUrl};
