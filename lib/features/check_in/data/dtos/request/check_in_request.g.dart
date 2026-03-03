// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInRequest _$CheckInRequestFromJson(Map<String, dynamic> json) =>
    CheckInRequest(
      branchId: (json['branch_id'] as num).toInt(),
      selfieCheckIn: json['selfie_check_in'] as String,
    );

Map<String, dynamic> _$CheckInRequestToJson(CheckInRequest instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'selfie_check_in': instance.selfieCheckIn,
    };
