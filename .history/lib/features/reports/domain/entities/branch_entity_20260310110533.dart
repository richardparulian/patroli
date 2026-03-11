import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch_entity.freezed.dart';

@freezed
abstract class BranchEntity with _$BranchEntity {
  const BranchEntity._();

  const factory BranchEntity({
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
  }) = _BranchEntity;

  // :: Empty branch entity
  factory BranchEntity.empty() => const BranchEntity(
    id: null,
    name: null,
    kanitId: null,
    kanitUsername: null,
    kanitName: null,
    kacabId: null,
    kacabUsername: null,
    kacabName: null,
    areaManagerId: null,
    areaManagerUsername: null,
    areaManagerName: null,
    qrcode: null,
  );
}