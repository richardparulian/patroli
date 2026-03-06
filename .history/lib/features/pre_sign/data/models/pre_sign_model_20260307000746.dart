import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/pre_sign_entity.dart';

part 'pre_sign_model.freezed.dart';
part 'pre_sign_model.g.dart';

@freezed
abstract class PreSignModel with _$PreSignModel {
  const PreSignModel._();

  const factory PreSignModel({
    required int id,
    required String name,
  }) = _PreSignModel;

  factory PreSignModel.fromJson(Map<String, dynamic> json) =>
      _$PreSignModelFromJson(json);

  PreSignEntity toEntity() => PreSignEntity(id: id, name: name);
}
