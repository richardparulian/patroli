import 'package:pos/features/reports/domain/entities/reports_entity.dart';

extension ReportValidation on ReportsEntity {
  bool get isEmptyReport {
    return [
      lightsStatus,
      bannerStatus,
      rollingDoorStatus,
      conditionRight,
      conditionLeft,
      conditionBack,
      conditionAround,
    ].every((e) => e == null || e.trim().isEmpty);
  }
}