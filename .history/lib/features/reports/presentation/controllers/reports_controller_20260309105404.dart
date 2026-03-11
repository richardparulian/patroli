import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/usecases/get_reportss_use_case.dart';
import 'package:pos/features/reports/domain/usecases/get_reports_by_id_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';

class ReportsController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  // :: Fetch all reportss
  Future<Either<String, List<ReportsEntity>>> fetchReportss() async {
    final useCase = ref.read(getReportssUseCaseProvider);

    final result = await useCase(NoParams());

    return result.fold(
      (failure) => Left(failure.message),
      (entities) => Right(entities),
    );
  }

  // :: Fetch reports by ID
  Future<Either<String, ReportsEntity>> fetchReportsById(int id) async {
    final useCase = ref.read(getReportsByIdUseCaseProvider);

    final result = await useCase(GetReportsByIdParams(id: id));

    return result.fold(
      (failure) => Left(failure.message),
      (entity) => Right(entity),
    );
  }
}

final reportsControllerProvider =
    AsyncNotifierProvider<ReportsController, void>(
        ReportsController.new);
