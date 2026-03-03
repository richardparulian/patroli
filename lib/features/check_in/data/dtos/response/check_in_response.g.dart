// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInResponse _$CheckInResponseFromJson(Map<String, dynamic> json) =>
    CheckInResponse(
      data: CheckInData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckInResponseToJson(CheckInResponse instance) =>
    <String, dynamic>{'data': instance.data};

CheckInData _$CheckInDataFromJson(Map<String, dynamic> json) => CheckInData(
  checkIn: CheckInModel.fromJson(json['check_in'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CheckInDataToJson(CheckInData instance) =>
    <String, dynamic>{'check_in': instance.checkIn};
