// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:pos/features/reports/domain/entities/reports_entity.dart';
// import 'reports_fetch_provider.dart'; // provider untuk fetch reports

// /// Provider untuk PagingController
// final reportPagingProvider = Provider<PagingController<int, ReportsEntity>>((ref) {
//   final pagingController = PagingController<int, ReportsEntity>(
//     getNextPageKey: (state) {
//       return state.lastPageIsEmpty ? null : state.nextIntPageKey;
//     },
//     fetchPage: (pageKey) async {
//       final notifier = ref.read(reportsFetchProvider.notifier);
//       final reports = await notifier.getReports(
//         page: pageKey,
//         limit: 5,
//         pagination: 1,
//       );
//       return reports;
//     },
//   );

//   // Opsional: kalau perlu dispose controller saat provider di-unwatch
//   ref.onDispose(() => pagingController.dispose());

//   return pagingController;
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';

final reportPagingProvider = Provider.autoDispose((ref) => PagingController<int, ReportsEntity>(
  getNextPageKey: (state) =>
      state.lastPageIsEmpty ? null : state.nextIntPageKey,
  fetchPage: (pageKey) async {
    final reportsUseCase = ref.read(reportsUseCaseProvider);

    final result = await reportsUseCase(
      ReportsParams(page: pageKey, limit: 5, pagination: 1),
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (reports) => reports,
    );
  },
));