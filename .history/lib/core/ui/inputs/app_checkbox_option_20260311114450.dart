import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppCheckbox extends ConsumerWidget {
  final bool? value;
  final String label;
  final ValueChanged<bool> onChanged;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onChanged(!(value ?? false)),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: value ?? false ? colorScheme.primary : colorScheme.outline,
                  width: 2,
                ),
                color: value ?? false ? colorScheme.primary : Colors.transparent,
              ),
              child: value ?? false ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ) : null,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label))
          ],
        ),
      ),
    );
  }
}