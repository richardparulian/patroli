import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/auth/application/providers/auth_bootstrap_provider.dart';
import 'package:pos/features/auth/application/providers/auth_di_provider.dart';
import 'package:pos/features/auth/application/providers/auth_session_provider.dart';
import 'package:pos/features/auth/domain/usecases/login_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_login_provider.g.dart';

@riverpod
class AuthLogin extends _$AuthLogin {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  Future<void> runLogin({required String username, required String password}) async {
    state = const Loading();

    final loginUseCase = ref.read(loginUseCaseProvider);

    final result = await loginUseCase(
      LoginParams(
        username: username,
        password: password,
      ),
    );

    result.fold(
      (failure) => state = Error(failure.message),
      (response) {
        ref.read(authSessionProvider.notifier).setUser(response);
        ref.invalidate(authBootstrapProvider);
        state = const Success(null);
      },
    );
  }
}