import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/visits/application/providers/visit_di_provider.dart';
import 'package:pos/features/visits/application/services/visit_create_service.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/domain/entities/visit_entity.dart';
import 'package:pos/features/visits/domain/usecases/visit_use_case.dart';

class MockCreateVisitUseCase extends Mock implements CreateVisitUseCase {}

class FakeCreateVisitParams extends Fake implements CreateVisitParams {}

void main() {
  late MockCreateVisitUseCase mockCreateVisitUseCase;
  late ProviderContainer container;

  const request = VisitRequest(
    lightsStatus: 'on',
    bannerStatus: 'good',
    rollingDoorStatus: 'closed',
    conditionRight: 'good',
    conditionLeft: 'good',
    conditionBack: 'good',
    conditionAround: 'good',
    notes: 'ok',
  );
  final entity = VisitEntity.empty();

  setUpAll(() {
    registerFallbackValue(FakeCreateVisitParams());
  });

  setUp(() {
    mockCreateVisitUseCase = MockCreateVisitUseCase();
    container = ProviderContainer(
      overrides: [
        visitUseCaseProvider.overrideWithValue(mockCreateVisitUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('submit returns success when use case succeeds', () async {
    when(() => mockCreateVisitUseCase(any()))
        .thenAnswer((_) async => Right(entity));

    final result = await container.read(visitCreateServiceProvider).submit(
          request: request,
          reportId: 1,
        );

    expect(result, isA<Success<VisitEntity>>());
    expect((result as Success<VisitEntity>).data, entity);
    verify(() => mockCreateVisitUseCase(any())).called(1);
  });

  test('submit returns error when use case fails', () async {
    const failure = ServerFailure(message: 'Visit gagal');
    when(() => mockCreateVisitUseCase(any()))
        .thenAnswer((_) async => const Left(failure));

    final result = await container.read(visitCreateServiceProvider).submit(
          request: request,
          reportId: 1,
        );

    expect(result, isA<Error<VisitEntity>>());
    expect((result as Error<VisitEntity>).message, failure.message);
    verify(() => mockCreateVisitUseCase(any())).called(1);
  });
}
