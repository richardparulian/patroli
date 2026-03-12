import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/scan_qr/domain/entities/attention.entity.dart';

part 'scan_qr_entity.freezed.dart';

@freezed
abstract class ScanQrEntity with _$ScanQrEntity {  
  const factory ScanQrEntity({
    int? id,
    String? name,
    int? kanitId,
    String? kanitUsername,
    String? kanitName,
    int? kacabId,
    String? kacabUsername,
    String? kacabName,
    int? areaManagerId,
    String? areaManagerUsername,
    String? areaManagerName,
    String? qrcode,
    AttentionEntity? visitAttention,
  }) = _ScanQrEntity;

  // :: Empty scan_qr
  factory ScanQrEntity.empty() => ScanQrEntity(
    id: 0, 
    name: null,
    kanitId: 0,
    kanitUsername: null,
    kanitName: null,
    kacabId: 0,
    kacabUsername: null,
    kacabName: null,
    areaManagerId: 0,
    areaManagerUsername: null,
    areaManagerName: null,
    qrcode: null,
    attention: null,
  );
}
