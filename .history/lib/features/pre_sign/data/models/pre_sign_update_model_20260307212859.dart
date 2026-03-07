import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_response_entity.dart';

part 'pre_sign_reponse_model.freezed.dart';
part 'pre_sign_reponse_model.g.dart';

@freezed
abstract class PreSignReponseModel with _$PreSignReponseModel {
  const PreSignReponseModel._();

  const factory PreSignReponseModel({
    required int statusCode,
    dynamic data,
  }) = _PreSignReponseModel;

  factory PreSignReponseModel.fromJson(Map<String, dynamic> json) => _$PreSignReponseModelFromJson(json);

  factory PreSignReponseModel.fromEntity(PreSignResponseEntity entity) {
    return PreSignReponseModel(
      statusCode: entity.statusCode,
      data: entity.data,
    );
  }

  PreSignResponseEntity toEntity() {
    return PreSignResponseEntity(
      statusCode: statusCode,
      data: data,
    );
  }
}