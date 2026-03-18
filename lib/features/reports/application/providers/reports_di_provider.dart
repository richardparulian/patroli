import 'package:patroli/features/reports/application/providers/reports_data_providers.dart';
import 'package:patroli/features/reports/domain/usecases/reports_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_di_provider.g.dart';

@riverpod
ReportsUseCase reportsUseCase(Ref ref) {
  return ReportsUseCase(ref.watch(reportsRepositoryProvider));
}
