import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:patroli/app/constants/app_routes.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/core/utils/screen_util.dart';
import 'package:patroli/features/auth/application/providers/auth_session_provider.dart';
import 'package:patroli/features/auth/domain/entities/user_entity.dart';
import 'package:patroli/features/auth/presentation/providers/auth_logout_provider.dart';
import 'package:patroli/features/home/presentation/screens/home_screen.dart';
import 'package:patroli/features/reports/domain/entities/reports_count.dart';
import 'package:patroli/features/reports/presentation/providers/reports_count_provider.dart';
import 'package:patroli/l10n/l10n.dart';

class TestAuthLogout extends AuthLogout {
  @override
  ResultState<void> build() => const Idle<void>();

  @override
  Future<ResultState<void>> runLogout() async {
    state = const Loading<void>();
    state = const Success<void>(null);
    return state;
  }
}

class TestCountReports extends CountReports {
  @override
  ResultState<ReportsCount> build() => const Idle<ReportsCount>();

  @override
  Future<void> fetchCount() async {
    state = const Idle<ReportsCount>();
  }
}

void main() {
  testWidgets('redirects to login when logout succeeds from home', (tester) async {
    final container = ProviderContainer(
      overrides: [
        authSessionProvider.overrideWithValue(
          const UserEntity(
            id: 1,
            ssoId: 1,
            name: 'John Doe',
            username: 'john.doe',
            role: 1,
            shouldChangePassword: false,
          ),
        ),
        authLogoutProvider.overrideWith(TestAuthLogout.new),
        countReportsProvider.overrideWith(TestCountReports.new),
      ],
    );
    addTearDown(container.dispose);

    final router = GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Login Page')),
          ),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Builder(
          builder: (context) {
            ScreenUtil.init(context);
            return MaterialApp.router(
              routerConfig: router,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: const Locale('en'),
            );
          },
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(HomeScreen), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Yes'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Login Page'), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });
}
