import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/ui/animation/animated_error.dart';
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/core/ui/inputs/app_text_field.dart';
import 'package:pos/features/auth/presentation/providers/auth_state_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final  _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false;

  void _login() async {
    bool isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    _unfocus();

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    ref.read(authProvider.notifier).login(
      username: username,
      password: password,
    );

    debugPrint('username: $username');
  }

  void _unfocus() {
    _usernameFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider.select((s) => s.isLoading));
    final errorMessage = ref.watch(authProvider.select((s) => s.errorMessage));

    return Scaffold(
      body: GestureDetector(
        onTap: () => _unfocus(),
        child: Stack(
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
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: errorMessage == null ? const SizedBox.shrink() : AnimatedErrorNotification(
                          color: Theme.of(context).colorScheme.error,
                          message: errorMessage,
                          key: ValueKey(errorMessage),
                        ),
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
                  label: !isLoading ? 'Masuk' : null,
                  indicator: isLoading ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      strokeCap: StrokeCap.round,
                      color: Colors.white,
                    ),
                  ) : null,
                  onPressed: isLoading ? null : _login,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
