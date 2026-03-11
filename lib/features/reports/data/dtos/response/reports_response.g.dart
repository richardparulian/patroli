// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportsResponse _$ReportsResponseFromJson(Map<String, dynamic> json) =>
    ReportsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ReportsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportsResponseToJson(ReportsResponse instance) =>
    <String, dynamic>{'data': instance.data};
