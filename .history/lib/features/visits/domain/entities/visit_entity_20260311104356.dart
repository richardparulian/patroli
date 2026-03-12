import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_entity.freezed.dart';

@freezed
abstract class VisitEntity with _$VisitEntity {
  const factory VisitEntity({
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
  }) = _VisitEntity;

  // :: Empty user (unauthenticated)
  factory VisitEntity.empty() {
    return VisitEntity(
      id: 0,
      date: null,
      checkOut: null,
      checkIn: null,
      checkInPhoto: null,
      checkOutPhoto: null,
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
