import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:patroli/features/auth/domain/entities/user_entity.dart';
import 'package:patroli/features/auth/domain/repositories/auth_repository.dart';
import 'package:patroli/features/auth/application/providers/auth_bootstrap_provider.dart';
import 'package:patroli/features/auth/application/providers/auth_session_provider.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late ProviderContainer container;

  const user = UserEntity(
    id: 1,
    ssoId: 1,
    username: '12345',
    name: 'Test User',
    role: 1,
    shouldChangePassword: false,
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('authBootstrap sets authSession when authenticated and current user exists', () async {
    when(() => mockAuthRepository.isAuthenticated())
        .thenAnswer((_) async => const Right(true));
    when(() => mockAuthRepository.getCurrentUser())
        .thenAnswer((_) async => const Right(user));

    final result = await container.read(authBootstrapProvider.future);

    expect(result, isTrue);
    expect(container.read(authSessionProvider), user);
    verify(() => mockAuthRepository.isAuthenticated()).called(1);
    verify(() => mockAuthRepository.getCurrentUser()).called(1);
  });

  test('authBootstrap clears authSession when user is not authenticated', () async {
    container.read(authSessionProvider.notifier).setUser(user);

    when(() => mockAuthRepository.isAuthenticated())
        .thenAnswer((_) async => const Right(false));

    final result = await container.read(authBootstrapProvider.future);

    expect(result, isFalse);
    expect(container.read(authSessionProvider), isNull);
    verify(() => mockAuthRepository.isAuthenticated()).called(1);
    verifyNever(() => mockAuthRepository.getCurrentUser());
  });

  test('authBootstrap clears authSession when current user fetch fails', () async {
    container.read(authSessionProvider.notifier).setUser(user);

    when(() => mockAuthRepository.isAuthenticated())
        .thenAnswer((_) async => const Right(true));
    when(() => mockAuthRepository.getCurrentUser())
        .thenAnswer((_) async => const Left(ServerFailure(message: 'No user')));

    final result = await container.read(authBootstrapProvider.future);

    expect(result, isFalse);
    expect(container.read(authSessionProvider), isNull);
    verify(() => mockAuthRepository.isAuthenticated()).called(1);
    verify(() => mockAuthRepository.getCurrentUser()).called(1);
  });
}
