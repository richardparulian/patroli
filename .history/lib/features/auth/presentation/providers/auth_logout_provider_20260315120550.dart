import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/auth/application/services/auth_logout_service.dart';
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
    state = await ref.read(authLogoutServiceProvider).logout();
  }
}