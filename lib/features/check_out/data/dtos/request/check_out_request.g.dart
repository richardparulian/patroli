// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutRequest _$CheckOutRequestFromJson(Map<String, dynamic> json) =>
    CheckOutRequest(
      branchId: (json['branch_id'] as num).toInt(),
      selfieCheckOut: json['selfie_check_out'] as String,
    );

Map<String, dynamic> _$CheckOutRequestToJson(CheckOutRequest instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'selfie_check_out': instance.selfieCheckOut,
    };
