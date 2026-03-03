import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_state_provider.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() =>
      _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  @override
  void initState() {
    super.initState();
    // Load check_ins when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(checkInListProvider.notifier).loadCheckIns();
    });
  }

  @override
  Widget build(BuildContext context) {
    final checkInListState = ref.watch(checkInListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckIn'),
      ),
      body: checkInListState.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No check_ins found'),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('ID: \${item.id}'),
                leading: const CircleAvatar(
                  child: Icon(Icons.list),
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error: \$error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(checkInListProvider.notifier)
                      .loadCheckIns();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(checkInListProvider.notifier).refresh();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
