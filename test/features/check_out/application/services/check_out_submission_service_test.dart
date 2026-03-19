import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_out/application/providers/check_out_di_provider.dart';
import 'package:patroli/features/check_out/application/services/check_out_submission_service.dart';
import 'package:patroli/features/check_out/domain/entities/check_out_entity.dart';
import 'package:patroli/features/check_out/domain/usecases/check_out_use_case.dart';

class MockCreateCheckOutUseCase extends Mock implements CreateCheckOutUseCase {}

class FakeCreateCheckOutParams extends Fake implements CreateCheckOutParams {}

void main() {
  late MockCreateCheckOutUseCase mockCreateCheckOutUseCase;
  late ProviderContainer container;

  final checkOutEntity = CheckOutEntity.empty();

  setUpAll(() {
    registerFallbackValue(FakeCreateCheckOutParams());
  });

  setUp(() {
    mockCreateCheckOutUseCase = MockCreateCheckOutUseCase();
    container = ProviderContainer(
      overrides: [
        checkOutUseCaseProvider.overrideWithValue(mockCreateCheckOutUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('submit returns success when use case succeeds', () async {
    when(
      () => mockCreateCheckOutUseCase(any()),
    ).thenAnswer((_) async => Right(checkOutEntity));

    final result = await container
        .read(checkOutSubmissionServiceProvider)
        .submit(branchId: 10, reportId: 20, imageUrl: 'https://cdn/file.jpg');

    expect(result, isA<Success<void>>());
    verify(() => mockCreateCheckOutUseCase(any())).called(1);
  });

  test('submit returns error when use case fails', () async {
    const failure = ServerFailure(message: 'Check out gagal');
    when(
      () => mockCreateCheckOutUseCase(any()),
    ).thenAnswer((_) async => const Left(failure));

    final result = await container
        .read(checkOutSubmissionServiceProvider)
        .submit(branchId: 10, reportId: 20, imageUrl: 'https://cdn/file.jpg');

    expect(result, isA<Error<void>>());
    expect((result as Error<void>).message, failure.message);
    verify(() => mockCreateCheckOutUseCase(any())).called(1);
  });
}
