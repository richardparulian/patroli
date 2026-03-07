import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';


part 'pre_sign_model.freezed.dart';
part 'pre_sign_model.g.dart';

@freezed
abstract class PreSignModel with _$PreSignModel {
  const PreSignModel._();

  const factory PreSignModel({
    String? url,
    String? fileUrl,
    @Default(HeadersModel(host: [])) HeadersModel headers,
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
      url: url ?? '',
      fileUrl: fileUrl ?? '',
      headers: headers.toEntity(),
    );
  }
}


@freezed
abstract class HeadersModel with _$HeadersModel { 
  const HeadersModel._();

  const factory HeadersModel({
    required List<String> host,
  }) = _HeadersModel;

  factory HeadersModel.fromJson(Map<String, dynamic> json) => _$HeadersModelFromJson(json);

  factory HeadersModel.fromEntity(HeadersModel entity) {
    return HeadersModel(
      host: entity.host,
    );
  }

  HeadersModel toEntity() {
    return HeadersModel(
      host: host,
    );
  }
}