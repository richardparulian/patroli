import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/auth/application/providers/auth_bootstrap_provider.dart';
import 'package:patroli/features/auth/application/providers/auth_di_provider.dart';
import 'package:patroli/features/auth/application/providers/auth_session_provider.dart';
import 'package:patroli/features/auth/domain/usecases/login_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_login_service.g.dart';

class AuthLoginService {
  AuthLoginService(this.ref);

  final Ref ref;

  Future<ResultState<void>> login({
    required String username,
    required String password,
  }) async {
    final loginUseCase = ref.read(loginUseCaseProvider);

    final result = await loginUseCase(
      LoginParams(
        username: username,
        password: password,
      ),
    );

    return result.fold(
      (failure) => Error(failure.message),
      (response) {
        ref.read(authSessionProvider.notifier).setUser(response);
        ref.invalidate(authBootstrapProvider);
        return const Success(null);
      },
    );
  }
}

@riverpod
AuthLoginService authLoginService(Ref ref) {
  return AuthLoginService(ref);
}
