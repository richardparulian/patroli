import 'package:freezed_annotation/freezed_annotation.dart';

part 'created_model.freezed.dart';
part 'created_model.g.dart';

@freezed
abstract class CreatedModel with _$CreatedModel {
  const CreatedModel._();

  const factory CreatedModel({
    int? id,
    int? ssoId,
    String? name,
    String? username,
    int? role,
  }) = _CreatedModel;

  factory CreatedModel.fromJson(Map<String, dynamic> json) => _$CreatedModelFromJson(json);

  factory CreatedModel.fromEntity(CreatedEntity entity) {
    return CreatedModel(
      id: entity.id,
      ssoId: entity.ssoId,
      name: entity.name,
      username: entity.username,
      role: entity.role,
    );
  }
}