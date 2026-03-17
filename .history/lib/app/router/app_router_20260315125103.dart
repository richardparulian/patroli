import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:patroli/app/constants/app_constants.dart';
import 'package:patroli/app/router/route_args/check_out_route_args.dart';
import 'package:patroli/app/router/route_args/image_route_args.dart';
import 'package:patroli/app/router/route_args/visit_route_args.dart';
import 'package:patroli/core/router/locale_aware_router.dart';
import 'package:patroli/core/router/session_router_refresh.dart';
import 'package:patroli/core/ui/buttons/app_button.dart';
import 'package:patroli/core/ui/images/preview_image.dart';
import 'package:patroli/features/auth/application/providers/auth_session_provider.dart';
import 'package:patroli/features/auth/presentation/screens/login_screen.dart';
import 'package:patroli/features/check_in/presentation/providers/check_in_provider.dart';
import 'package:patroli/features/check_in/presentation/screens/check_in_screen.dart';
import 'package:patroli/features/check_out/presentation/providers/check_out_provider.dart';
import 'package:patroli/features/check_out/presentation/screens/check_out_screen.dart';
import 'package:patroli/features/home/presentation/screens/home_screen.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/presentation/screens/reports_detail_screen.dart';
import 'package:patroli/features/reports/presentation/screens/reports_screen.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:patroli/features/scan_qr/presentation/screens/scan_qr_screen.dart';
import 'package:patroli/features/splash_screen/presentation/screens/splash_screen.dart';
import 'package:patroli/features/visits/presentation/providers/visit_attention_provider.dart';
import 'package:patroli/features/visits/presentation/providers/visit_create_provider.dart';
import 'package:patroli/features/visits/presentation/screens/visit_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = RouterRefreshNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: refreshNotifier,
    initialLocation: AppConstants.initialRoute,
    observers: [ref.read(localizationRouterObserverProvider)],
    routes: [
      GoRoute(
        name: 'splash',
        path: AppConstants.initialRoute,
        builder: (context, state) => const SplashScreen(),
        redirect: (context, state) => null,
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        builder: (context, state) => LoginScreen(),
        redirect: (context, state) {
          final session = ref.read(authSessionProvider);
          if (session != null) {
            return AppConstants.homeRoute;
          }
          return null;
        },
      ),
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => HomeScreen(),
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
            builder: (context, state) => ReportsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppConstants.scanQrRoute,
        name: 'scan_qr',
        builder: (context, state) => ScanQrScreen(),
      ),
      GoRoute(
        path: AppConstants.checkInRoute,
        name: 'check_in',
        builder: (context, state) {
          final args = state.extra as ScanQrEntity;
          return ProviderScope(
            overrides: [
              checkInProvider.overrideWith(() => CheckInNotifier()),
            ],
            child: CheckInScreen(scanQrData: args),
          );
        },
      ),
      GoRoute(
        path: AppConstants.visitRoute,
        name: 'visit',
        builder: (context, state) {
          final args = state.extra as VisitRouteArgs;
          return ProviderScope(
            overrides: [
              visitCreateProvider.overrideWith(() => VisitCreateNotifier()),
              visitAttentionProvider.overrideWith(() => VisitAttentionNotifier()),
            ],
            child: VisitScreen(
              scanQrData: args.scanQr,
              checkInData: args.checkIn,
              reportData: args.report,
            ),
          );
        },
      ),
      GoRoute(
        path: AppConstants.reportDetailRoute,
        name: 'report_detail',
        builder: (context, state) {
          final args = state.extra as ReportsEntity;
          return ReportsDetailScreen(reportData: args);
        },
      ),
      GoRoute(
        path: AppConstants.checkOutRoute,
        name: 'check_out',
        builder: (context, state) {
          final args = state.extra as CheckOutRouteArgs;
          return ProviderScope(
            overrides: [
              checkOutProvider.overrideWith(() => CheckOutNotifier()),
            ],
            child: CheckOutScreen(
              reportId: args.reportId,
              branchId: args.branchId,
              branchName: args.branchName,
            ),
          );
        },
      ),
      GoRoute(
        path: AppConstants.imagePreviewRoute,
        name: 'image_preview',
        builder: (context, state) {
          final args = state.extra as ImageRouteArgs;
          return ImagePreviewScreen(
            imageUrl: args.imageUrl ?? '',
            title: args.title,
          );
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
            const Text(
              '404',
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
            ),
          ],
        ),
      ),
    ),
  );
});
