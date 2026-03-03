import 'package:json_annotation/json_annotation.dart';
import '../../models/check_in_model.dart';

part 'check_in_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckInResponse {
  final CheckInData data;

  CheckInResponse({
    required this.data,
  });

  factory CheckInResponse.fromJson(Map<String, dynamic> json) => _$CheckInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse {
  final LoginData data;

  const LoginResponse({
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginData {
  final String token;
  final UserModel user;

  const LoginData({
    required this.token,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
