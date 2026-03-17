import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/scan_qr/application/services/scan_qr_submission_service.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';

class ScanQrNotifier extends Notifier<ResultState<ScanQrEntity>> {
  @override
  ResultState<ScanQrEntity> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  void setError({required String message}) {
    state = Error(message);
  }

  Future<void> runScanQr(String qrCode) async {
    state = const Loading();
    state = await ref.read(scanQrSubmissionServiceProvider).submit(qrCode);
  }
}

final scanQrProvider = NotifierProvider<ScanQrNotifier, ResultState<ScanQrEntity>>(ScanQrNotifier.new);
