import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/ui/dialogs/app_dialog.dart';
import 'package:patroli/features/auth/application/services/auth_session_sync_provider.dart';
import 'package:patroli/l10n/l10n.dart';

class SessionExpiryListener extends ConsumerWidget {
  const SessionExpiryListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthLogoutNotice?>(authLogoutNoticeProvider, (previous, next) {
      if (next == null || previous == next) {
        return;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!context.mounted) {
          return;
        }

        switch (next) {
          case AuthLogoutNotice.sessionExpired:
            await AppDialog.showInfo(
              context: context,
              title: context.tr('session_expired_title'),
              message: context.tr('session_expired_message'),
              barrierDismissible: false,
            );
            break;
        }

        if (context.mounted) {
          ref.read(authLogoutNoticeProvider.notifier).clear();
        }
      });
    });

    return child;
  }
}
