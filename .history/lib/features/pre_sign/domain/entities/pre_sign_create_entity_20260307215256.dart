import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_sign_create_entity.freezed.dart';

@freezed
abstract class PreSignCreateEntity with _$PreSignCreateEntity {
  const factory PreSignCreateEntity({
    required String url,
    required String fileUrl,
  }) = _PreSignCreateEntity;

  // :: Empty user (unauthenticated)
  factory PreSignCreateEntity.empty() {
    return PreSignCreateEntity(
      url: '',
      fileUrl: '',
    );
  }
}