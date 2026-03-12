// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitRequest _$VisitRequestFromJson(Map<String, dynamic> json) => VisitRequest(
  lightsStatus: json['lights_status'] as String,
  bannerStatus: json['banner_status'] as String,
  rollingDoorStatus: json['rolling_door_status'] as String,
  conditionRight: json['condition_right'] as String,
  conditionLeft: json['condition_left'] as String,
  conditionBack: json['condition_back'] as String,
  conditionArround: json['condition_arround'] as String,
  notes: json['notes'] as String,
);

Map<String, dynamic> _$VisitRequestToJson(VisitRequest instance) =>
    <String, dynamic>{
      'lights_status': instance.lightsStatus,
      'banner_status': instance.bannerStatus,
      'rolling_door_status': instance.rollingDoorStatus,
      'condition_right': instance.conditionRight,
      'condition_left': instance.conditionLeft,
      'condition_back': instance.conditionBack,
      'condition_arround': instance.conditionArround,
      'notes': instance.notes,
    };
