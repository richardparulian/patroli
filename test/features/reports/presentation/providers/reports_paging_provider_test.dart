import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/domain/usecases/reports_use_case.dart';
import 'package:patroli/features/reports/presentation/providers/reports_paging_provider.dart';
import 'package:patroli/features/reports/application/providers/reports_di_provider.dart';

class MockReportsUseCase extends Mock implements ReportsUseCase {}

class FakeReportsParams extends Fake implements ReportsParams {}

void main() {
  late MockReportsUseCase mockReportsUseCase;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(FakeReportsParams());
  });

  setUp(() {
    mockReportsUseCase = MockReportsUseCase();
    container = ProviderContainer(
      overrides: [
        reportsUseCaseProvider.overrideWithValue(mockReportsUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('reportPaging fetches first page and stores items in controller', () async {
    const reports = [
      ReportsEntity(id: 1, statusValue: 1),
      ReportsEntity(id: 2, statusValue: 2),
    ];

    when(() => mockReportsUseCase(any()))
        .thenAnswer((_) async => const Right(reports));

    final controller = container.read(reportPagingProvider);

    controller.fetchNextPage();
    await Future<void>.delayed(Duration.zero);

    expect(controller.value.items, reports);
    expect(controller.value.error, isNull);
    verify(() => mockReportsUseCase(any())).called(1);
  });
}
