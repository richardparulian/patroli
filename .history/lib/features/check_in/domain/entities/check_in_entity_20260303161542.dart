import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_entity.freezed.dart';

@freezed
abstract class CheckInEntity with _$CheckInEntity {
  const CheckInEntity._(); // necessary for custom getter

  const factory CheckInEntity({
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
    String? conditionBack,
    String? conditionAround,
    int? statusValue,
    String? statusDescription,
    String? notes,
  }) = _CheckInEntity;

  // :: Empty user (unauthenticated)
  factory CheckInEntity.empty() {
    return CheckInEntity(
      id: 0,
      date: null,
      checkIn: null,
      checkOut: null,
      checkInPhoto: null,
      checkOutPhoto: null,
      lightsStatus: null,
      bannerStatus: null,
      rollingDoorStatus: null,
      conditionRight: null,
      conditionLeft: null,
      conditionBack: null,
      conditionAround: null,
      statusValue: 0,
      statusDescription: null,
      notes: null,
    );
  }
}
