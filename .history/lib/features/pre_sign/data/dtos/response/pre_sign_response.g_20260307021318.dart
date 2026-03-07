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
  headers: HeadersModel(host: (json['headers'] as List<dynamic>).map((e) => e as String).toList()),
);

Map<String, dynamic> _$PreSignDataToJson(PreSignData instance) =>
    <String, dynamic>{
      'url': instance.url,
      'file_url': instance.fileUrl,
      'headers': instance.headers,
    };

HeadersModel _$HeadersModelFromJson(Map<String, dynamic> json) => HeadersModel(
  host: (json['host'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$HeadersModelToJson(HeadersModel instance) =>
    <String, dynamic>{'host': instance.host};
