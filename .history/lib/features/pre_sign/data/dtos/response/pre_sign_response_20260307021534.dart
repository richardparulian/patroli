import 'package:json_annotation/json_annotation.dart';

part 'pre_sign_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreSignResponse {
  final PreSignData data;

  const PreSignResponse({
    required this.data,
  });

  factory PreSignResponse.fromJson(Map<String, dynamic> json) => _$PreSignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreSignResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PreSignData {
  final String url;
  final String fileUrl;

  const PreSignData({
    required this.url,
    required this.fileUrl,
  });

  factory PreSignData.fromJson(Map<String, dynamic> json) => _$PreSignDataFromJson(json);

  Map<String, dynamic> toJson() => _$PreSignDataToJson(this);
}