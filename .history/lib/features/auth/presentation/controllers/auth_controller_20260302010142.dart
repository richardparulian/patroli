// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pos/core/usecases/usecase.dart';
// import 'package:pos/features/auth/domain/entities/user_entity.dart';
// import 'package:pos/features/auth/domain/usecases/login_use_case.dart';
// import 'package:pos/features/auth/presentation/providers/auth_di_provider.dart';

// class AuthController extends AsyncNotifier<UserEntity?> {
//   @override
//   Future<UserEntity?> build() async {
//     return null;
//   }

//   Future<void> login({required String username, required String password}) async {
//     state = const AsyncLoading();

//     final loginUseCase = ref.read(loginUseCaseProvider);

//     final result = await loginUseCase(
//       LoginParams(username: username, password: password),
//     );

//     state = result.fold(
//       (failure) => AsyncError(failure.message, StackTrace.current),
//       (user) => AsyncData(user),
//     );
//   }

//   Future<void> logout() async {
//     state = const AsyncLoading();

//     final logoutUseCase = ref.read(logoutUseCaseProvider);
//     await logoutUseCase(NoParams());

//     state = const AsyncData(null);
//   }
// }

// final authProvider = AsyncNotifierProvider<AuthController, UserEntity?>(AuthController.new);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/auth/domain/usecases/login_use_case.dart';
import 'package:pos/features/auth/presentation/providers/auth_di_provider.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';

class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncLoading();

    final loginUseCase = ref.read(loginUseCaseProvider);

    final result = await loginUseCase(
      LoginParams(username: username, password: password),
    );

    result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
      },
      (user) {
        // ✅ Update global session
        ref.read(authSessionProvider.notifier).state = user;
        state = const AsyncData(null);
      },
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();

    final logoutUseCase = ref.read(logoutUseCaseProvider);
    final result = await logoutUseCase(NoParams());

    result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
      },
      (_) {
        // ✅ Clear global session
        ref.read(authSessionProvider.notifier).clear();
        state = const AsyncData(null);
      },
    );
  }
}

final authActionProvider = AsyncNotifierProvider<AuthActionController, void>(AuthActionController.new);