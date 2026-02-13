import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/providers/localization_providers.dart';
import 'package:pos/core/router/auth_router_refresh.dart';
import 'package:pos/core/router/locale_aware_router.dart';
import 'package:pos/features/auth/presentation/screens/login_screen.dart';
import 'package:pos/features/auth/providers/auth_state_provider.dart';
import 'package:pos/features/home/presentation/screens/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authListenable = AuthListenable(ref);

  return GoRouter(
    initialLocation: AppConstants.initialRoute,
    debugLogDiagnostics: true,
    refreshListenable: authListenable,
    observers: [ref.read(localizationRouterObserverProvider)],
    redirect: (context, state) {
      // final authState = ref.read(authProvider);
      // final isLoggedIn = authState.isAuthenticated;
      // final isGoingToLogin = state.matchedLocation == AppConstants.loginRoute;

      // if (isLoggedIn && isGoingToLogin) {
      //   return AppConstants.homeRoute;
      // }

      // return null;
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.isAuthenticated;

      final isGoingToLogin =
          state.matchedLocation == AppConstants.loginRoute;

      final isGoingToInitial =
          state.matchedLocation == AppConstants.initialRoute;

      // 🔒 Kalau belum login dan bukan ke login → paksa ke login
      if (!isLoggedIn && !isGoingToLogin) {
        return AppConstants.loginRoute;
      }

      // 🔐 Kalau sudah login dan mau ke login → paksa ke home
      if (isLoggedIn && (isGoingToLogin || isGoingToInitial)) {
        return AppConstants.homeRoute;
      }

      return null;
    },
    routes: [
      // Home route
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Login route
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Initial route - redirects based on auth state
      GoRoute(
        path: AppConstants.initialRoute,
        name: 'initial',
        redirect: (context, state) {
          final authState = ref.read(authProvider);
          return authState.isAuthenticated ? AppConstants.homeRoute : AppConstants.loginRoute;
        },
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
            Text('Page ${state.uri.path} not found'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppConstants.homeRoute),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
