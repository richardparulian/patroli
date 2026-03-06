import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';


part 'pre_sign_model.freezed.dart';
part 'pre_sign_model.g.dart';

@freezed
abstract class PreSignModel with _$PreSignModel {
  const PreSignModel._();

  const factory PreSignModel({
    required String url,
    required String fileUrl,
    Map<String, dynamic>? headers,
  }) = _PreSignModel;

  factory PreSignModel.fromJson(Map<String, dynamic> json) => _$PreSignModelFromJson(json);

  factory PreSignModel.fromEntity(PreSignEntity entity) {
    return PreSignModel(
      url: entity.url,
      fileUrl: entity.fileUrl,
      headers: null,
    );
  }

  PreSignEntity toEntity() {
    return PreSignEntity(
      url: url,
      fileUrl: fileUrl,
      headers: null,
    );
  }
}
