import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingOverlay extends ConsumerWidget {
  final String? message;
  const LoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String messageText = message ?? '';
    
    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 200),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black54,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                strokeWidth: 5,
                color: Colors.white,
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
    );
  }
}