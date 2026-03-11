import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_out/domain/entities/check_out_entity.dart';

part 'check_out_model.freezed.dart';
part 'check_out_model.g.dart';

@freezed
abstract class CheckOutModel with _$CheckOutModel {
  const CheckOutModel._();

  const factory CheckOutModel({
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
  }) = _CheckOutModel;

  factory CheckOutModel.fromJson(Map<String, dynamic> json) => _$CheckOutModelFromJson(json);

  factory CheckOutModel.fromEntity(CheckOutEntity entity) {
    return CheckOutModel(
      id: entity.id,
      branchId: entity.branchId,
      createdBy: entity.createdBy,
      selfieCheckIn: entity.selfieCheckIn,
      selfieCheckOut: entity.selfieCheckOut,
      checkOutAt: entity.checkOutAt,
      date: entity.date,
      status: entity.status,
      lightsStatus: entity.lightsStatus,
      bannerStatus: entity.bannerStatus,
      rollingDoorStatus: entity.rollingDoorStatus,
      conditionRight: entity.conditionRight,
      conditionLeft: entity.conditionLeft,
      conditionBack: entity.conditionBack,
      conditionArround: entity.conditionArround,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  CheckOutEntity toEntity() {
    return CheckOutEntity(
      id: id, 
      date: date,
      selfieCheckOut: selfieCheckOut,
      checkOutAt: checkOutAt,
      date: date,
      status: status,
      lightsStatus: lightsStatus,
      bannerStatus: bannerStatus,
      rollingDoorStatus: rollingDoorStatus,
      conditionRight: conditionRight,
    );
  }
}