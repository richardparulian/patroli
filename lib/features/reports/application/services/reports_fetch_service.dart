import 'package:patroli/app/localization/localized_message.dart';
import 'package:patroli/features/reports/application/providers/reports_di_provider.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/domain/usecases/reports_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_fetch_service.g.dart';

class ReportsFetchService {
  ReportsFetchService(this.ref);

  final Ref ref;

  Future<List<ReportsEntity>> fetch({int? page, int? limit, int? pagination}) async {
    final reportsUseCase = ref.read(reportsUseCaseProvider);

    final result = await reportsUseCase(
      ReportsParams(
        page: page,
        limit: limit,
        pagination: pagination,
      ),
    );

    return result.fold(
      (failure) => throw ReportsFetchException(localizeMessage(ref, failure.message)),
      (response) => response,
    );
  }
}

class ReportsFetchException implements Exception {
  ReportsFetchException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

@riverpod
ReportsFetchService reportsFetchService(Ref ref) {
  return ReportsFetchService(ref);
}
