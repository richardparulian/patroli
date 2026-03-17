import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_update_entity.dart';

part 'pre_sign_update_model.freezed.dart';
part 'pre_sign_update_model.g.dart';

@freezed
abstract class PreSignUpdateModel with _$PreSignUpdateModel {
  const PreSignUpdateModel._();

  const factory PreSignUpdateModel({
    int? statusCode,
    dynamic data,
  }) = _PreSignUpdateModel;

  factory PreSignUpdateModel.fromJson(Map<String, dynamic> json) => _$PreSignUpdateModelFromJson(json);

  factory PreSignUpdateModel.fromEntity(PreSignUpdateEntity entity) {
    return PreSignUpdateModel(
      statusCode: entity.statusCode,
      data: entity.data,
    );
  }

  PreSignUpdateEntity toEntity() {
    return PreSignUpdateEntity(
      statusCode: statusCode,
      data: data,
    );
  }
}