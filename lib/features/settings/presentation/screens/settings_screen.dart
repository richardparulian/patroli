import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:patroli/app/theme/theme_providers.dart';
import 'package:patroli/core/ui/bottom_sheets/app_bottom_sheet.dart';
import 'package:patroli/core/utils/screen_util.dart';
import 'package:patroli/l10n/l10n.dart';

/// Settings screen with various app configuration options
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('settings'))),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil.sh(8)),
        children: [
          // Language settings
          ListTile(
            leading: Icon(Iconsax.global, size: ScreenUtil.icon(22)),
            title: Text(context.tr('language')),
            subtitle: Text(context.tr('change_language')),
            onTap: null,
            // onTap: () => context.push(AppRoutes.languageSwitcher),
          ),
          Divider(height: ScreenUtil.sh(1)),
          // Theme settings
          ListTile(
            leading: Icon(
              Icons.brightness_6_rounded,
              size: ScreenUtil.icon(22),
            ),
            title: Text(context.tr('theme')),
            subtitle: Text(
              _themeModeLabel(context, ref.watch(themeModeProvider)),
            ),
            onTap: () => _showThemeModeSheet(context, ref),
          ),
        ],
      ),
    );
  }

  String _themeModeLabel(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return context.tr('light_mode');
      case ThemeMode.dark:
        return context.tr('dark_mode');
      case ThemeMode.system:
        return context.tr('system_mode');
    }
  }

  Future<void> _showThemeModeSheet(BuildContext context, WidgetRef ref) async {
    final selectedMode = ref.read(themeModeProvider);

    await AppBottomSheet.show<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Iconsax.sun_1, size: ScreenUtil.icon(22)),
                title: Text(context.tr('light_mode')),
                trailing: selectedMode == ThemeMode.light
                    ? Icon(
                        Iconsax.tick_circle,
                        size: ScreenUtil.icon(20),
                        color: Colors.green,
                      )
                    : null,
                onTap: () async {
                  await ref
                      .read(themeModeProvider.notifier)
                      .set(ThemeMode.light);
                  if (sheetContext.mounted) Navigator.of(sheetContext).pop();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Iconsax.moon, size: ScreenUtil.icon(22)),
                title: Text(context.tr('dark_mode')),
                trailing: selectedMode == ThemeMode.dark
                    ? Icon(
                        Iconsax.tick_circle,
                        size: ScreenUtil.icon(20),
                        color: Colors.green,
                      )
                    : null,
                onTap: () async {
                  await ref
                      .read(themeModeProvider.notifier)
                      .set(ThemeMode.dark);
                  if (sheetContext.mounted) Navigator.of(sheetContext).pop();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Iconsax.autobrightness,
                  size: ScreenUtil.icon(22),
                ),
                title: Text(context.tr('system_mode')),
                trailing: selectedMode == ThemeMode.system
                    ? Icon(
                        Iconsax.tick_circle,
                        size: ScreenUtil.icon(20),
                        color: Colors.green,
                      )
                    : null,
                onTap: () async {
                  await ref
                      .read(themeModeProvider.notifier)
                      .set(ThemeMode.system);
                  if (sheetContext.mounted) Navigator.of(sheetContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
