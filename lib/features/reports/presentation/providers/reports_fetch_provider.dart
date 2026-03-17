import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/application/services/reports_fetch_service.dart';
import 'package:patroli/features/reports/presentation/providers/reports_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reports_fetch_provider.g.dart';

@riverpod
class ReportsFetch extends _$ReportsFetch {
  @override
  ReportsState build() {
    return const ReportsState();
  }

  void clear() {
    state = const ReportsState();
  }

  Future<List<ReportsEntity>> getReports({int? page, int? limit, int? pagination}) async {
    final reportsFetchService = ref.read(reportsFetchServiceProvider);

    try {
      final response = await reportsFetchService.fetch(
        page: page,
        limit: limit,
        pagination: pagination,
      );
      state = state.copyWith(errorMessage: null);
      return response;
    } on ReportsFetchException catch (e) {
      state = state.copyWith(errorMessage: e.message);
      throw ReportsPagingException(e.message);
    }
  }
}

class ReportsPagingException implements Exception {
  ReportsPagingException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}