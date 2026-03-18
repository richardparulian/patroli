import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/auth/application/services/auth_logout_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_logout_provider.g.dart';

@riverpod
class AuthLogout extends _$AuthLogout {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  Future<ResultState<void>> runLogout() async {
    state = const Loading();

    final result = await ref.read(authLogoutServiceProvider).logout();
    if (!ref.mounted) return const Idle();

    state = result;
    return result;
  }
}