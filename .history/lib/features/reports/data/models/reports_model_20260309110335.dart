import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';

part 'reports_model.freezed.dart';
part 'reports_model.g.dart';

@freezed
abstract class ReportsModel with _$ReportsModel {
  const ReportsModel._();

  const factory ReportsModel({
    int? id,
    String? date,
    String? checkIn,
    String? username,
    int? role,
    bool? shouldChangePassword,
  }) = _ReportsModel;

  factory ReportsModel.fromJson(Map<String, dynamic> json) => _$ReportsModelFromJson(json);

  factory ReportsModel.fromEntity(ReportsEntity entity) {
    return ReportsModel(
      id: entity.id,
      ssoId: entity.ssoId,
      name: entity.name,
      username: entity.username,
      role: entity.role,
      shouldChangePassword: entity.shouldChangePassword,
    );
  }

  ReportsEntity toEntity() {
    return ReportsEntity(
      id: id ?? 0,
      ssoId: ssoId ?? 0,
      name: name ?? '',
      username: username ?? '',
      role: role ?? 0,
      shouldChangePassword: shouldChangePassword ?? false,
    );
  }
}