import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_state_provider.dart';

class LoadingOverlay extends ConsumerWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(checkInStateProvider.select((s) => s.isLoading));

    if (!isLoading) return const SizedBox();

    return AnimatedOpacity(
      opacity: opacity, 
      duration: duration,
      child: Container(
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
              Text('Memproses check-in...',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}