import 'package:freezed_annotation/freezed_annotation.dart';

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
  // BranchEntity toEntity() { ... }
}