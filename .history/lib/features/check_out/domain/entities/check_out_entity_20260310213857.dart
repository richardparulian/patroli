import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_out_entity.freezed.dart';

@freezed
abstract class CheckOutEntity with _$CheckOutEntity {
  const factory CheckOutEntity({
    int? id,
    int? branchId,
    int? createdBy,
    String? selfieCheckIn,
    String? selfieCheckOut,
    String? checkOutAt,
    String? date,
    int? status,
    String? lightsStatus,
    String? bannerStatus,
    String? rollingDoorStatus,
    String? conditionRight,
    String? conditionLeft,
    String? conditionBack,
    String? conditionAround,
    String? notes,
    String? createdAt,
    String? updatedAt,
    
  }) = _CheckOutEntity;

  // :: Empty user (unauthenticated)
  factory CheckOutEntity.empty() {
    return CheckOutEntity(
      id: 0,
      branchId: 0,
      createdBy: 0,
      selfieCheckIn: null,
      selfieCheckOut: null,
      checkOutAt: null,
      date: null,
      status: 0,
      lightsStatus: null,
      bannerStatus: null,
      rollingDoorStatus: null,
      conditionRight: null,
      conditionLeft: null,
      conditionBack: null,
      conditionAround: null,
      notes: null,
      updatedAt: null,
      createdAt: null,
    );
  }
}
