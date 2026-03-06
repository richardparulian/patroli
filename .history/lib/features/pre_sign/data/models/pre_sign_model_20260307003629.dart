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
    PreSignHeaders? headers,
  }) = _PreSignModel;

  factory PreSignModel.fromJson(Map<String, dynamic> json) => _$PreSignModelFromJson(json);

  factory PreSignModel.fromEntity(PreSignEntity entity) {
    return PreSignModel(
      url: entity.url,
      fileUrl: entity.fileUrl,
      headers: entity.headers,
    );
  }

  PreSignEntity toEntity() {
    return PreSignEntity(
      url: url,
      fileUrl: fileUrl,
      headers: headers,
    );
  }
}

@freezed
abstract class PreSignHeaders with _$PreSignHeaders {
  const PreSignHeaders._();

  const factory PreSignHeaders({
    required List<String> host,
  }) = _PreSignHeaders;
}
