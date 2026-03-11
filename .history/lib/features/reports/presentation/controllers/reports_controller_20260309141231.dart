import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';

class ReportsController extends AsyncNotifier<List<ReportsEntity>?> {
  @override
  Future<List<ReportsEntity>?> build() async => null;

  Future<void> getReports({int? page, int? limit, int? pagination}) async {
    state = const AsyncLoading();

    final reportsUseCase = ref.read(reportsUseCaseProvider);

    final result = await reportsUseCase(
      ReportsParams(
        page: page ?? 1, 
        limit: limit ?? 10, 
      ),
    );

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (response) => state = AsyncData(response),
    );
  }       
}

final reportsProvider = AsyncNotifierProvider<ReportsController, List<ReportsEntity>?>(ReportsController.new);