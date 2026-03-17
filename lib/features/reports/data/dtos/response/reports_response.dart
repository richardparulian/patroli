import 'package:json_annotation/json_annotation.dart';
import 'package:patroli/features/reports/data/models/reports_model.dart';

part 'reports_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportsResponse {
  final List<ReportsModel> data;

  const ReportsResponse({
    required this.data,
  });

  factory ReportsResponse.fromJson(Map<String, dynamic> json) => _$ReportsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportsResponseToJson(this);
}