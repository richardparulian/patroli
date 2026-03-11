import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:pos/features/reports/domain/usecases/get_reportss_use_case.dart';
import 'package:pos/features/reports/domain/usecases/get_reports_by_id_use_case.dart';

final getReportssUseCaseProvider = Provider<GetReportssUseCase>((ref) {
  return GetReportssUseCase(ref.watch(reportsRepositoryProvider));
});

final getReportsByIdUseCaseProvider = Provider<GetReportsByIdUseCase>((ref) {
  return GetReportsByIdUseCase(ref.watch(reportsRepositoryProvider));
});
