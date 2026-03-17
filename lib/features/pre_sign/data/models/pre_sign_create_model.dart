import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';

part 'pre_sign_create_model.freezed.dart';
part 'pre_sign_create_model.g.dart';

@freezed
abstract class PreSignCreateModel with _$PreSignCreateModel {
  const PreSignCreateModel._();

  const factory PreSignCreateModel({
    String? url,
    String? fileUrl,
  }) = _PreSignCreateModel;

  factory PreSignCreateModel.fromJson(Map<String, dynamic> json) => _$PreSignCreateModelFromJson(json);

  factory PreSignCreateModel.fromEntity(PreSignCreateEntity entity) {
    return PreSignCreateModel(
      url: entity.url,
      fileUrl: entity.fileUrl,
    );
  }

  PreSignCreateEntity toEntity() {
    return PreSignCreateEntity(
      url: url,
      fileUrl: fileUrl,
    );
  }
}