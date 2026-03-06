import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_sign_entity.freezed.dart';

@freezed
abstract class PreSignEntity with _$PreSignEntity {
  const factory PreSignEntity({
    required int id,
    required String name,
  }) = _PreSignEntity;

  // :: Empty pre_sign
  factory PreSignEntity.empty() => const PreSignEntity(id: 0, name: '');
}
