import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/domain/usecases/reports_use_case.dart';
import 'package:patroli/features/reports/presentation/providers/reports_count_provider.dart';
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

  test('fetchCount emits success with total and pending status count', () async {
    const reports = [
      ReportsEntity(id: 1, statusValue: 1),
      ReportsEntity(id: 2, statusValue: 1),
      ReportsEntity(id: 3, statusValue: 2),
    ];

    when(() => mockReportsUseCase(any()))
        .thenAnswer((_) async => const Right(reports));

    await container.read(countReportsProvider.notifier).fetchCount();

    final state = container.read(countReportsProvider);
    expect(state, isA<Success>());
    final success = state as Success;
    expect(success.data.total, 3);
    expect(success.data.byStatus, 2);
    verify(() => mockReportsUseCase(any())).called(1);
  });

  test('fetchCount emits error when reports use case fails', () async {
    const failure = ServerFailure(message: 'Count reports failed');
    when(() => mockReportsUseCase(any()))
        .thenAnswer((_) async => const Left(failure));

    await container.read(countReportsProvider.notifier).fetchCount();

    final state = container.read(countReportsProvider);
    expect(state, isA<Error>());
    expect((state as Error).message, failure.message);
    verify(() => mockReportsUseCase(any())).called(1);
  });
}
