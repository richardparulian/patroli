import 'package:patroli/core/providers/storage_providers.dart';
import 'package:patroli/core/storage/storage_keys.dart';
import 'package:patroli/features/auth/application/providers/auth_bootstrap_provider.dart';
import 'package:patroli/features/auth/application/providers/auth_session_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_sync_provider.g.dart';

class AuthSessionSyncService {
  AuthSessionSyncService(this.ref);

  final Ref ref;

  Future<void> forceLogout() async {
    final localStorageService = ref.read(localStorageServiceProvider);
    final secureStorageService = ref.read(secureStorageServiceProvider);

    try {
      await localStorageService.remove(StorageKeys.userData);
    } catch (_) {}

    try {
      await secureStorageService.delete(key: StorageKeys.token);
    } catch (_) {}

    ref.read(authSessionProvider.notifier).clear();
    ref.invalidate(authBootstrapProvider);
  }
}

@riverpod
AuthSessionSyncService authSessionSyncService(Ref ref) {
  return AuthSessionSyncService(ref);
}
