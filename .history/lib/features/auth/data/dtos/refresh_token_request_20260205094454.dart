/// Refresh token request DTO
class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({
    required this.refreshToken,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() => {
        'refresh_token': refreshToken,
      };

  /// Create from token string
  factory RefreshTokenRequest.fromToken(String token) {
    return RefreshTokenRequest(refreshToken: token);
  }

  /// Create copy with modified fields
  RefreshTokenRequest copyWith({
    String? refreshToken,
  }) {
    return RefreshTokenRequest(
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  String toString() => 'RefreshTokenRequest(refreshToken: ****)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RefreshTokenRequest &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => refreshToken.hashCode;
}
