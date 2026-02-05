import 'package:pos/features/auth/data/models/user_model.dart';

/// Authentication response DTO
class AuthResponse {
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  AuthResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  /// Create from JSON API response
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }

  /// :: Convert to JSON (rarely needed)
  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };

  /// :: Create copy with modified fields
  AuthResponse copyWith({UserModel? user, String? accessToken, String? refreshToken}) {
    return AuthResponse(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  String toString() => 'AuthResponse(user: $user, accessToken: ****, refreshToken: ****)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthResponse && other.user == user && other.accessToken == accessToken && other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => user.hashCode ^ accessToken.hashCode ^ refreshToken.hashCode;
}
