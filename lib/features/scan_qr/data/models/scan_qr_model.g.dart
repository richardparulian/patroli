// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_qr_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScanQrModel _$ScanQrModelFromJson(Map<String, dynamic> json) => _ScanQrModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  kanitId: (json['kanit_id'] as num?)?.toInt(),
  kanitUsername: json['kanit_username'] as String?,
  kanitName: json['kanit_name'] as String?,
  kacabId: (json['kacab_id'] as num?)?.toInt(),
  kacabUsername: json['kacab_username'] as String?,
  kacabName: json['kacab_name'] as String?,
  areaManagerId: (json['area_manager_id'] as num?)?.toInt(),
  areaManagerUsername: json['area_manager_username'] as String?,
  areaManagerName: json['area_manager_name'] as String?,
  qrcode: json['qrcode'] as String?,
);

Map<String, dynamic> _$ScanQrModelToJson(_ScanQrModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kanit_id': instance.kanitId,
      'kanit_username': instance.kanitUsername,
      'kanit_name': instance.kanitName,
      'kacab_id': instance.kacabId,
      'kacab_username': instance.kacabUsername,
      'kacab_name': instance.kacabName,
      'area_manager_id': instance.areaManagerId,
      'area_manager_username': instance.areaManagerUsername,
      'area_manager_name': instance.areaManagerName,
      'qrcode': instance.qrcode,
    };
