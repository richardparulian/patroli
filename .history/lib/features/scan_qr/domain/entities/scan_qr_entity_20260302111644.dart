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
  factory ScanQrEntity.empty() => const ScanQrEntity(id: 0, name: '');
}
