import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/features/language_switcher/presentation/providers/language_switcher_provider.dart';
import 'package:patroli/l10n/l10n.dart';

class LanguageSwitcherScreen extends ConsumerWidget {
  const LanguageSwitcherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languagesAsync = ref.watch(languageSwitcherProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('language_settings')),
      ),
      body: languagesAsync.when(
        data: (languages) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: languages.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final language = languages[index];

            return Card(
              child: ListTile(
                contentPadding: EdgeIns,
                leading: CircleAvatar(
                  child: Text(language.languageCode.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(language.displayName),
                subtitle: Text(language.languageCode.toUpperCase()),
                trailing: language.isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                selected: language.isSelected,
                onTap: () async {
                  await ref.read(languageSwitcherProvider.notifier).selectLanguage(Locale(language.languageCode));
                },
              ),
            );
          },
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('${context.tr('error_occurred')}: $error'),
          ),
        ),
      ),
    );
  }
}
