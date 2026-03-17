import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:patroli/features/auth/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    int? id,
    int? ssoId,
    String? name,
    String? username,
    int? role,
    bool? shouldChangePassword,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      ssoId: entity.ssoId,
      name: entity.name,
      username: entity.username,
      role: entity.role,
      shouldChangePassword: entity.shouldChangePassword,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id ?? 0,
      ssoId: ssoId ?? 0,
      name: name ?? '',
      username: username ?? '',
      role: role ?? 0,
      shouldChangePassword: shouldChangePassword ?? false,
    );
  }
}