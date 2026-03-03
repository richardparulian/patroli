import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_entity.freezed.dart';

@freezed
abstract class CheckInEntity with _$CheckInEntity {
  const factory CheckInEntity({
    required int id,
    required String name,
  }) = _CheckInEntity;

  // :: Empty check_in
  factory CheckInEntity.empty() => const CheckInEntity(id: 0, name: '');
}
