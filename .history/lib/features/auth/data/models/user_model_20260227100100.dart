import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserModel({
    required int id,
    required int ssoId,
    required String name,
    required String username,
    required int role,
    bool? shouldChangePassword,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json)
      => _$UserModelFromJson(json);

  /// Convert Entity → Model
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
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      ssoId: ssoId,
      name: name,
      username: username,
      role: role,
      shouldChangePassword: shouldChangePassword ?? false,
    );
  }
}