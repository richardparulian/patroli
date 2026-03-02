import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/presentation/controllers/scan_qr_controller.dart';

class ScanQrListNotifier extends Notifier<AsyncValue<List<ScanQrEntity>>> {
  @override
  AsyncValue<List<ScanQrEntity>> build() {
    return const AsyncValue.loading();
  }

  Future<void> loadScanQrs() async {
    final controller = ref.read(scanQrControllerProvider.notifier);

    final result = await controller.fetchScanQrs();

    result.fold(
      (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
      (entities) {
        state = AsyncValue.data(entities);
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await loadScanQrs();
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}

final scanQrListProvider =
    NotifierProvider<ScanQrListNotifier, AsyncValue<List<ScanQrEntity>>>(
        ScanQrListNotifier.new);
