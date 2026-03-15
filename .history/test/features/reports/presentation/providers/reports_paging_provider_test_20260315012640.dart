import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_paging_provider.dart';
import 'package:pos/features/reports/providers/reports_di_provider.dart';

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

    await controller.fetchNextPage();

    expect(controller.items, reports);
    expect(controller.error, isNull);
    verify(() => mockReportsUseCase(any())).called(1);
  });
}
