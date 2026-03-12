import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRadioOption<T> extends ConsumerWidget {
  final T value;
  final T? groupValue;
  final String label;
  final bool? isSelected;
  final ValueChanged<T?> onChanged;

  const AppRadioOption({
    super.key,
    required this.value,
    required this.groupValue, 
    required this.label,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ?? false ? colorScheme.primary : colorScheme.outline,
                  width: 2,
                ),
              ),
              child: isSelected ?? false ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ) : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label,
                style: const TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}