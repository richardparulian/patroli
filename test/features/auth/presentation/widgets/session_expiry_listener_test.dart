import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patroli/features/auth/application/services/auth_session_sync_provider.dart';
import 'package:patroli/features/auth/presentation/widgets/session_expiry_listener.dart';
import 'package:patroli/l10n/l10n.dart';

void main() {
  testWidgets(
    'shows popup when session expires and clears notice after dismiss',
    (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('id'),
            home: const SessionExpiryListener(
              child: Scaffold(body: SizedBox.shrink()),
            ),
          ),
        ),
      );

      container
          .read(authLogoutNoticeProvider.notifier)
          .show(AuthLogoutNotice.sessionExpired);

      await tester.pump();
      await tester.pump();

      expect(find.text('Sesi Berakhir'), findsOneWidget);
      expect(
        find.text('Sesi Anda telah berakhir. Silakan login kembali.'),
        findsOneWidget,
      );

      await tester.tap(find.text('Oke'));
      await tester.pumpAndSettle();

      expect(container.read(authLogoutNoticeProvider), isNull);
      expect(find.text('Sesi Berakhir'), findsNothing);
    },
  );
}
