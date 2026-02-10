import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text editing controllers
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  // Focus nodes
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;

  // Previous values for comparison
  String? _previousUsername;
  String? _previousPassword;

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

  @override
  Widget build(BuildContext context) {
    // Sync controllers dengan initial state dan update ketika state berubah
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      
      final formState = ref.read(loginFormProvider);

      // Initial sync
      if (_previousUsername == null && _previousPassword == null) {
        usernameController.text = formState.username;
        passwordController.text = formState.password;
        _previousUsername = formState.username;
        _previousPassword = formState.password;
      }

      // Sync username jika berubah
      if (_previousUsername != formState.username) {
        usernameController.value = TextEditingValue(
          text: formState.username,
          selection: TextSelection.collapsed(offset: formState.username.length),
        );
        _previousUsername = formState.username;
      }

      // Sync password jika berubah
      if (_previousPassword != formState.password) {
        passwordController.value = TextEditingValue(
          text: formState.password,
          selection: TextSelection.collapsed(offset: formState.password.length),
        );
        _previousPassword = formState.password;
      }
    });

    // Login function
    void login() async {
      bool isFormValid = formKey.currentState?.validate() ?? false;

      if (!isFormValid) return;

      // Unfocus all fields
      usernameFocusNode.unfocus();
      passwordFocusNode.unfocus();

      // Get form state from Riverpod
      final formState = ref.read(loginFormProvider);

      ref.read(authProvider.notifier).login(
        username: formState.username.trim(),
        password: formState.password,
      );
    }

    // Watch auth state using AsyncValue
    final authAsync = ref.watch(authProvider);
    
    // Extract values from AsyncValue
    final isLoading = authAsync.isLoading;
    final errorMessage = authAsync.errorMessage;
    
    // Watch password visibility
    final isPasswordVisible = ref.watch(loginFormProvider.select((s) => s.isPasswordVisible));

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
                    const Text('Selamat datang kembali!',
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
                            onChanged: (value) {
                              ref.read(loginFormProvider.notifier).updateUsername(value);
                            },
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
                            onChanged: (value) {
                              ref.read(loginFormProvider.notifier).updatePassword(value);
                            },
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
                      strokeWidth:4,
                      strokeCap: StrokeCap.round,
                      color: Colors.white,
                    ),
                  ) : null,
                  onPressed: isLoading ? null : login,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
