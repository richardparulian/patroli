import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/check_in/data/models/check_in_model.dart';

part 'visit_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VisitResponse {
  final VisitModel data;

  VisitResponse({
    required this.data,
  });

  factory VisitResponse.fromJson(Map<String, dynamic> json) => _$VisitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitResponseToJson(this);
}
