import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports_entity.freezed.dart';

@freezed
abstract class ReportsEntity with _$ReportsEntity {
  const ReportsEntity._();

  const factory ReportsEntity({
    required int id,
    required String date,
    String? checkIn,
    String? checkOut,
    required CreatedEntity createdBy,
    required BranchEntity branch,
    String? checkInPhoto,
    String? checkOutPhoto,
    String? lightsStatus,
    String? bannerStatus,
    String? rollingDoorStatus,
    String? conditionRight,
    String? conditionLeft,
    String? conditionBack,
    String? conditionAround,
    required int statusValue,
    required String statusDescription,
    String? notes,
  }) = _ReportsEntity;

  // :: Empty reports entity
  factory ReportsEntity.empty() => ReportsEntity(
    id: 0,
    date: '',
    checkIn: null,
    checkOut: null,
    createdBy: CreatedEntity.empty(),
    branch: BranchEntity.empty(),
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
    statusDescription: '',
    notes: null,
  );
}