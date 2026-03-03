import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';

part 'scan_qr_model.freezed.dart';
part 'scan_qr_model.g.dart';

@freezed
abstract class ScanQrModel with _$ScanQrModel {
  const ScanQrModel._();

  const factory ScanQrModel({
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
  }) = _ScanQrModel;

  factory ScanQrModel.fromJson(Map<String, dynamic> json) => _$ScanQrModelFromJson(json);

  factory ScanQrModel.fromEntity(ScanQrEntity entity) {
    return ScanQrModel(
      id: entity.id,
      name: entity.name,
      kanitId: entity.kanitId,
      kanitUsername: entity.kanitUsername,
      kanitName: entity.kanitName,
      kacabId: entity.kacabId,
      kacabUsername: entity.kacabUsername,
      kacabName: entity.kacabName,
      areaManagerId: entity.areaManagerId,
      areaManagerUsername: entity.areaManagerUsername,
      areaManagerName: entity.areaManagerName,
      qrcode: entity.qrCode,
    );
  }

  ScanQrEntity toEntity() {
    return ScanQrEntity(
      id: id, 
      name: name,
      kanitId: kanitId,
      kanitUsername: kanitUsername,
      kanitName: kanitName,
      kacabId: kacabId,
      kacabUsername: kacabUsername,
      kacabName: kacabName,
      areaManagerId: areaManagerId,
      areaManagerUsername: areaManagerUsername,
      areaManagerName: areaManagerName,
      qrcode: qrcode,
    );
  }
}
