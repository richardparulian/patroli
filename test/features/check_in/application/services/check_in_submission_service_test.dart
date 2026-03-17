import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_in/application/providers/check_in_di_provider.dart';
import 'package:patroli/features/check_in/application/services/check_in_submission_service.dart';
import 'package:patroli/features/check_in/domain/entities/check_in_entity.dart';
import 'package:patroli/features/check_in/domain/usecases/check_in_use_case.dart';

class MockCreateCheckInUseCase extends Mock implements CreateCheckInUseCase {}

class FakeCreateCheckInParams extends Fake implements CreateCheckInParams {}

void main() {
  late MockCreateCheckInUseCase mockCreateCheckInUseCase;
  late ProviderContainer container;

  const entity = CheckInEntity(id: 1);

  setUpAll(() {
    registerFallbackValue(FakeCreateCheckInParams());
  });

  setUp(() {
    mockCreateCheckInUseCase = MockCreateCheckInUseCase();
    container = ProviderContainer(
      overrides: [
        checkInUseCaseProvider.overrideWithValue(mockCreateCheckInUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('submit returns success when use case succeeds', () async {
    when(() => mockCreateCheckInUseCase(any()))
        .thenAnswer((_) async => const Right(entity));

    final result = await container.read(checkInSubmissionServiceProvider).submit(
          branchId: 10,
          imageUrl: 'https://file.jpg',
        );

    expect(result, isA<Success<CheckInEntity>>());
    expect((result as Success<CheckInEntity>).data, entity);
    verify(() => mockCreateCheckInUseCase(any())).called(1);
  });

  test('submit returns error when use case fails', () async {
    const failure = InputFailure(message: 'Cabang tidak ditemukan');
    when(() => mockCreateCheckInUseCase(any()))
        .thenAnswer((_) async => const Left(failure));

    final result = await container.read(checkInSubmissionServiceProvider).submit(
          branchId: 0,
          imageUrl: 'https://file.jpg',
        );

    expect(result, isA<Error<CheckInEntity>>());
    expect((result as Error<CheckInEntity>).message, failure.message);
    verify(() => mockCreateCheckInUseCase(any())).called(1);
  });
}
