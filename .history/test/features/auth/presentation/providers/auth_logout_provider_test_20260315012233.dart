import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/auth/domain/usecases/logout_use_case.dart';
import 'package:pos/features/auth/presentation/providers/auth_logout_provider.dart';
import 'package:pos/features/auth/providers/auth_di_provider.dart';
import 'package:pos/features/auth/providers/auth_session_sync_provider.dart';

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

class MockAuthSessionSyncService extends Mock implements AuthSessionSyncService {}

void main() {
  late MockLogoutUseCase mockLogoutUseCase;
  late MockAuthSessionSyncService mockAuthSessionSyncService;
  late ProviderContainer container;

  setUp(() {
    mockLogoutUseCase = MockLogoutUseCase();
    mockAuthSessionSyncService = MockAuthSessionSyncService();

    container = ProviderContainer(
      overrides: [
        logoutUseCaseProvider.overrideWithValue(mockLogoutUseCase),
        authSessionSyncServiceProvider.overrideWithValue(mockAuthSessionSyncService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('runLogout calls auth session sync service when logout succeeds', () async {
    when(() => mockLogoutUseCase(any()))
        .thenAnswer((_) async => const Right(null));
    when(() => mockAuthSessionSyncService.forceLogout())
        .thenAnswer((_) async {});

    await container.read(authLogoutProvider.notifier).runLogout();

    expect(container.read(authLogoutProvider), isA<Success<void>>());
    verify(() => mockLogoutUseCase(any())).called(1);
    verify(() => mockAuthSessionSyncService.forceLogout()).called(1);
  });

  test('runLogout returns error state and does not clear session when logout fails', () async {
    const failure = ServerFailure(message: 'Logout failed');
    when(() => mockLogoutUseCase(any()))
        .thenAnswer((_) async => const Left(failure));

    await container.read(authLogoutProvider.notifier).runLogout();

    final state = container.read(authLogoutProvider);
    expect(state, isA<Error<void>>());
    expect((state as Error<void>).message, failure.message);
    verify(() => mockLogoutUseCase(any())).called(1);
    verifyNever(() => mockAuthSessionSyncService.forceLogout());
  });
}
