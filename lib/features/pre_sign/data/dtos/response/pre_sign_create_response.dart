import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/pre_sign/data/models/pre_sign_create_model.dart';

part 'pre_sign_create_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreSignCreateResponse {
  final PreSignCreateModel data;

  const PreSignCreateResponse({
    required this.data,
  });

  factory PreSignCreateResponse.fromJson(Map<String, dynamic> json) => _$PreSignCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreSignCreateResponseToJson(this);
}