// import 'package:pos/features/auth/data/models/user_model.dart';

// /// Authentication response DTO
// class AuthResponse {
//   final UserModel user;
//   final String token;

//   AuthResponse({
//     required this.user,
//     required this.token,
//   });

//   /// Create from API response
//   factory AuthResponse.fromJson(Map<String, dynamic> json) {
//     final data = json['data'] as Map<String, dynamic>;

//     return AuthResponse(
//       token: data['token'] as String,
//       user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
//     );
//   }

//   /// Convert to JSON
//   Map<String, dynamic> toJson() => {
//     'data': {
//       'token': token,
//       'user': user.toJson(),
//     },
//   };

//   /// Copy with
//   AuthResponse copyWith({UserModel? user, String? token}) {
//     return AuthResponse(
//       user: user ?? this.user,
//       token: token ?? this.token,
//     );
//   }

//   @override
//   String toString() => 'AuthResponse(user: $user, token: ****)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is AuthResponse && other.user == user && other.token == token;
//   }

//   @override
//   int get hashCode => user.hashCode ^ token.hashCode;
// }

import 'package:json_annotation/json_annotation.dart';
import 'package:pos/features/auth/data/models/user_model.dart';

part 'login_response.g.dart';

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