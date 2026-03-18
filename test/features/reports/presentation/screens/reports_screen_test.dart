import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:patroli/features/reports/domain/entities/reports_entity.dart';
import 'package:patroli/features/reports/presentation/providers/reports_fetch_provider.dart';
import 'package:patroli/features/reports/presentation/providers/reports_paging_provider.dart';
import 'package:patroli/features/reports/presentation/providers/reports_state_provider.dart';
import 'package:patroli/features/reports/presentation/screens/reports_screen.dart';
import 'package:patroli/core/utils/screen_util.dart';
import 'package:patroli/l10n/l10n.dart';

void main() {
  testWidgets('shows loading shimmer on first page loading state', (tester) async {
    final pagingController = PagingController<int, ReportsEntity>(
      getNextPageKey: (_) => null,
      fetchPage: (_) async => const <ReportsEntity>[],
    );
    pagingController.value = PagingState<int, ReportsEntity>(
      pages: null,
      keys: null,
      error: null,
      hasNextPage: true,
      isLoading: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          reportsFetchProvider.overrideWithValue(const ReportsState()),
          reportPagingProvider.overrideWithValue(pagingController),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('id'),
          home: Builder(
            builder: (context) {
              ScreenUtil.init(context);
              return const ReportsScreen();
            },
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(ReportsScreen), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('shows error state when first page fails and error message exists', (tester) async {
    final pagingController = PagingController<int, ReportsEntity>(
      getNextPageKey: (_) => null,
      fetchPage: (_) async => const <ReportsEntity>[],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          reportsFetchProvider.overrideWithValue(
            const ReportsState(errorMessage: 'Fetch failed'),
          ),
          reportPagingProvider.overrideWithValue(pagingController),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('id'),
          home: Builder(
            builder: (context) {
              ScreenUtil.init(context);
              return const ReportsScreen();
            },
          ),
        ),
      ),
    );
    await tester.pump();

    pagingController.value = PagingState<int, ReportsEntity>(
      pages: null,
      keys: null,
      error: Exception('Fetch failed'),
      hasNextPage: true,
      isLoading: false,
    );
    await tester.pump();

    expect(find.text('Terjadi kesalahan'), findsOneWidget);
    expect(find.text('Fetch failed'), findsOneWidget);
    expect(find.text('Coba Lagi'), findsOneWidget);
  });
}
