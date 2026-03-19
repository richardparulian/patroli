import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:patroli/app/constants/app_routes.dart';
import 'package:patroli/app/router/route_args/check_out_route_args.dart';
import 'package:patroli/app/router/route_args/image_route_args.dart';
import 'package:patroli/app/router/route_args/visit_route_args.dart';
import 'package:patroli/app/router/locale_aware_router.dart';
import 'package:patroli/app/router/session_router_refresh.dart';
import 'package:patroli/core/ui/buttons/app_button.dart';
import 'package:patroli/core/ui/images/preview_image.dart';
import 'package:patroli/l10n/l10n.dart';
import 'package:patroli/features/auth/application/providers/auth_session_provider.dart';
import 'package:patroli/features/auth/presentation/screens/login_screen.dart';
import 'package:patroli/features/check_in/presentation/providers/check_in_provider.dart';
import 'package:patroli/features/check_in/presentation/screens/check_in_screen.dart';
import 'package:patroli/features/check_out/presentation/providers/check_out_provider.dart';
import 'package:patroli/features/check_out/presentation/screens/check_out_screen.dart';
import 'package:patroli/features/home/presentation/screens/home_screen.dart';
import 'package:patroli/features/language_switcher/presentation/screens/language_switcher_screen.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/presentation/screens/reports_detail_screen.dart';
import 'package:patroli/features/reports/presentation/screens/reports_screen.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:patroli/features/scan_qr/presentation/screens/scan_qr_screen.dart';
import 'package:patroli/features/settings/presentation/screens/settings_screen.dart';
import 'package:patroli/features/splash_screen/presentation/screens/splash_screen.dart';
import 'package:patroli/features/visits/presentation/providers/visit_attention_provider.dart';
import 'package:patroli/features/visits/presentation/providers/visit_create_provider.dart';
import 'package:patroli/features/visits/presentation/screens/visit_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = RouterRefreshNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: refreshNotifier,
    initialLocation: AppRoutes.initial,
    observers: [ref.read(localizationRouterObserverProvider)],
    redirect: (context, state) {
      final session = ref.read(authSessionProvider);
      final path = state.uri.path;

      final isSplash = path == AppRoutes.initial;
      final isLogin = path == AppRoutes.login;

      if (session == null && !isSplash && !isLogin) {
        return AppRoutes.login;
      }

      if (session != null && isLogin) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        name: 'splash',
        path: AppRoutes.initial,
        builder: (context, state) => const SplashScreen(),
        redirect: (context, state) => null,
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            path: 'history',
            name: 'history_report',
            builder: (context, state) => ReportsScreen(),
            routes: [
              GoRoute(
                path: 'report_detail',
                name: 'report_detail',
                builder: (context, state) {
                  final args = state.extra as ReportsEntity;
                  return ReportsDetailScreen(reportData: args);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'language_switcher',
                name: 'language_switcher',
                builder: (context, state) => const LanguageSwitcherScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.scanQr,
        name: 'scan_qr',
        builder: (context, state) => ScanQrScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkIn,
        name: 'check_in',
        builder: (context, state) {
          final args = state.extra as ScanQrEntity;
          return ProviderScope(
            overrides: [checkInProvider.overrideWith(() => CheckInNotifier())],
            child: CheckInScreen(scanQrData: args),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.visit,
        name: 'visit',
        builder: (context, state) {
          final args = state.extra as VisitRouteArgs;
          return ProviderScope(
            overrides: [
              visitCreateProvider.overrideWith(() => VisitCreateNotifier()),
              visitAttentionProvider.overrideWith(
                () => VisitAttentionNotifier(),
              ),
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
        path: AppRoutes.checkOut,
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
        path: AppRoutes.imagePreview,
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
      appBar: AppBar(title: Text(context.tr('page_not_found'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '404',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              context.trParams('page_not_found_message', {
                'path': state.uri.path,
              }),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  onPressed: () => context.go(AppRoutes.home),
                  label: context.tr('back_to_home'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
});
