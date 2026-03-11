import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:pos/features/reports/domain/usecases/pending_use_case.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';

final reportsUseCaseProvider = Provider<ReportsUseCase>((ref) {
  return ReportsUseCase(ref.watch(reportsRepositoryProvider));
});

final pendingUseCaseProvider = Provider<PendingUseCase>((ref) {
  return PendingUseCase(ref.watch(reportsRepositoryProvider));
});
