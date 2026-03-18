import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/utils/screen_util.dart';

class AppLoading extends ConsumerWidget {
  final String? message;
  const AppLoading({super.key, this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final String messageText = message ?? '';
    
    return Container(
      color: colorScheme.surface.withValues(alpha: 0.9),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              strokeWidth: ScreenUtil.sw(5),
              color: colorScheme.onSurface,
              strokeCap: StrokeCap.round,
            ),
            if (messageText.isNotEmpty) ...[
              SizedBox(height: ScreenUtil.sh(16)),
              Text(messageText,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}