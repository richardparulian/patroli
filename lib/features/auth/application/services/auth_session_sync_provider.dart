import 'package:patroli/core/providers/storage_providers.dart';
import 'package:patroli/core/storage/storage_keys.dart';
import 'package:patroli/features/auth/application/providers/auth_bootstrap_provider.dart';
import 'package:patroli/features/auth/application/providers/auth_session_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_sync_provider.g.dart';

enum AuthLogoutNotice { sessionExpired }

class AuthLogoutNoticeNotifier extends Notifier<AuthLogoutNotice?> {
  @override
  AuthLogoutNotice? build() => null;

  void show(AuthLogoutNotice notice) {
    if (state == null) {
      state = notice;
    }
  }

  void clear() {
    state = null;
  }
}

final authLogoutNoticeProvider =
    NotifierProvider<AuthLogoutNoticeNotifier, AuthLogoutNotice?>(
      AuthLogoutNoticeNotifier.new,
    );

class AuthSessionSyncService {
  AuthSessionSyncService(this.ref);

  final Ref ref;

  Future<void> forceLogout({AuthLogoutNotice? notice}) async {
    final localStorageService = ref.read(localStorageServiceProvider);
    final secureStorageService = ref.read(secureStorageServiceProvider);
    final authSessionNotifier = ref.read(authSessionProvider.notifier);

    if (notice != null) {
      ref.read(authLogoutNoticeProvider.notifier).show(notice);
    }

    try {
      await localStorageService.remove(StorageKeys.userData);
    } catch (_) {}

    try {
      await secureStorageService.delete(key: StorageKeys.token);
    } catch (_) {}

    authSessionNotifier.clear();

    if (ref.mounted) {
      ref.invalidate(authBootstrapProvider);
    }
  }
}

@Riverpod(keepAlive: true)
AuthSessionSyncService authSessionSyncService(Ref ref) {
  return AuthSessionSyncService(ref);
}
