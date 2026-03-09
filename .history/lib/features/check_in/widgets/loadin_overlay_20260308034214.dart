import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_state_provider.dart';

class LoadingOverlay extends ConsumerWidget {
  final String message;

  LoadingOverlay({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(checkInStateProvider.select((s) => s.isLoading));

    final message = ref.watch(checkInStateProvider.select((s) => s.loadingMessage));

    if (!isLoading) return const SizedBox();

    return Container(
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
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
}