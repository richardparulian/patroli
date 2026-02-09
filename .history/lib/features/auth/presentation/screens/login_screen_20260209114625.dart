import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/ui/animation/animated_error.dart';
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

  String? _errorMessage;
  Timer? _errorTimer;

  bool _isPasswordVisible = false;
  
  @override
  void dispose() {
    _errorTimer?.cancel();
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
      // if (prev?.errorMessage != next.errorMessage && next.errorMessage != null) {
      //   AppUtils.showSnackBar(
      //     context,
      //     message: next.errorMessage!,
      //     backgroundColor: Theme.of(context).colorScheme.error,
      //   );
      // }
      if (prev?.errorMessage != next.errorMessage && next.errorMessage != null) {
        _errorTimer?.cancel();

        setState(() {
          _errorMessage = next.errorMessage;
        });

        _errorTimer = Timer(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _errorMessage = null;
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    ref.listen<AuthState>(authProvider, (prev, next) {
      if (prev?.errorMessage != next.errorMessage &&
          next.errorMessage != null) {

        _errorTimer?.cancel();

        setState(() {
          _errorMessage = next.errorMessage;
        });

        _errorTimer = Timer(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _errorMessage = null;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // _listenAuthState(context);

    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/bg_success.webp', fit: BoxFit.cover),

          Container(
            color: Colors.black.withValues(alpha: 0.1),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    Image.asset('assets/images/pgi_logo_horizontal.webp', width: 110),
                    const SizedBox(height: 20),
                    const Text('Selamat Datang Kembali!',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Silahkan masuk ke akun-mu',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (_errorMessage != null)
                      AnimatedErrorNotification(
                        message: _errorMessage ?? '---',
                        onClose: () {
                          _errorTimer?.cancel();
                          setState(() {
                            _errorMessage = null;
                          });
                        },
                      ),
                    AppTextField(
                      cursor: true,
                      isDense: false,
                      focusNode: _usernameFocusNode,
                      controller: _usernameController,
                      label: 'Nomor Induk Karyawan (NIK)',
                      hint: 'Masukkan Nomor Induk Karyawan (NIK)',
                      keyboardType: kReleaseMode ? TextInputType.number : TextInputType.text,
                      inputFormatters: [if (kReleaseMode) FilteringTextInputFormatter.digitsOnly],
                      validator: (val) => val == null || val.trim().isEmpty ? 'Nomor Induk Karyawan (NIK) wajib diisi!' : null,
                    ),
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
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: AppButton(
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
            ),
          ),
        ],
      ),
    );
  }
}
