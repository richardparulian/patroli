import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/reports/data/models/branch_model.dart';
import 'package:pos/features/reports/data/models/created_model.dart';
import 'package:pos/features/reports/domain/entities/branch_entity.dart';
import 'package:pos/features/reports/domain/entities/created_entity.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';

part 'reports_model.freezed.dart';
part 'reports_model.g.dart';

@freezed
abstract class ReportsModel with _$ReportsModel {
  const ReportsModel._();

  const factory ReportsModel({
    int? id,
    String? date,
    String? checkIn,
    String? checkOut,
    CreatedModel? createdBy,
    BranchModel? branch,
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
  }) = _ReportsModel;

  factory ReportsModel.fromJson(Map<String, dynamic> json) => _$ReportsModelFromJson(json);

  // :: Optional: fromEntity factory jika diperlukan
  factory ReportsModel.fromEntity(ReportsEntity entity) {
    return ReportsModel(
      id: entity.id,
      date: entity.date,
      checkIn: entity.checkIn,
      checkOut: entity.checkOut,
      createdBy: CreatedModel.fromEntity(entity.createdBy ?? CreatedEntity.empty()),  
      branch: BranchModel.fromEntity(entity.branch ?? BranchEntity.empty()),
      checkInPhoto: entity.checkInPhoto,
      checkOutPhoto: entity.checkOutPhoto,
      lightsStatus: entity.lightsStatus,
      bannerStatus: entity.bannerStatus,
      rollingDoorStatus: entity.rollingDoorStatus,
      conditionRight: entity.conditionRight,
      conditionLeft: entity.conditionLeft,
      conditionBack: entity.conditionBack,
      conditionAround: entity.conditionAround,
      statusValue: entity.statusValue,
      statusDescription: entity.statusDescription,
      notes: entity.notes,
    );
  }

  ReportsEntity toEntity() {
    return ReportsEntity(
      id: id,
      date: date,
      checkIn: checkIn,
      checkOut: checkOut,
      createdBy: createdBy.toEntity(),
      branch: branch.toEntity(),
      checkInPhoto: checkInPhoto,
      checkOutPhoto: checkOutPhoto,
      lightsStatus: lightsStatus,
      bannerStatus: bannerStatus,
      rollingDoorStatus: rollingDoorStatus,
      conditionRight: conditionRight,
      conditionLeft: conditionLeft,
      conditionBack: conditionBack,
      conditionAround: conditionAround,
      statusValue: statusValue,
      statusDescription: statusDescription,
      notes: notes,
    );
  }
}