import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/ui/animation/animated_notification.dart';
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/core/ui/inputs/app_text_field.dart';
import 'package:pos/features/auth/providers/auth_state_provider.dart';
import 'package:pos/features/auth/providers/login_form_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController usernameController;
  late TextEditingController passwordController;

  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  Future<void> login() async {
    bool isFormValid = formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    usernameFocusNode.unfocus();
    passwordFocusNode.unfocus();

    await ref.read(authProvider.notifier).login(
      username: usernameController.text.trim(),
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authProvider);
    final loginFormState = ref.watch(loginFormProvider);

    final isLoading = authAsync.isLoading;
    final errorMessage = authAsync.errorMessage;
    
    final isPasswordVisible = loginFormState.isPasswordVisible;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          usernameFocusNode.unfocus();
          passwordFocusNode.unfocus();
        },
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    Image.asset('assets/images/pgi_logo_horizontal.webp', width: 120),
                    const SizedBox(height: 20),
                    const Text('Sistem Patroli Keamanan',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Masuk untuk mengelola dan melaporkan aktivitas keamanan.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: errorMessage == null ? const SizedBox.shrink() : AnimatedNotification(
                        message: errorMessage,
                        key: ValueKey(errorMessage),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            cursor: true,
                            isDense: false,
                            focusNode: usernameFocusNode,
                            controller: usernameController,
                            label: 'Nomor Induk Karyawan (NIK)',
                            hint: 'Masukkan Nomor Induk Karyawan (NIK)',
                            keyboardType: kReleaseMode ? TextInputType.number : TextInputType.text,
                            inputFormatters: [if (kReleaseMode) FilteringTextInputFormatter.digitsOnly],
                            validator: (val) => val == null || val.trim().isEmpty ? 'Nomor Induk Karyawan (NIK) wajib diisi!' : null,
                          ),
                          const SizedBox(height: 15),
                          AppTextField(
                            cursor: true,
                            isDense: false,
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            isObscure: !isPasswordVisible,
                            label: 'Kata Sandi',
                            hint: 'Masukkan kata sandi',
                            validator: (val) => val == null || val.trim().isEmpty ? 'Kata Sandi wajib diisi!' : null,
                            suffixIcon: IconButton(
                              icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                ref.read(loginFormProvider.notifier).togglePasswordVisibility();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: kFloatingActionButtonMargin,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: AppButton(
                  onPressed: isLoading ? null : login,
                  label: !isLoading ? 'Masuk' : null,
                  indicator: isLoading ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth:4,
                      strokeCap: StrokeCap.round,
                      color: Colors.white,
                    ),
                  ) : null,
                  disabledBackgroundColor: AppConstants.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
