import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_state_provider.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() =>
      _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> {
  @override
  void initState() {
    super.initState();
    // Load scan_qrs when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(scanQrListProvider.notifier).loadScanQrs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanQrListState = ref.watch(scanQrListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ScanQr'),
      ),
      body: scanQrListState.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No scan_qrs found'),
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
                      .read(scanQrListProvider.notifier)
                      .loadScanQrs();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(scanQrListProvider.notifier).refresh();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
