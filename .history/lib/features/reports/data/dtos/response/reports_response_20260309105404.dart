import 'package:json_annotation/json_annotation.dart';
import '../../models/reports_model.dart';

part 'reports_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportsResponse {
  final ReportsModel reports;

  ReportsResponse({
    required this.reports,
  });

  factory ReportsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportsResponseToJson(this);

  @override
  String toString() => 'Reports(reports: $reports)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReportsResponse && other.reports == reports;
  }

  @override
  int get hashCode => Object.hash(reports, runtimeType);
}
