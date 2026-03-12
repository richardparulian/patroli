// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckInModel _$CheckInModelFromJson(Map<String, dynamic> json) =>
    _CheckInModel(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String?,
      checkIn: json['check_in'] as String?,
      checkOut: json['check_out'] as String?,
      checkInPhoto: json['check_in_photo'] as String?,
      checkOutPhoto: json['check_out_photo'] as String?,
      lightsStatus: json['lights_status'] as String?,
      bannerStatus: json['banner_status'] as String?,
      rollingDoorStatus: json['rolling_door_status'] as String?,
      conditionRight: json['condition_right'] as String?,
      conditionLeft: json['condition_left'] as String?,
      kanitUsername: json['kanit_username'] as String?,
      conditionBack: json['condition_back'] as String?,
      conditionAround: json['condition_around'] as String?,
      statusValue: (json['status_value'] as num?)?.toInt(),
      statusDescription: json['status_description'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CheckInModelToJson(_CheckInModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'check_in': instance.checkIn,
      'check_out': instance.checkOut,
      'check_in_photo': instance.checkInPhoto,
      'check_out_photo': instance.checkOutPhoto,
      'lights_status': instance.lightsStatus,
      'banner_status': instance.bannerStatus,
      'rolling_door_status': instance.rollingDoorStatus,
      'condition_right': instance.conditionRight,
      'condition_left': instance.conditionLeft,
      'kanit_username': instance.kanitUsername,
      'condition_back': instance.conditionBack,
      'condition_around': instance.conditionAround,
      'status_value': instance.statusValue,
      'status_description': instance.statusDescription,
      'notes': instance.notes,
    };
