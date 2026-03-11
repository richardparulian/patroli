import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/presentation/providers/reports_state_provider.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() =>
      _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    // Load reportss when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reportsListProvider.notifier).loadReportss();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportsListState = ref.watch(reportsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: reportsListState.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No reportss found'),
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
                      .read(reportsListProvider.notifier)
                      .loadReportss();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(reportsListProvider.notifier).refresh();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
