import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/auth/application/providers/auth_di_provider.dart';
import 'package:patroli/features/auth/application/services/auth_session_sync_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_logout_service.g.dart';

class AuthLogoutService {
  AuthLogoutService(this.ref);

  final Ref ref;

  Future<ResultState<void>> logout() async {
    final logoutUseCase = ref.read(logoutUseCaseProvider);
    final authSessionSyncService = ref.read(authSessionSyncServiceProvider);
    final result = await logoutUseCase(NoParams());

    return await result.fold(
      (failure) async => Error<void>(failure.message),
      (_) async {
        await authSessionSyncService.forceLogout();
        return const Success<void>(null);
      },
    );
  }
}

@riverpod
AuthLogoutService authLogoutService(Ref ref) {
  return AuthLogoutService(ref);
}
