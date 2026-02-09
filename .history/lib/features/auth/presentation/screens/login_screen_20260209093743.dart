import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/core/ui/inputs/app_text_field.dart';
import 'package:pos/core/utils/app_utils.dart';
import 'package:pos/features/auth/presentation/providers/auth_state_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _login() async {
    bool isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    FocusScope.of(context).unfocus();

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    ref.read(authProvider.notifier).login(
      username: username,
      password: password,
    );
  }

  void _listenAuthState(BuildContext context) {
    ref.listen<AuthState>(authProvider, (prev, next) {
      if (prev?.errorMessage != next.errorMessage && next.errorMessage != null) {
        AppUtils.showSnackBar(
          context,
          message: next.errorMessage!,
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _listenAuthState(context);

    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.flutter_dash, size: 100, color: Colors.blue),
                  const SizedBox(height: 32),
                  const Text('Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Sign in to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppTextField(
                    cursor: true,
                    isDense: false,
                    focusNode: _usernameFocusNode,
                    controller: _usernameController,
                    label: 'Nomor Induk Karyawan',
                    hint: 'Masukkan Nomor Induk Karyawan',
                    keyboardType: kReleaseMode ? TextInputType.number : TextInputType.text,
                    inputFormatters: [if (kReleaseMode) FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.trim().isEmpty ? 'Nomor Induk Karyawan wajib diisi!' : null,
                  ),
                  // TextFormField(
                  //   controller: _usernameController,
                  //   keyboardType: TextInputType.emailAddress,
                  //   decoration: const InputDecoration(
                  //     labelText: 'NIK',
                  //     hintText: 'Enter your NIK',
                  //     prefixIcon: Icon(Icons.person_outline),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.trim().isEmpty) {
                  //       return 'Please enter your NIK';
                  //     }

                  //     return null;
                  //   },
                  // ),
                  const SizedBox(height: 16),
                  AppTextField(
                    cursor: true,
                    isDense: false,
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    isObscure: !_isPasswordVisible,
                    label: 'Kata Sandi',
                    hint: 'Masukkan kata sandi',
                    validator: (val) => val == null || val.trim().isEmpty ? 'Kata Sandi wajib diisi!' : null,
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Implement forgot password
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    label: 'Masuk',
                    indicator: authState.isLoading ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ) : null,
                    onPressed: authState.isLoading ? null : _login,
                  ),
                  // ElevatedButton(
                  //   onPressed: authState.isLoading ? null : _login,
                  //   style: ElevatedButton.styleFrom(
                  //     padding: const EdgeInsets.symmetric(
                  //       vertical: 16,
                  //     ),
                  //     backgroundColor: Theme.of(context).colorScheme.primary,
                  //     foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  //   ),
                  //   child: authState.isLoading ? const SizedBox(
                  //     height: 20,
                  //     width: 20,
                  //     child: CircularProgressIndicator(
                  //       strokeWidth: 2,
                  //       color: Colors.white,
                  //     ),
                  //   ) : const Text('Log In'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
