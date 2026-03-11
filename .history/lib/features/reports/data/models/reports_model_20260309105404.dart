import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/reports_entity.dart';

part 'reports_model.freezed.dart';
part 'reports_model.g.dart';

@freezed
abstract class ReportsModel with _$ReportsModel {
  const ReportsModel._();

  const factory ReportsModel({
    required int id,
    required String name,
  }) = _ReportsModel;

  factory ReportsModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsModelFromJson(json);

  ReportsEntity toEntity() => ReportsEntity(id: id, name: name);
}
