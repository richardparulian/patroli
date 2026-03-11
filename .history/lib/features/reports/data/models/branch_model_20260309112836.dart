import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/reports/domain/entities/branch_entity.dart';

part 'branch_model.freezed.dart';
part 'branch_model.g.dart';

@freezed
abstract class BranchModel with _$BranchModel {
  const BranchModel._();

  const factory BranchModel({
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
  }) = _BranchModel;

  factory BranchModel.fromJson(Map<String, dynamic> json) => _$BranchModelFromJson(json);

  // Konversi ke entity jika ada BranchEntity
  factory BranchModel.fromEntity(BranchEntity entity) {
    return BranchModel(
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
      qrcode: entity.qrcode,
    );
  }

  BranchEntity toEntity() {
    return BranchEntity(
      id: id ?? 0,
      name: name ?? '',
      kanitId: kanitId ?? 0,
      kanitUsername: kanitUsername ?? '',
      kanitName: kanitName ?? '',
      kacabId: kacabId ?? 0,
      kacabUsername: kacabUsername ?? '',
      kacabName: kacabName ?? '',
      areaManagerId: areaManagerId ?? 0,
      areaManagerUsername: areaManagerUsername ?? '',
      areaManagerName: areaManagerName ?? '',
      qrcode: qrcode ?? '',
    );
  }
}