import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/providers/storage_providers.dart';
import 'package:patroli/core/storage/local_storage_service.dart';
import 'package:patroli/core/storage/secure_storage_service.dart';
import 'package:patroli/core/storage/storage_keys.dart';
import 'package:patroli/features/auth/application/providers/auth_session_provider.dart';
import 'package:patroli/features/auth/application/services/auth_session_sync_provider.dart';
import 'package:patroli/features/auth/domain/entities/user_entity.dart';

class MockLocalStorageService extends Mock implements LocalStorageService {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

const _testUser = UserEntity(
  id: 1,
  ssoId: 1,
  name: 'John Doe',
  username: 'john.doe',
  role: 1,
  shouldChangePassword: false,
);

void main() {
  late MockLocalStorageService mockLocalStorageService;
  late MockSecureStorageService mockSecureStorageService;
  late ProviderContainer container;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    mockSecureStorageService = MockSecureStorageService();

    when(
      () => mockLocalStorageService.remove(StorageKeys.userData),
    ).thenAnswer((_) async => true);
    when(
      () => mockSecureStorageService.delete(key: StorageKeys.token),
    ).thenAnswer((_) async {});

    container = ProviderContainer(
      overrides: [
        localStorageServiceProvider.overrideWithValue(mockLocalStorageService),
        secureStorageServiceProvider.overrideWithValue(
          mockSecureStorageService,
        ),
      ],
    );
    container.read(authSessionProvider.notifier).setUser(_testUser);
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'forceLogout clears auth session without showing notice by default',
    () async {
      await container.read(authSessionSyncServiceProvider).forceLogout();

      expect(container.read(authSessionProvider), isNull);
      expect(container.read(authLogoutNoticeProvider), isNull);
      verify(
        () => mockLocalStorageService.remove(StorageKeys.userData),
      ).called(1);
      verify(
        () => mockSecureStorageService.delete(key: StorageKeys.token),
      ).called(1);
    },
  );

  test('forceLogout stores session expired notice when requested', () async {
    await container
        .read(authSessionSyncServiceProvider)
        .forceLogout(notice: AuthLogoutNotice.sessionExpired);

    expect(container.read(authSessionProvider), isNull);
    expect(
      container.read(authLogoutNoticeProvider),
      AuthLogoutNotice.sessionExpired,
    );
  });
}
