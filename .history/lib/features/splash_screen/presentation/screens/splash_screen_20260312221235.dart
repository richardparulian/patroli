import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/utils/screen_util.dart';
import 'package:pos/gen/assets.gen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _initAnimations();
  }

  Future<void> _navigateToNextScreen() async {
      // Tunggu animasi selesai
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      // Cek auth state
      final session = ref.read(authSessionProvider);
      if (session == null) {
        context.go(AppConstants.loginRoute);
      } else {
        context.go(AppConstants.homeRoute);
      }
    }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.surface,
                  color.surface.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Center(
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 3,
                              color: color.surfaceContainerHighest.withValues(alpha: 0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ScreenUtil.sw(50)),
                              ),
                              child: Padding(
                                padding: ScreenUtil.paddingFromDesign(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                child: Image.asset(Assets.images.logos.pgiPatroli.path, width: 200, height: 200, fit: BoxFit.contain),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Powered by',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                color: color.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(Assets.images.logos.pgiHorizontalWhite.path, width: 150, height: 50, fit: BoxFit.contain),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          );
        },
      ),
    );
  }
}