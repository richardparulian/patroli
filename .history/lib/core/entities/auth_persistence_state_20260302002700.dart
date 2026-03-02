import 'package:pos/features/auth/domain/entities/user_entity.dart';

class AuthPersistenceState {
  final UserEntity? user;
  final String? token;
  final bool isLoggedIn;
  final DateTime? loginTime;

  const AuthPersistenceState({
    this.user,
    this.token,
    this.isLoggedIn = false,
    this.loginTime,
  });

  AuthPersistenceState copyWith({
    UserEntity? user,
    String? token,
    bool? isLoggedIn,
    DateTime? loginTime,
  }) {
    return AuthPersistenceState(
      user: user ?? this.user,
      token: token ?? this.token,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      loginTime: loginTime ?? this.loginTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (user != null) 'user': user!.toJson(),
      if (token != null) 'token': token,
      'isLoggedIn': isLoggedIn,
      if (loginTime != null) 'loginTime': loginTime!.toIso8601String(),
    };
  }

  factory AuthPersistenceState.fromJson(Map<String, dynamic> json) {
    return AuthPersistenceState(
      user: json.containsKey('user') && json['user'] != null ? UserEntity.fromJson(json['user']) : null,
      token: json['token'],
      isLoggedIn: json['isLoggedIn'] ?? false,
      loginTime: json.containsKey('loginTime') && json['loginTime'] != null ? DateTime.parse(json['loginTime']) : null,
    );
  }
}
