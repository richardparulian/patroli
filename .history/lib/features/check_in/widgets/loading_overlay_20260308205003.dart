import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingOverlay extends ConsumerWidget {
  final String? message;
  const LoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final String messageText = message ?? '';
    
    return Positioned.fill(
      child: AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          color: colorScheme.surface.withValues(alpha: 0.8),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  strokeWidth: 5,
                  color: colorScheme.onSurface,
                  strokeCap: StrokeCap.round,
                ),
                if (messageText.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(messageText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}