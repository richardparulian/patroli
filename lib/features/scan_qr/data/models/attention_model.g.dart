// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attention_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttentionModel _$AttentionModelFromJson(Map<String, dynamic> json) =>
    _AttentionModel(
      id: (json['id'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      conditionRightNotes: json['condition_right_notes'] as String?,
      conditionLeftNotes: json['condition_left_notes'] as String?,
      conditionBackNotes: json['condition_back_notes'] as String?,
      conditionAroundNotes: json['condition_around_notes'] as String?,
      requireAttentions: (json['require_attentions'] as num?)?.toInt(),
      conditionRightType: (json['condition_right_type'] as num?)?.toInt(),
      conditionLeftType: (json['condition_left_type'] as num?)?.toInt(),
      conditionBackType: (json['condition_back_type'] as num?)?.toInt(),
      conditionAroundType: (json['condition_around_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AttentionModelToJson(_AttentionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'notes': instance.notes,
      'condition_right_notes': instance.conditionRightNotes,
      'condition_left_notes': instance.conditionLeftNotes,
      'condition_back_notes': instance.conditionBackNotes,
      'condition_around_notes': instance.conditionAroundNotes,
      'require_attentions': instance.requireAttentions,
      'condition_right_type': instance.conditionRightType,
      'condition_left_type': instance.conditionLeftType,
      'condition_back_type': instance.conditionBackType,
      'condition_around_type': instance.conditionAroundType,
    };
