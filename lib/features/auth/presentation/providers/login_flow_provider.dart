import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/auth/application/services/auth_login_service.dart';

class LoginFlowState {
  const LoginFlowState({
    this.isPasswordVisible = false,
    this.submissionState = const Idle<void>(),
  });

  final bool isPasswordVisible;
  final ResultState<void> submissionState;

  LoginFlowState copyWith({
    bool? isPasswordVisible,
    ResultState<void>? submissionState,
  }) {
    return LoginFlowState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      submissionState: submissionState ?? this.submissionState,
    );
  }

  bool get isSubmitting => submissionState.isLoading;
  String? get errorMessage => submissionState.errorMessage;
}

class LoginFlowNotifier extends Notifier<LoginFlowState> {
  @override
  LoginFlowState build() => const LoginFlowState();

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void clearError() {
    if (!state.submissionState.isError) return;
    state = state.copyWith(submissionState: const Idle<void>());
  }

  Future<ResultState<void>> submit({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(submissionState: const Loading<void>());

    final result = await ref
        .read(authLoginServiceProvider)
        .login(username: username, password: password);

    if (!ref.mounted) return const Idle<void>();

    state = state.copyWith(submissionState: result);
    return result;
  }
}

final loginFlowProvider =
    NotifierProvider.autoDispose<LoginFlowNotifier, LoginFlowState>(
      LoginFlowNotifier.new,
    );
