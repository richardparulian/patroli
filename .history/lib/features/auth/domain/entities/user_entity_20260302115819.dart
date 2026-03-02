import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const UserEntity._(); // necessary for custom getter

  const factory UserEntity({
    required int id,
    required int ssoId,
    required String name,
    required String username,
    required int role,
    required bool shouldChangePassword,
  }) = _UserEntity;

  // :: Empty user (unauthenticated)
  factory UserEntity.empty() => const UserEntity(
    id: 0,
    ssoId: 0,
    name: '',
    username: '',
    role: 0,
    shouldChangePassword: false,
  );

  bool get isEmpty => id == 0;
  bool get isNotEmpty => !isEmpty;

  bool get isAdmin => role == 1;
  bool get isManager => role == 2;
}
