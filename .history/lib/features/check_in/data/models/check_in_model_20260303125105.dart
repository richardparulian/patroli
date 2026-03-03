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


@freezed
abstract class CheckInModel with _$CheckInModel {
  const CheckInModel._();

  const factory CheckInModel({
    required int id,
    String? date,
    String? checkIn,
    String? checkOut,
    String? checkInPhoto,
    String? checkOutPhoto,
    String? lightsStatus,
    String? bannerStatus,
    String? rollingDoorStatus,
    String? conditionRight,
    String? conditionLeft,
    String? kanitUsername,
    String? conditionBack,
    String? conditionArround,
    int? statusValue,
    String? statusDescription,
    String? notes,
  }) = _CheckInModel;

  factory CheckInModel.fromJson(Map<String, dynamic> json) => _$CheckInModelFromJson(json);

  factory CheckInModel.fromEntity(CheckInEntity entity) {
    return CheckInModel(
      id: entity.id,
      date: entity.date,
      checkIn: entity.checkIn,
      checkOut: entity.checkOut,
      checkInPhoto: entity.checkInPhoto,
      checkOutPhoto: entity.checkOutPhoto,
      lightsStatus: entity.lightsStatus,
      bannerStatus: entity.bannerStatus,
      rollingDoorStatus: entity.rollingDoorStatus,
      conditionRight: entity.conditionRight,
      conditionLeft: entity.conditionLeft,
      conditionBack: entity.conditionBack,
      conditionArround: entity.conditionArround,
      statusValue: entity.statusValue,
      statusDescription: entity.statusDescription,
      notes: entity.notes,
    );
  }

  CheckInEntity toEntity() {
    return CheckInEntity(
      id: id, 
      date: date,
      checkIn: checkIn,
      checkOut: checkOut,
      checkInPhoto: checkInPhoto,
      checkOutPhoto: checkOutPhoto,
      lightsStatus: lightsStatus,
      bannerStatus: bannerStatus,
      rollingDoorStatus: rollingDoorStatus,
      conditionRight: conditionRight,
      conditionLeft: conditionLeft,
      conditionBack: conditionBack,
      conditionArround: conditionArround,
      statusValue: statusValue,
      statusDescription: statusDescription,
      notes: notes,
    );
  }
}