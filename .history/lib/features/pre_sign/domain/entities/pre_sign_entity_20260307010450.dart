import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_sign_entity.freezed.dart';

@freezed
abstract class PreSignEntity with _$PreSignEntity {
  const PreSignEntity._(); // necessary for custom getter

  const factory PreSignEntity({
    required String url,
    required String fileUrl,
    required HeadersModel headers,
  }) = _PreSignEntity;

  // :: Empty user (unauthenticated)
  factory PreSignEntity.empty() {
    return PreSignEntity(
      url: '',
      fileUrl: '',
      headers: HeadersModel.empty(),
    );
  }
}

@freezed
abstract class HeadersModel with _$HeadersModel {
  const HeadersModel._();

  const factory HeadersModel({
    required List<String> host,
  }) = _HeadersModel;

  factory HeadersModel.empty() {
    return HeadersModel(
      host: [],
    );
  }

}