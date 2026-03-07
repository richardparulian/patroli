import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/pre_sign/data/models/pre_sign_create_model.dart';

part 'pre_sign_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreSignResponse {
  final PreSignCreateModel data;

  const PreSignResponse({
    required this.data,
  });

  factory PreSignResponse.fromJson(Map<String, dynamic> json) => _$PreSignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreSignResponseToJson(this);
}