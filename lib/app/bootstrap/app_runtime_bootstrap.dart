import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/notifications/notification_providers.dart';
import 'package:patroli/app/updates/update_widgets.dart';

class AppRuntimeBootstrap extends ConsumerWidget {
  const AppRuntimeBootstrap({
    super.key,
    required this.child,
    this.autoPromptUpdates = true,
    this.enforceCriticalUpdates = true,
  });

  final Widget child;
  final bool autoPromptUpdates;
  final bool enforceCriticalUpdates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationRuntimeBootstrapProvider);

    return UpdateChecker(
      autoPrompt: autoPromptUpdates,
      enforceCriticalUpdates: enforceCriticalUpdates,
      child: child,
    );
  }
}
