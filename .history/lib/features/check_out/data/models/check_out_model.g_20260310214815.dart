// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckOutModel _$CheckOutModelFromJson(Map<String, dynamic> json) =>
    _CheckOutModel(
      id: (json['id'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      createdBy: (json['created_by'] as num?)?.toInt(),
      selfieCheckIn: json['selfie_check_in'] as String?,
      selfieCheckOut: json['selfie_check_out'] as String?,
      checkOutAt: json['check_out_at'] as String?,
      date: json['date'] as String?,
      status: (json['status'] as num?)?.toInt(),
      lightsStatus: json['lights_status'] as String?,
      bannerStatus: json['banner_status'] as String?,
      rollingDoorStatus: json['rolling_door_status'] as String?,
      conditionRight: json['condition_right'] as String?,
      conditionLeft: json['condition_left'] as String?,
      conditionBack: json['condition_back'] as String?,
      conditionArround: json['condition_arround'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$CheckOutModelToJson(_CheckOutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'created_by': instance.createdBy,
      'selfie_check_in': instance.selfieCheckIn,
      'selfie_check_out': instance.selfieCheckOut,
      'check_out_at': instance.checkOutAt,
      'date': instance.date,
      'status': instance.status,
      'lights_status': instance.lightsStatus,
      'banner_status': instance.bannerStatus,
      'rolling_door_status': instance.rollingDoorStatus,
      'condition_right': instance.conditionRight,
      'condition_left': instance.conditionLeft,
      'condition_back': instance.conditionBack,
      'condition_arround': instance.conditionArround,
      'notes': instance.notes,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
