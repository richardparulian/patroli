import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/auth/application/providers/auth_di_provider.dart';
import 'package:pos/features/auth/application/services/auth_session_sync_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_logout_provider.g.dart';

@riverpod
class AuthLogout extends _$AuthLogout {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  Future<void> runLogout() async {
    state = const Loading();

    final logoutUseCase = ref.read(logoutUseCaseProvider);
    final authSessionSyncService = ref.read(authSessionSyncServiceProvider);
    final result = await logoutUseCase(NoParams());

    var isSuccess = false;
    result.fold(
      (failure) => state = Error(failure.message),
      (_) => isSuccess = true,
    );

    if (!isSuccess) {
      return;
    }

    await authSessionSyncService.forceLogout();
    state = const Success(null);
  }
}