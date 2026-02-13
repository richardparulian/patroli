import 'package:flutter_riverpod/flutter_riverpod.dart';

// :: Login form state
class LoginFormState {
  final String username;
  final String password;
  final bool isPasswordVisible;

  const LoginFormState({this.username = '', this.password = '', this.isPasswordVisible = false});

  LoginFormState copyWith({String? username, String? password, bool? isPasswordVisible}) {
    return LoginFormState(
      username: username ?? this.username,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  bool get isValid => username.trim().isNotEmpty && password.trim().isNotEmpty;
}

// :: Login form notifier
class LoginFormNotifier extends Notifier<LoginFormState> {
  @override
  LoginFormState build() {
    // Selalu return initial state
    return const LoginFormState();
  }

  void updateUsername(String value) {
    state = state.copyWith(username: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void clearForm() {
    state = const LoginFormState();
  }
}

// :: Login form provider
final loginFormProvider = NotifierProvider<LoginFormNotifier, LoginFormState>(LoginFormNotifier.new);
