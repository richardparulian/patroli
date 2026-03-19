import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/features/reports/application/services/reports_fetch_service.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/presentation/providers/reports_flow_provider.dart';

class MockReportsFetchService extends Mock implements ReportsFetchService {}

void main() {
  late MockReportsFetchService mockReportsFetchService;
  late ProviderContainer container;

  setUp(() {
    mockReportsFetchService = MockReportsFetchService();
    container = ProviderContainer(
      overrides: [
        reportsFetchServiceProvider.overrideWithValue(mockReportsFetchService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'fetching first page clears error and stores items in paging controller',
    () async {
      const reports = [
        ReportsEntity(id: 1, statusValue: 1),
        ReportsEntity(id: 2, statusValue: 2),
      ];

      when(
        () => mockReportsFetchService.fetch(page: 1, limit: 5, pagination: 1),
      ).thenAnswer((_) async => reports);

      final flowState = container.read(reportsFlowProvider);
      flowState.pagingController.fetchNextPage();
      await Future<void>.delayed(Duration.zero);

      expect(flowState.pagingController.value.pages, [reports]);
      expect(container.read(reportsFlowProvider).errorMessage, isNull);
      verify(
        () => mockReportsFetchService.fetch(page: 1, limit: 5, pagination: 1),
      ).called(1);
    },
  );

  test('fetching first page stores error message when service fails', () async {
    const message = 'Fetch reports failed';

    when(
      () => mockReportsFetchService.fetch(page: 1, limit: 5, pagination: 1),
    ).thenThrow(ReportsFetchException(message));

    final subscription = container.listen(
      reportsFlowProvider,
      (previous, next) {},
      fireImmediately: true,
    );

    final flowState = container.read(reportsFlowProvider);
    flowState.pagingController.fetchNextPage();
    await Future<void>.delayed(Duration.zero);

    expect(container.read(reportsFlowProvider).errorMessage, message);
    expect(
      flowState.pagingController.value.error,
      isA<ReportsPagingException>(),
    );
    subscription.close();
  });
}
