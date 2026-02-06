import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final int ssoId;
  final String name;
  final String username;
  final int role;
  final bool shouldChangePassword;

  const UserEntity({
    required this.id,
    required this.ssoId,
    required this.name,
    required this.username,
    required this.role,
    required this.shouldChangePassword,
  });

  @override
  List<Object?> get props => [id, ssoId, name, username, role, shouldChangePassword];

  /// Empty user (unauthenticated)
  factory UserEntity.empty() {
    return const UserEntity(
      id: 0,
      ssoId: 0,
      name: '',
      username: '',
      role: 0,
      shouldChangePassword: false,
    );
  }

  UserEntity copyWith({int? id, int? ssoId, String? name, String? username, int? role, bool? shouldChangePassword}) {
    return UserEntity(
      id: id ?? this.id,
      ssoId: ssoId ?? this.ssoId,
      name: name ?? this.name,
      username: username ?? this.username,
      role: role ?? this.role,
      shouldChangePassword: shouldChangePassword ?? this.shouldChangePassword,
    );
  }

  bool get isEmpty => id == 0;
  bool get isNotEmpty => !isEmpty;

  /// Convenience helpers
  bool get isAdmin => role == 1;
  bool get isManager => role == 2;
}
