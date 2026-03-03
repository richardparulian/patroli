import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/check_in_entity.dart';

part 'check_in_model.freezed.dart';
part 'check_in_model.g.dart';

@freezed
abstract class CheckInModel with _$CheckInModel {
  const CheckInModel._();

  const factory CheckInModel({
    required int id,
    required String name,
  }) = _CheckInModel;

  factory CheckInModel.fromJson(Map<String, dynamic> json) => _$CheckInModelFromJson(json);

  CheckInEntity toEntity() => CheckInEntity(id: id, name: name);
}
