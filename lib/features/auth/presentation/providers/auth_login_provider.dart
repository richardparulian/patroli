import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/auth/domain/usecases/login_use_case.dart';
import 'package:pos/features/auth/presentation/providers/auth_di_provider.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';

class AuthLoginNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> runLogin({required String username, required String password}) async {
    try {
      final loginUseCase = ref.read(loginUseCaseProvider);

      final result = await loginUseCase(LoginParams(
        username: username,
        password: password,
      ));

      result.fold(
        (failure) => state = Error(failure.message),
        (response) {
          ref.read(authSessionProvider.notifier).state = response;

          state = const Success(null);
        },
      );
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

final authLoginProvider = NotifierProvider<AuthLoginNotifier, ResultState<void>>(AuthLoginNotifier.new);