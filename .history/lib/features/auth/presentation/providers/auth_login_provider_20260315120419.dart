import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/auth/application/services/auth_login_service.dart';
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
    state = await ref.read(authLoginServiceProvider).login(
      username: username,
      password: password,
    );
  }
}