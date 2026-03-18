import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/app/localization/localized_message.dart';
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
    final sessionNotifier = ref.read(authSessionProvider.notifier);

    final result = await loginUseCase(
      LoginParams(
        username: username,
        password: password,
      ),
    );

    return result.fold(
      (failure) => Error(localizeMessage(ref, failure.message)),
      (response) {
        sessionNotifier.setUser(response);
        if (ref.mounted) {
          ref.invalidate(authBootstrapProvider);
        }
        return const Success(null);
      },
    );
  }
}

@Riverpod(keepAlive: true)
AuthLoginService authLoginService(Ref ref) {
  return AuthLoginService(ref);
}
