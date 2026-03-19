import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/app/analytics/analytics_providers.dart';
import 'package:patroli/app/auth/biometric_providers.dart';
import 'package:patroli/core/auth/biometric_service.dart';

class MockBiometricService extends Mock implements BiometricService {}

void main() {
  late MockBiometricService mockBiometricService;
  late ProviderContainer container;

  setUp(() {
    mockBiometricService = MockBiometricService();
    container = ProviderContainer(
      overrides: [
        biometricServiceProvider.overrideWithValue(mockBiometricService),
        analyticsProvider.overrideWithValue(Analytics(DebugAnalyticsService())),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('authenticate sets authenticated state on success', () async {
    when(
      () => mockBiometricService.authenticate(
        localizedReason: 'Auth',
        reason: AuthReason.appAccess,
        sensitiveTransaction: false,
        dialogTitle: null,
        cancelButtonText: null,
      ),
    ).thenAnswer((_) async => BiometricResult.success);

    final result = await container
        .read(biometricAuthControllerProvider.notifier)
        .authenticate(reason: 'Auth');

    final state = container.read(biometricAuthControllerProvider);
    expect(result, BiometricResult.success);
    expect(state.isAuthenticating, isFalse);
    expect(state.isAuthenticated, isTrue);
    expect(state.lastResult, BiometricResult.success);
    expect(state.lastAuthTime, isNotNull);
  });

  test('authenticate clears loading flag when authentication fails', () async {
    when(
      () => mockBiometricService.authenticate(
        localizedReason: 'Auth',
        reason: AuthReason.appAccess,
        sensitiveTransaction: false,
        dialogTitle: null,
        cancelButtonText: null,
      ),
    ).thenAnswer((_) async => BiometricResult.failed);

    final future = container
        .read(biometricAuthControllerProvider.notifier)
        .authenticate(reason: 'Auth');

    expect(
      container.read(biometricAuthControllerProvider).isAuthenticating,
      isTrue,
    );

    await future;

    final state = container.read(biometricAuthControllerProvider);
    expect(state.isAuthenticating, isFalse);
    expect(state.isAuthenticated, isFalse);
    expect(state.lastResult, BiometricResult.failed);
  });

  test('logout resets biometric auth state', () {
    final notifier = container.read(biometricAuthControllerProvider.notifier);
    notifier.logout();

    final state = container.read(biometricAuthControllerProvider);
    expect(state.isAuthenticating, isFalse);
    expect(state.isAuthenticated, isFalse);
    expect(state.lastResult, isNull);
    expect(state.lastAuthTime, isNull);
  });

  test('isAuthenticationNeeded invalidates expired session', () {
    final controller = container.read(biometricAuthControllerProvider.notifier);
    controller.state = BiometricAuthState(
      isAuthenticated: true,
      lastResult: BiometricResult.success,
      lastAuthTime: DateTime.now().subtract(const Duration(minutes: 10)),
    );

    final needsAuth = controller.isAuthenticationNeeded(
      timeout: const Duration(minutes: 5),
    );

    expect(needsAuth, isTrue);
    expect(
      container.read(biometricAuthControllerProvider).isAuthenticated,
      isFalse,
    );
  });
}
