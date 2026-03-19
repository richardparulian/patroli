import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/constants/app_metadata.dart';
import 'package:patroli/app/updates/update_info_source.dart';
import 'package:patroli/core/updates/update_service.dart';

final updateServiceProvider = Provider<UpdateService>((ref) {
  final updateInfoSource = ref.watch(appUpdateInfoSourceProvider);
  return BasicUpdateService(
    androidPackageName: AppMetadata.packageName,
    iOSAppId: AppMetadata.iOSAppId,
    updateInfoResolver: updateInfoSource.getUpdateInfo,
  );
});

class UpdateController extends AsyncNotifier<UpdateCheckResult> {
  @override
  Future<UpdateCheckResult> build() async {
    final updateService = ref.watch(updateServiceProvider);
    await updateService.init();
    return await updateService.checkForUpdates();
  }

  Future<void> checkForUpdates() async {
    state = const AsyncValue.loading();

    try {
      final updateService = ref.read(updateServiceProvider);
      final result = await updateService.checkForUpdates();
      state = AsyncValue.data(result);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<bool> promptForUpdate({bool force = false}) async {
    final updateService = ref.read(updateServiceProvider);
    return await updateService.promptUpdate(force: force);
  }

  Future<bool> openUpdateUrl() async {
    final updateService = ref.read(updateServiceProvider);
    return await updateService.openUpdateUrl();
  }

  Future<UpdateInfo?> getUpdateInfo() async {
    final updateService = ref.read(updateServiceProvider);
    return await updateService.getUpdateInfo();
  }
}

final updateControllerProvider =
    AsyncNotifierProvider<UpdateController, UpdateCheckResult>(
      UpdateController.new,
    );
