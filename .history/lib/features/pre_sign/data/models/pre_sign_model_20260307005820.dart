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
    HeadersEntity? headers,
  }) = _PreSignModel;

  factory PreSignModel.fromJson(Map<String, dynamic> json) => _$PreSignModelFromJson(json);

  factory PreSignModel.fromEntity(PreSignEntity entity) {
    return PreSignModel(
      url: entity.url,
      fileUrl: entity.fileUrl,
    );
  }

  PreSignEntity toEntity() {
    return PreSignEntity(
      url: url,
      fileUrl: fileUrl,
      headers: headers ?? HeadersEntity.empty(),
    );
  }
}


@freezed
abstract class HeadersEntity with _$HeadersEntity {
  const HeadersEntity._();

  const factory HeadersEntity({
    required List<String> host,
  }) = _HeadersEntity;

  factory HeadersEntity.fromJson(Map<String, dynamic> json) => _$HeadersEntityFromJson(json);

  factory HeadersEntity.fromEntity(HeadersEntity entity) {
    return HeadersEntity(
      host: entity.host,
    );
  }

  HeadersEntity toEntity() {
    return HeadersEntity(
      host: host,
    );
  }
}