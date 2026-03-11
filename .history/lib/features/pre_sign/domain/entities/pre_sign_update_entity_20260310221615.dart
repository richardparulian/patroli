import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_sign_update_entity.freezed.dart';

@freezed
abstract class PreSignUpdateEntity with _$PreSignUpdateEntity {
  const factory PreSignUpdateEntity({
    int? statusCode,
    required dynamic data,
  }) = _PreSignUpdateEntity;

  // :: Empty user (unauthenticated)
  factory PreSignUpdateEntity.empty() {
    return PreSignUpdateEntity(
      statusCode: 0,
      data: null,
    );
  }
}