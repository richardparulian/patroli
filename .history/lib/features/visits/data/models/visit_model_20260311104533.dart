import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/check_out/domain/entities/check_out_entity.dart';

part 'visit_model.freezed.dart';
part 'visit_model.g.dart';

@freezed
abstract class VisitModel with _$VisitModel {
  const VisitModel._();

  const factory VisitModel({
    int? id,
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
    String? conditionBack,
    String? conditionAround,
    String? notes,
    int? statusValue,
    String? statusDescription,
  }) = _VisitModel;

  factory VisitModel.fromJson(Map<String, dynamic> json) => _$VisitModelFromJson(json);

  factory VisitModel.fromEntity(VisitEntity entity) {
    return VisitModel(
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
      conditionAround: entity.conditionAround,
      notes: entity.notes,
      statusValue: entity.statusValue,
      statusDescription: entity.statusDescription,
    );
  }

  VisitEntity toEntity() {
    return VisitEntity(
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
      conditionAround: conditionAround,
      notes: notes,
      statusValue: statusValue,
      statusDescription: statusDescription,
    );
  }
}