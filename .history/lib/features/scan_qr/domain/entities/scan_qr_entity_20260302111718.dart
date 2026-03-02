import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_qr_entity.freezed.dart';

@freezed
abstract class ScanQrEntity with _$ScanQrEntity {
  const factory ScanQrEntity({
    required int id,
    int? kanitId,
    String? kanitUsername,
    String? kanitName,
    int? kacabId,
    String? kacabUsername,
    String? kacabName,
    int? areaManagerId,
    String? areaManagerUsername,
    String? areaManagerName,
    String? qrCode,
  }) = _ScanQrEntity;

  // :: Empty scan_qr
  factory ScanQrEntity.empty() {
    return ScanQrEntity(
      id: 0, 
      kanitId: null,
      kanitUsername: null,
      kanitName: null,
      kacabId: null,
      kacabUsername: null,
      kacabName: null,
      areaManagerId: null,
      areaManagerUsername: null,
      areaManagerName: null,
      qrCode: null,
    );
  }
}
