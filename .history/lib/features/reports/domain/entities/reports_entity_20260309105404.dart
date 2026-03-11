import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports_entity.freezed.dart';

@freezed
abstract class ReportsEntity with _$ReportsEntity {
  const factory ReportsEntity({
    required int id,
    required String name,
  }) = _ReportsEntity;

  // :: Empty reports
  factory ReportsEntity.empty() => const ReportsEntity(id: 0, name: '');
}
