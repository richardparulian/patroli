import 'package:freezed_annotation/freezed_annotation.dart';

part 'attention_entity.freezed.dart';

@freezed
abstract class AttentionEntity with _$AttentionEntity {
   const AttentionEntity._();

  const factory AttentionEntity({
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
  }) = _AttentionEntity;

  // :: Empty attention
  factory AttentionEntity.empty() {
    return AttentionEntity(
      id: 0,
      branchId: 0,
      notes: null,
      conditionRightNotes: null,
      conditionLeftNotes: null,
      conditionBackNotes: null,
      conditionAroundNotes: null,
      requireAttentions: 0,
      conditionRightType: 0,
      conditionLeftType: 0,
      conditionBackType: 0,
      conditionAroundType: 0,
    );
  }
}