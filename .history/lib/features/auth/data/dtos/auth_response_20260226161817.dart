import 'package:json_annotation/json_annotation.dart';
import '../models/user_model.dart';

part 'auth_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResponse {
  final UserModel user;
  final String token;

  AuthResponse({
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
