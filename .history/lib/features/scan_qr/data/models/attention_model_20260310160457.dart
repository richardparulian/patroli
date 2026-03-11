import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_attention_model.freezed.dart';
part 'visit_attention_model.g.dart';

@freezed
class AttentionModel with _$AttentionModel {
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

  factory VisitAttentionModel.fromJson(Map<String, dynamic> json) => _$VisitAttentionModelFromJson(json);
}