import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/scan_qr/domain/entities/attention.entity.dart';

part 'attention_model.freezed.dart';
part 'attention_model.g.dart';

@freezed
abstract class AttentionModel with _$AttentionModel {
  const AttentionModel._();

  const factory AttentionModel({
    int? id,
    int? branchId,
    String? notes,
    String? conditionRightNotes,
    String? conditionLeftNotes,
    String? conditionBackNotes,
    String? conditionAroundNotes,
    int? requireAttentions,
    int? conditionRightType,
    int? conditionLeftType,
    int? conditionBackType,
    int? conditionAroundType,
  }) = _AttentionModel;

  factory AttentionModel.fromJson(Map<String, dynamic> json) => _$AttentionModelFromJson(json);

  // Konversi ke entity jika ada AttentionEntity
  factory AttentionModel.fromEntity(AttentionEntity entity) {
    return AttentionModel(
      id: entity.id,
      branchId: entity.branchId,
      notes: entity.notes,
      conditionRightNotes: entity.conditionRightNotes,
      conditionLeftNotes: entity.conditionLeftNotes,
      conditionBackNotes: entity.conditionBackNotes,
      conditionAroundNotes: entity.conditionAroundNotes,
      requireAttentions: entity.requireAttentions,
      conditionRightType: entity.conditionRightType,
      conditionLeftType: entity.conditionLeftType,
      conditionBackType: entity.conditionBackType,
      conditionAroundType: entity.conditionAroundType,
    );
  }

  AttentionEntity toEntity() {
    return AttentionEntity(
      id: id,
      branchId: branchId,
      notes: notes,
      conditionRightNotes: conditionRightNotes,
      conditionLeftNotes: conditionLeftNotes,
      conditionBackNotes: conditionBackNotes,
      conditionAroundNotes: conditionAroundNotes,
      requireAttentions: requireAttentions,
      conditionRightType: conditionRightType,
      conditionLeftType: conditionLeftType,
      conditionBackType: conditionBackType,
      conditionAroundType: conditionAroundType,
    );
  }
}