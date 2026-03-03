import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/router/session_router_refresh.dart';
import 'package:pos/core/router/locale_aware_router.dart';
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:pos/features/auth/presentation/screens/login_screen.dart';
import 'package:pos/features/home/presentation/screens/home_screen.dart';
import 'package:pos/features/scan_qr/presentation/screens/scan_qr_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = RouterRefreshNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: refreshNotifier,
    initialLocation: AppConstants.initialRoute,
    observers: [ref.read(localizationRouterObserverProvider)],
    redirect: (context, state) {
      final user = ref.read(authSessionProvider);
      final isLoggedIn = user != null;

      final isGoingToLogin = state.matchedLocation == AppConstants.loginRoute;
      final isGoingToInitial = state.matchedLocation == AppConstants.initialRoute;

      if (!isLoggedIn && !isGoingToLogin) {
        return AppConstants.loginRoute;
      }

      if (isLoggedIn && (isGoingToLogin || isGoingToInitial)) {
        return AppConstants.homeRoute;
      }

      return null;
    },
    routes: [
      // Initial route - redirects based on auth state
      // GoRoute(
      //   path: AppConstants.initialRoute,
      //   name: 'initial',
      //   redirect: (context, state) {
      //     // final authState = ref.read(authProvider);
      //     return AppConstants.loginRoute;
      //   },
      // ),
      // Login route
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      // Home route
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => HomeScreen(),
      ),
      // Scan QR route
      GoRoute(
        path: AppConstants.scanQrRoute,
        name: 'scan_qr',
        builder: (context, state) => const ScanQrScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('404',
              style: TextStyle(
                fontSize: 48, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Halaman ${state.uri.path} tidak ditemukan'),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  onPressed: () => context.go(AppConstants.homeRoute),
                  label: 'Kembali ke Beranda',
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
});
