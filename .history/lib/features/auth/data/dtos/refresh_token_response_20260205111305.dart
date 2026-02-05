/// Refresh token response DTO
class RefreshTokenResponse {
  final String accessToken;
  final String? refreshToken;

  RefreshTokenResponse({
    required this.accessToken,
    this.refreshToken,
  });

  /// Create from JSON API response
  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  /// :: Convert to JSON (rarely needed)
  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    if (refreshToken != null) 'refresh_token': refreshToken,
  };

  /// :: Create copy with modified fields
  RefreshTokenResponse copyWith({String? accessToken, String? refreshToken}) {
    return RefreshTokenResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  String toString() => 'RefreshTokenResponse(accessToken: ****, refreshToken: ****)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RefreshTokenResponse && other.accessToken == accessToken && other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => accessToken.hashCode ^ (refreshToken?.hashCode ?? 0);
}
