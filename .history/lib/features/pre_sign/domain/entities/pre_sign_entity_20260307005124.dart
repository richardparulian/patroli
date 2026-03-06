import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_sign_entity.freezed.dart';

@freezed
abstract class PreSignEntity with _$PreSignEntity {
  const PreSignEntity._(); // necessary for custom getter

  const factory PreSignEntity({
    required String url,
    required String fileUrl,
    HeadersEntity? headers,
  }) = _PreSignEntity;

  // :: Empty user (unauthenticated)
  factory PreSignEntity.empty() {
    return PreSignEntity(
      url: '',
      fileUrl: '',
      headers: HeadersEntity(host: []),
    );
  }
}

@freezed
abstract class HeadersEntity with _$HeadersEntity {
  const HeadersEntity._();

  const factory HeadersEntity({
    required List<String> host,
  }) = _HeadersEntity;

  factory HeadersEntity.empty() {
    return HeadersEntity(
      host: [],
    );
  }

}