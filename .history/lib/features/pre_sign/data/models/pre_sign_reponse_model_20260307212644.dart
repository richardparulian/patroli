import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';

part 'pre_sign_reponse_model.freezed.dart';
part 'pre_sign_reponse_model.g.dart';

@freezed
abstract class PreSignReponseModel with _$PreSignReponseModel {
  const PreSignReponseModel._();

  const factory PreSignReponseModel({
    int statusCode,
    dynamic data,
  }) = _PreSignReponseModel;

  factory PreSignReponseModel.fromJson(Map<String, dynamic> json) => _$PreSignReponseModelFromJson(json);

  factory PreSignReponseModel.fromEntity(int statusCode, dynamic data) {
    return PreSignReponseModel(
      statusCode: statusCode,
      data: data,
    );
  }

  PreSignEntity toEntity() {
    return PreSignEntity(
      statusCode: statusCode,
      data: data,
    );
  }
}