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
import 'package:patroli/features/home/widgets/error_dashboard.dart';
import 'package:patroli/features/home/widgets/summary_dashboard.dart';
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
  TestCountReports({
    this.initialState = const Idle<ReportsCount>(),
    this.onFetch,
  });

  final ResultState<ReportsCount> initialState;
  final VoidCallback? onFetch;

  @override
  ResultState<ReportsCount> build() => initialState;

  @override
  Future<void> fetchCount() async {
    onFetch?.call();
  }
}

const _testUser = UserEntity(
  id: 1,
  ssoId: 1,
  name: 'John Doe',
  username: 'john.doe',
  role: 1,
  shouldChangePassword: false,
);

Future<void> _pumpHomeScreen(
  WidgetTester tester, {
  required ProviderContainer container,
  List<RouteBase>? routes,
}) async {
  final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes:
        routes ??
        [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.login,
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Login Page'))),
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
}

void main() {
  testWidgets('redirects to login when logout succeeds from home', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        authSessionProvider.overrideWithValue(_testUser),
        authLogoutProvider.overrideWith(TestAuthLogout.new),
        countReportsProvider.overrideWith(TestCountReports.new),
      ],
    );
    addTearDown(container.dispose);

    await _pumpHomeScreen(tester, container: container);

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

  testWidgets('renders updated home content and requests reports count', (
    tester,
  ) async {
    var fetchCountCalls = 0;

    final container = ProviderContainer(
      overrides: [
        authSessionProvider.overrideWithValue(_testUser),
        authLogoutProvider.overrideWith(TestAuthLogout.new),
        countReportsProvider.overrideWith(
          () => TestCountReports(
            initialState: Success(ReportsCount(total: 12, byStatus: 3)),
            onFetch: () => fetchCountCalls++,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await _pumpHomeScreen(tester, container: container);
    await tester.pump();

    expect(fetchCountCalls, 1);
    expect(find.text('Security Patrol System'), findsOneWidget);
    expect(find.text('Hello, John Doe'), findsOneWidget);
    expect(find.text('Add Report'), findsOneWidget);
    expect(find.text('Report List'), findsOneWidget);
    expect(find.byType(SummaryDashboard), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
  });

  testWidgets('shows error dashboard and retries reports count fetch', (
    tester,
  ) async {
    var fetchCountCalls = 0;

    final container = ProviderContainer(
      overrides: [
        authSessionProvider.overrideWithValue(_testUser),
        authLogoutProvider.overrideWith(TestAuthLogout.new),
        countReportsProvider.overrideWith(
          () => TestCountReports(
            initialState: const Error<ReportsCount>('Unable to load dashboard'),
            onFetch: () => fetchCountCalls++,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await _pumpHomeScreen(tester, container: container);
    await tester.pump();

    expect(find.byType(ErrorDashboard), findsOneWidget);
    expect(find.text('Unable to load dashboard'), findsOneWidget);
    expect(fetchCountCalls, 1);

    await tester.tap(find.text('Try Again'));
    await tester.pump();

    expect(fetchCountCalls, 2);
  });
}
