import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/auth/application/services/auth_login_service.dart';
import 'package:patroli/features/auth/presentation/providers/login_flow_provider.dart';

class MockAuthLoginService extends Mock implements AuthLoginService {}

void main() {
  late MockAuthLoginService mockAuthLoginService;
  late ProviderContainer container;

  setUp(() {
    mockAuthLoginService = MockAuthLoginService();
    container = ProviderContainer(
      overrides: [
        authLoginServiceProvider.overrideWithValue(mockAuthLoginService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('togglePasswordVisibility updates state', () {
    final notifier = container.read(loginFlowProvider.notifier);

    notifier.togglePasswordVisibility();
    expect(container.read(loginFlowProvider).isPasswordVisible, isTrue);

    notifier.togglePasswordVisibility();
    expect(container.read(loginFlowProvider).isPasswordVisible, isFalse);
  });

  test('submit updates state with service result', () async {
    when(
      () => mockAuthLoginService.login(username: '123', password: 'secret'),
    ).thenAnswer((_) async => const Success(null));

    final result = await container
        .read(loginFlowProvider.notifier)
        .submit(username: '123', password: 'secret');

    expect(result, isA<Success<void>>());
    expect(
      container.read(loginFlowProvider).submissionState,
      isA<Success<void>>(),
    );
    verify(
      () => mockAuthLoginService.login(username: '123', password: 'secret'),
    ).called(1);
  });

  test('clearError resets error state to idle', () async {
    when(
      () => mockAuthLoginService.login(username: '123', password: 'bad'),
    ).thenAnswer((_) async => const Error('Login gagal'));

    await container
        .read(loginFlowProvider.notifier)
        .submit(username: '123', password: 'bad');

    expect(container.read(loginFlowProvider).errorMessage, 'Login gagal');

    container.read(loginFlowProvider.notifier).clearError();

    final state = container.read(loginFlowProvider);
    expect(state.errorMessage, isNull);
    expect(state.submissionState, isA<Idle<void>>());
  });
}
