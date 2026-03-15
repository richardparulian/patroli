import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:pos/features/auth/providers/auth_di_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_logout_provider.g.dart';

@riverpod
class AuthLogout extends _$AuthLogout {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> runLogout() async {
    setLoading();

    try {
      final logoutUseCase = ref.read(logoutUseCaseProvider);
      final result = await logoutUseCase(NoParams());

      result.fold(
        (failure) => state = Error(failure.message),
        (_) {
          ref.read(authSessionProvider.notifier).clear();
          state = const Success(null);
        },
      );
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}