import 'package:freezed_annotation/freezed_annotation.dart';

part 'created_entity.freezed.dart';

@freezed
abstract class CreatedEntity with _$CreatedEntity {
  const CreatedEntity._();

  const factory CreatedEntity({
    int? id,
    int? ssoId,
    String? name,
    String? username,
    int? role,
  }) = _CreatedEntity;

  // :: Empty created entity
  factory CreatedEntity.empty() => const CreatedEntity(
    id: 0,
    ssoId: 0,
    name: null,
    username: null,
    role: 0,
  );
}