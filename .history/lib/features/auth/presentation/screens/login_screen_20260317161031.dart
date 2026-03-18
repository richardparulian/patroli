import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/enums/alert_type.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/ui/buttons/app_button.dart';
import 'package:patroli/core/ui/cards/app_card_alert.dart';
import 'package:patroli/core/ui/inputs/app_text_field.dart';
import 'package:patroli/core/utils/screen_util.dart';
import 'package:patroli/features/auth/presentation/providers/auth_login_provider.dart';
import 'package:patroli/features/auth/presentation/providers/auth_password_provider.dart';
import 'package:patroli/l10n/l10n.dart';

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

    final isPasswordVisible = ref.watch(authPasswordProvider);
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
                    SizedBox(
                      height: ScreenUtil.sh(10) + MediaQuery.paddingOf(context).top,
                    ),
                    Image.asset('assets/images/logos/pgi-horizontal.webp', width: ScreenUtil.sw(120)),
                    SizedBox(height: ScreenUtil.sh(20)),
                    Text(context.tr('security_patrol_system'),
                      textAlign: TextAlign.left,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color.onSurface,
                      ),
                    ),
                    Text(context.tr('login_subtitle'),
                      textAlign: TextAlign.start,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: ScreenUtil.sp(13),
                        color: color.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.sh(15)),
                    if (errorMessage != null) ...[
                      AppAlertCard(
                        title: context.tr('error_occurred'),
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
                            label: context.tr('employee_number'),
                            hint: context.tr('enter_employee_number'),
                            keyboardType: kReleaseMode ? TextInputType.number : TextInputType.text,
                            inputFormatters: [if (kReleaseMode) FilteringTextInputFormatter.digitsOnly],
                            validator: (val) => val == null || val.trim().isEmpty ? context.tr('employee_number_required') : null,
                          ),
                          SizedBox(height: ScreenUtil.sh(15)),
                          AppTextField(
                            cursor: true,
                            isDense: false,
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            isObscure: !isPasswordVisible,
                            label: context.tr('password'),
                            hint: context.tr('enter_password'),
                            validator: (val) => val == null || val.trim().isEmpty ? context.tr('password_required') : null,
                            suffixIcon: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: ScreenUtil.radiusAll(12),
                                onTap: () {
                                  ref.read(authPasswordProvider.notifier).toggle();
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
              bottom: MediaQuery.paddingOf(context).bottom + ScreenUtil.sh(20),
              left: 0,
              right: 0,
              child: Padding(
                padding: ScreenUtil.paddingFromDesign(horizontal: 15),
                child: AppButton(
                  onPressed: isLoading ? null : login,
                  label: isLoading ? null : context.tr('login'),
                  indicator: isLoading ? SizedBox(
                    height: ScreenUtil.sw(14),
                    width: ScreenUtil.sw(14),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      strokeCap: StrokeCap.round,
                      color: Colors.white,
                    ),
                  ) : null,
                  borderRadius: ScreenUtil.radius(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
