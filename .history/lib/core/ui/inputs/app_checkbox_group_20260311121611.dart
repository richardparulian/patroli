import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppCheckboxGroup extends ConsumerWidget {
  final String? title;
  final List<String> options;
  final Set<String> values;
  final ValueChanged<Set<String>> onChanged;

  const AppCheckboxGroup({
    super.key,
    this.title,
    required this.options,
    required this.values,
    required this.onChanged,
  });

  void _toggle(String option) {
    final newValues = {...values};

    if (newValues.contains(option)) {
      newValues.remove(option);
    } else {
      newValues.add(option);
    }

    onChanged(newValues);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(title ?? '---',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
            ],
            ...options.map(
              (option) {
                final selected = values.contains(option);

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _toggle(option),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: selected ? colorScheme.primary : colorScheme.outline,
                              width: 2,
                            ),
                            color: selected ? colorScheme.primary : Colors.transparent,
                          ),
                          child: selected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(option)),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}