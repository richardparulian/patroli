import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_sign_entity.freezed.dart';

@freezed
abstract class PreSignEntity with _$PreSignEntity {
  const factory PreSignEntity({
    required String url,
    required String fileUrl,
  }) = _PreSignEntity;

  // :: Empty pre_sign
  factory PreSignEntity.empty() => const PreSignEntity(url: '', fileUrl: '');
}
