import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/enums/alert_type.dart';
import 'package:pos/core/extensions/helper_state_extension.dart';
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/core/ui/cards/app_card_alert.dart';
import 'package:pos/core/ui/inputs/app_text_field.dart';
import 'package:pos/core/utils/screen_util.dart';
import 'package:pos/features/auth/presentation/providers/auth_login_provider.dart';
import 'package:pos/features/auth/presentation/providers/auth_password_provider.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';

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

    ref.read(authLoginProvider.notifier).setLoading();

    usernameFocusNode.unfocus();
    passwordFocusNode.unfocus();

    await ref.read(authLoginProvider.notifier).runLogin(
      username: usernameController.text.trim(),
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textTheme = theme.textTheme;

    final isDark = color.brightness == Brightness.dark;

    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final isSuccess = ref.watch(authLoginProvider.select((s) => s.isSuccess));
    final isLoading = ref.watch(authLoginProvider.select((s) => s.isLoading)); 
    final errorMessage = ref.watch(authLoginProvider.select((s) => s.errorMessage));
    
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          usernameFocusNode.unfocus();
          passwordFocusNode.unfocus();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/backgrounds/bg.webp', fit: BoxFit.cover),

            // :: Adaptive Gradient Overlay
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.black.withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.9),
              ),
            ),

            Padding(
              padding: ScreenUtil.paddingFromDesign(
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenUtil.sh(60)),
                    Image.asset('assets/images/logos/pgi-horizontal.webp', width: ScreenUtil.sw(120)),
                    SizedBox(height: ScreenUtil.sh(20)),
                    Text('Sistem Patroli Keamanan',
                      textAlign: TextAlign.left,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color.onSurface,
                      ),
                    ),
                    Text('Masuk untuk mengelola dan melaporkan kondisi cabang',
                      textAlign: TextAlign.start,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: ScreenUtil.sp(13),
                        color: color.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.sh(15)),
                    if (errorMessage != null) ...[
                      AppAlertCard(
                        title: 'Terjadi Kesalahan',
                        message: errorMessage,
                        type: AlertType.error,
                      ),
                      SizedBox(height: ScreenUtil.sh(20)),
                    ],
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
                          SizedBox(height: ScreenUtil.sh(15)),
                          AppTextField(
                            cursor: true,
                            isDense: false,
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            isObscure: !isPasswordVisible,
                            label: 'Kata Sandi',
                            hint: 'Masukkan kata sandi',
                            validator: (val) => val == null || val.trim().isEmpty ? 'Kata Sandi wajib diisi!' : null,
                            suffixIcon: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: ScreenUtil.radiusAll(12),
                                onTap: () {
                                  ref.read(passwordVisibilityProvider.notifier).toggle();
                                },
                                child: Padding(
                                  padding: ScreenUtil.paddingFromDesign(all: 8),
                                  child: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                                ),
                              ),
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
              bottom: kFloatingActionButtonMargin + ScreenUtil.sh(10),
              left: 0,
              right: 0,
              child: Padding(
                padding: ScreenUtil.paddingFromDesign(horizontal: 15),
                child: AppButton(
                  onPressed: isLoading || isSuccess ? null : login,
                  label: isLoading || isSuccess ? null : 'Masuk',
                  indicator: isLoading ? SizedBox(
                    height: ScreenUtil.sw(16),
                    width: ScreenUtil.sw(16),
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      color: Colors.white,
                    ),
                  ) : null,
                  borderRadius: ScreenUtil.radius(50),
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
