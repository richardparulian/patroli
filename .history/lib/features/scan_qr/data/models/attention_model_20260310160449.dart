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
    @JsonKey(name: 'condition_left_notes') String? conditionLeftNotes,
    @JsonKey(name: 'condition_back_notes') String? conditionBackNotes,
    @JsonKey(name: 'condition_around_notes') String? conditionAroundNotes,
    @JsonKey(name: 'require_attentions') int? requireAttentions,
    @JsonKey(name: 'condition_right_type') int? conditionRightType,
    @JsonKey(name: 'condition_left_type') int? conditionLeftType,
    @JsonKey(name: 'condition_back_type') int? conditionBackType,
    @JsonKey(name: 'condition_around_type') int? conditionAroundType,
  }) = _VisitAttentionModel;

  factory VisitAttentionModel.fromJson(Map<String, dynamic> json) =>
      _$VisitAttentionModelFromJson(json);
}