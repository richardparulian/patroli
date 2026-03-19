import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patroli/app/updates/update_providers.dart';
import 'package:patroli/core/updates/update_service.dart';

class FakeUpdateService implements UpdateService {
  FakeUpdateService({
    this.checkResult = UpdateCheckResult.upToDate,
    this.updateInfo,
  });

  final UpdateCheckResult checkResult;
  final UpdateInfo? updateInfo;
  bool initialized = false;
  bool promptCalled = false;
  bool openCalled = false;

  @override
  Future<UpdateCheckResult> checkForUpdates() async => checkResult;

  @override
  Future<UpdateInfo?> getUpdateInfo() async => updateInfo;

  @override
  Future<void> init() async {
    initialized = true;
  }

  @override
  bool isCriticalUpdate(String currentVersion, String minimumRequired) => false;

  @override
  bool isUpdateNeeded(String currentVersion, String latestVersion) => false;

  @override
  Future<bool> openUpdateUrl() async {
    openCalled = true;
    return true;
  }

  @override
  Future<bool> promptUpdate({bool force = false}) async {
    promptCalled = true;
    return true;
  }
}

void main() {
  test(
    'update controller build initializes service and loads status',
    () async {
      final service = FakeUpdateService(
        checkResult: UpdateCheckResult.upToDate,
      );
      final container = ProviderContainer(
        overrides: [updateServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);

      final result = await container.read(updateControllerProvider.future);

      expect(service.initialized, isTrue);
      expect(result, UpdateCheckResult.upToDate);
    },
  );

  test('checkForUpdates refreshes controller state', () async {
    final service = FakeUpdateService(
      checkResult: UpdateCheckResult.updateAvailable,
    );
    final container = ProviderContainer(
      overrides: [updateServiceProvider.overrideWithValue(service)],
    );
    addTearDown(container.dispose);

    await container.read(updateControllerProvider.future);
    await container.read(updateControllerProvider.notifier).checkForUpdates();

    final state = container.read(updateControllerProvider);
    expect(state.value, UpdateCheckResult.updateAvailable);
  });

  test(
    'controller delegates prompt and open actions to update service',
    () async {
      final service = FakeUpdateService(
        updateInfo: const UpdateInfo(
          latestVersion: '2.0.0',
          minimumRequiredVersion: '1.0.0',
          isCritical: false,
        ),
      );
      final container = ProviderContainer(
        overrides: [updateServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(updateControllerProvider.notifier);
      await notifier.promptForUpdate();
      await notifier.openUpdateUrl();

      expect(service.promptCalled, isTrue);
      expect(service.openCalled, isTrue);
    },
  );
}
