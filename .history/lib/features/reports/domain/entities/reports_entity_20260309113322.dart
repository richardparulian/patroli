import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/reports/domain/entities/branch_entity.dart';
import 'package:pos/features/reports/domain/entities/created_entity.dart';

part 'reports_entity.freezed.dart';

@freezed
abstract class ReportsEntity with _$ReportsEntity {
  const ReportsEntity._();

  const factory ReportsEntity({
    int? id,
    String? date,
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
    int? statusValue,
    String? statusDescription,
    String? notes,
  }) = _ReportsEntity;

  // :: Empty reports entity
  factory ReportsEntity.empty() => ReportsEntity(
    id: 0,
    date: '',
    checkIn: '',
    checkOut: '',
    createdBy: CreatedEntity.empty(),
    branch: BranchEntity.empty(),
    checkInPhoto: '',
    checkOutPhoto: '',
    lightsStatus: '',
    bannerStatus: '',
    rollingDoorStatus: '',
    conditionRight: '',
    conditionLeft: '',
    conditionBack: '',
    conditionAround: '',
    statusValue: 0,
    statusDescription: '',
    notes: '',
  );
}