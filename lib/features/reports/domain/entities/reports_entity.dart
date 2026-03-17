import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:patroli/features/reports/domain/entities/branch_entity.dart';
import 'package:patroli/features/reports/domain/entities/created_entity.dart';

part 'reports_entity.freezed.dart';

@freezed
abstract class ReportsEntity with _$ReportsEntity {
  const ReportsEntity._();

  const factory ReportsEntity({
    int? id,
    String? date,
    String? checkIn,
    String? checkOut,
    CreatedEntity? createdBy,
    BranchEntity? branch,
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
  }) = _ReportsEntity;

  // :: Empty reports entity
  factory ReportsEntity.empty() => ReportsEntity(
    id: 0,
    date: null,
    checkIn: null,
    checkOut: null,
    createdBy: null,
    branch: null,
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