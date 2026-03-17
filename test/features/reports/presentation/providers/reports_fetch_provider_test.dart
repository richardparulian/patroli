import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/reports/application/providers/reports_di_provider.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/domain/usecases/reports_use_case.dart';
import 'package:patroli/features/reports/presentation/providers/reports_fetch_provider.dart';

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

  test('getReports clears error and returns reports on success', () async {
    const reports = [
      ReportsEntity(id: 1, statusValue: 1),
      ReportsEntity(id: 2, statusValue: 2),
    ];

    when(() => mockReportsUseCase(any()))
        .thenAnswer((_) async => const Right(reports));

    final result = await container.read(reportsFetchProvider.notifier).getReports(
          page: 1,
          limit: 5,
          pagination: 1,
        );

    expect(result, reports);
    expect(container.read(reportsFetchProvider).errorMessage, isNull);
    verify(() => mockReportsUseCase(any())).called(1);
  });

  test('getReports sets error state and throws typed exception on failure', () async {
    const failure = ServerFailure(message: 'Fetch reports failed');
    when(() => mockReportsUseCase(any()))
        .thenAnswer((_) async => const Left(failure));

    final subscription = container.listen(
      reportsFetchProvider,
      (previous, next) {},
      fireImmediately: true,
    );

    await expectLater(
      container.read(reportsFetchProvider.notifier).getReports(
            page: 1,
            limit: 5,
            pagination: 1,
          ),
      throwsA(
        isA<ReportsPagingException>()
            .having((e) => e.message, 'message', failure.message),
      ),
    );

    expect(container.read(reportsFetchProvider).errorMessage, failure.message);
    verify(() => mockReportsUseCase(any())).called(1);
    subscription.close();
  });
}
