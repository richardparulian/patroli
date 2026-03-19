import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/app/updates/update_providers.dart';
import 'package:patroli/core/updates/update_service.dart';
import 'package:patroli/l10n/l10n.dart';

class UpdateChecker extends ConsumerWidget {
  const UpdateChecker({
    super.key,
    required this.child,
    this.autoPrompt = true,
    this.enforceCriticalUpdates = true,
  });

  final Widget child;
  final bool autoPrompt;
  final bool enforceCriticalUpdates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<UpdateCheckResult>>(updateControllerProvider, (
      _,
      state,
    ) {
      state.whenData((result) {
        if (!autoPrompt) return;

        if (result == UpdateCheckResult.updateAvailable ||
            result == UpdateCheckResult.criticalUpdateRequired) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;

            final navigator = Navigator.maybeOf(context);
            if (navigator == null) return;

            _showUpdateDialog(context, ref, result);
          });
        }
      });
    });

    return child;
  }

  void _showUpdateDialog(
    BuildContext context,
    WidgetRef ref,
    UpdateCheckResult result,
  ) async {
    final updateController = ref.read(updateControllerProvider.notifier);
    final updateInfo = await updateController.getUpdateInfo();

    if (updateInfo == null || !context.mounted) return;

    final isCritical = result == UpdateCheckResult.criticalUpdateRequired;

    showDialog(
      context: context,
      barrierDismissible: !isCritical,
      builder: (context) {
        return UpdateDialog(updateInfo: updateInfo, isCritical: isCritical);
      },
    );
  }
}

class UpdateDialog extends ConsumerWidget {
  const UpdateDialog({
    super.key,
    required this.updateInfo,
    this.isCritical = false,
  });

  final UpdateInfo updateInfo;
  final bool isCritical;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final title = isCritical
        ? context.tr('update_required_title')
        : context.tr('update_available_title');
    final message = isCritical
        ? context.trParams('update_required_message', {
            'version': updateInfo.latestVersion,
          })
        : context.trParams('update_available_message', {
            'version': updateInfo.latestVersion,
          });

    return PopScope(
      canPop: !isCritical,
      child: AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: theme.textTheme.bodyLarge),
              if (updateInfo.releaseNotes != null) ...[
                const SizedBox(height: 16),
                Text(
                  context.tr('update_whats_new'),
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(updateInfo.releaseNotes!),
              ],
            ],
          ),
        ),
        actions: [
          if (!isCritical)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.tr('later')),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(updateControllerProvider.notifier).openUpdateUrl();
            },
            child: Text(
              isCritical
                  ? context.tr('update_now')
                  : context.tr('update_action'),
            ),
          ),
        ],
      ),
    );
  }
}
