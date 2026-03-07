import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_sign_response_entity.freezed.dart';

@freezed
abstract class PreSignResponseEntity with _$PreSignResponseEntity {
  const factory PreSignResponseEntity({
    required int statusCode,
    required dynamic data,
  }) = _PreSignResponseEntity;

  // :: Empty user (unauthenticated)
  factory PreSignResponseEntity.empty() {
    return PreSignResponseEntity(
      statusCode: 0,
      data: null,
    );
  }
}