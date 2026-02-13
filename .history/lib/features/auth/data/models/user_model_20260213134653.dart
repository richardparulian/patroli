import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends Equatable {
  final int id;
  final int ssoId;
  final String name;
  final String username;
  final int role;
  final bool? shouldChangePassword;

  const UserModel({
    required this.id,
    required this.ssoId,
    required this.name,
    required this.username,
    required this.role,
    this.shouldChangePassword,
  });

  @override
  List<Object?> get props => [id, ssoId, name, username, role, shouldChangePassword];

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

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
