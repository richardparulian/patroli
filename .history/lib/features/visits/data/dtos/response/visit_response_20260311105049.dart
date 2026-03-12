import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/visits/data/models/visit_model.dart';

part 'visit_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VisitResponse {
  final VisitData data;

  const VisitResponse({
    required this.data,
  });

  factory VisitResponse.fromJson(Map<String, dynamic> json) => _$VisitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class VisitData {
  final VisitModel data;

  const VisitData({
    required this.data,
  });

  factory VisitData.fromJson(Map<String, dynamic> json) => _$VisitDataFromJson(json);

  Map<String, dynamic> toJson() => _$VisitDataToJson(this);
}