import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/auth/presentation/providers/auth_di_provider.dart';

class AuthLogoutNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> logout() async {
    try {
      final logoutUseCase = ref.read(logoutUseCaseProvider);
      final result = await logoutUseCase(NoParams());

      result.fold(
        (failure) => state = Error(failure.message),
        (_) => state = const Success(null),
      );
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}