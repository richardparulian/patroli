import 'package:pos/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_di_provider.g.dart';

@riverpod
ReportsUseCase reportsUseCase(Ref ref) {
  return ReportsUseCase(ref.watch(reportsRepositoryProvider));
}
