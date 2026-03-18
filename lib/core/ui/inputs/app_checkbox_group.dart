import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/utils/screen_util.dart';

class AppCheckboxGroup extends ConsumerWidget {
  final String? title;
  final String? errorText;
  final List<String> options;
  final Set<String> values;
  final ValueChanged<Set<String>> onChanged;

  const AppCheckboxGroup({
    super.key,
    this.title,
    this.errorText,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil.radius(14)),
      ),
      child: Padding(
        padding: ScreenUtil.paddingFromDesign(left: 16, top: 0, right: 16, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(title ?? '---',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.sp(16),
                ),
              ),
              SizedBox(height: ScreenUtil.sh(12)),
            ],
            ...options.map(
              (option) {
                final selected = values.contains(option);

                return GestureDetector(
                  onTap: () => _toggle(option),
                  child: Padding(
                    padding: ScreenUtil.paddingFromDesign(vertical: 10),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: ScreenUtil.sw(22),
                          height: ScreenUtil.sw(22),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ScreenUtil.radius(6)),
                            border: Border.all(
                              color: selected ? colorScheme.primary : colorScheme.outline,
                              width: ScreenUtil.sw(2),
                            ),
                            color: selected ? colorScheme.primary : Colors.transparent,
                          ),
                          child: selected ? Icon(Icons.check, size: ScreenUtil.icon(16), color: Colors.white) : null,
                        ),
                        SizedBox(width: ScreenUtil.sw(12)),
                        Expanded(child: Text(option)),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (errorText != null) ...[
              SizedBox(height: ScreenUtil.sh(6)),
              Text(errorText ?? '---',
                style: TextStyle(
                  color: colorScheme.error,
                  fontSize: ScreenUtil.sp(12),
                ),
              ),
              SizedBox(height: ScreenUtil.sh(6)),
            ],
          ],
        ),
      ),
    );
  }
}