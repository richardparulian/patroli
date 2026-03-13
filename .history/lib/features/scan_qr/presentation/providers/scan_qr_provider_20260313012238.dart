import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/usecases/scan_qr_use_case.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_di_provider.dart';

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

    try {
      final useCase = ref.read(scanQrUseCaseProvider);

      final isValid = useCase.isValidQrCode(qrCode);

      if (!isValid) {
        state = const Error('Kode QR tidak valid');
        return;
      }

      final result = await useCase(
        ScanQrParams(
          request: ScanQrRequest(qrcode: qrCode),
        ),
      );

      result.fold(
        (failure) => state = Error(failure.message),
        (entity) => state = Success(entity),
      );
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));
    } 
  }
}

final scanQrProvider = NotifierProvider<ScanQrNotifier, ResultState<ScanQrEntity>>(ScanQrNotifier.new);
