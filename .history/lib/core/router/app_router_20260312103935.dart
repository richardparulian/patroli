import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/constants/app_constants.dart';
import 'package:pos/core/router/session_router_refresh.dart';
import 'package:pos/core/router/locale_aware_router.dart';
import 'package:pos/core/ui/buttons/app_button.dart';
import 'package:pos/features/auth/presentation/providers/auth_login_provider.dart';
import 'package:pos/features/auth/presentation/providers/auth_logout_provider.dart';
import 'package:pos/features/auth/presentation/providers/auth_password_provider.dart';
import 'package:pos/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:pos/features/auth/presentation/screens/login_screen.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_provider.dart';
import 'package:pos/features/check_in/presentation/screens/check_in_screen.dart';
import 'package:pos/features/check_out/presentation/screens/check_out_screen.dart';
import 'package:pos/features/home/presentation/screens/home_screen.dart';
import 'package:pos/features/reports/presentation/providers/reports_count_provider.dart';
import 'package:pos/features/reports/presentation/providers/reports_fetch_provider.dart';
import 'package:pos/features/reports/presentation/screens/reports_detail_screen.dart';
import 'package:pos/features/reports/presentation/screens/reports_screen.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_camera_provider.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_provider.dart';
import 'package:pos/features/scan_qr/presentation/screens/scan_qr_screen.dart';
import 'package:pos/features/visits/presentation/providers/visit_attention_provider.dart';
import 'package:pos/features/visits/presentation/providers/visit_create_provider.dart';
import 'package:pos/features/visits/presentation/screens/visit_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = RouterRefreshNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: refreshNotifier,
    initialLocation: AppConstants.initialRoute,
    observers: [ref.read(localizationRouterObserverProvider)],
    routes: [
      // Initial route - redirects based on auth state
      GoRoute(
        path: AppConstants.initialRoute,
        builder: (context, state) => const SizedBox(),
        redirect: (context, state) {
          return AppConstants.loginRoute;
        },
      ),

      // Login route
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        builder: (context, state) => ProviderScope(
          overrides: [
            authLoginProvider.overrideWith(() => AuthLoginNotifier()),
            authPasswordProvider.overrideWith(() => AuthPasswordNotifier()),
          ],
          child: LoginScreen(),
        ),
        redirect: (context, state) {
          final session = ref.read(authSessionProvider);

          if (session != null) {
            return AppConstants.homeRoute;
          }
          return null;
        },
      ),

      // Home route
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => ProviderScope(
          overrides: [
            authLogoutProvider.overrideWith(() => AuthLogoutNotifier()),
            countReportsProvider.overrideWith(() => CountReportsNotifier()),
          ],
          child: HomeScreen(),
        ),
        redirect: (context, state) {
          final session = ref.read(authSessionProvider);

          if (session == null) {
            return AppConstants.loginRoute;
          }
          return null;
        },
        routes: [
          GoRoute(
            path: 'history',
            name: 'history_report',
            builder: (context, state) => ProviderScope(
              overrides: [
                reportsFetchProvider.overrideWith(() => ReportsFetchNotifier()),
              ],
              child: ReportsScreen(),
            ),
          ),
        ],
      ),

      // Scan QR route
      GoRoute(
        path: AppConstants.scanQrRoute,
        name: 'scan_qr',
        builder: (context, state) => ProviderScope(
          overrides: [
            scanQrProvider.overrideWith(() => ScanQrNotifier()),
            scanCameraProvider.overrideWith(() => ScanCameraNotifier()),
          ],
          child: ScanQrScreen(),
        ),
      ),

      // Check In route
      GoRoute(
        path: AppConstants.checkInRoute,
        name: 'check_in',
        builder: (context, state) => ProviderScope(
          overrides: [
            checkInProvider.overrideWith(() => CheckInNotifier()),
          ],
          child: CheckInScreen(),
        ),
      ),

      // Visit route
      GoRoute(
        path: AppConstants.visitRoute,
        name: 'visit',
        builder: (context, state) => ProviderScope(
          overrides: [
            visitCreateProvider.overrideWith(() => VisitCreateNotifier()),
            visitAttentionProvider.overrideWith(() => VisitAttentionNotifier()),
          ],
          child: VisitScreen(),
        ),
      ),

      // Reports detail route
      GoRoute(
        path: AppConstants.reportDetailRoute,
        name: 'report_detail',
        builder: (context, state) => const ReportsDetailScreen(),
      ),

      // Check Out route
      GoRoute(
        path: AppConstants.checkOutRoute,
        name: 'check_out',
        builder: (context, state) => const CheckOutScreen(),
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
