import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/features/scan_qr/data/repositories/scan_qr_repository_impl.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/usecases/scan_qr_use_case.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_di_provider.dart';

class ScanQrController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> scanQr({required String qrcode}) async {
    state = const AsyncLoading();

    final scanQrUseCase = ref.read(scanQrUseCaseProvider);
    final result = await scanQrUseCase(ScanQrParams(qrcode: qrcode));

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (entity) => AsyncData(entity),
    );
  }
}

final scanQrControllerProvider = AsyncNotifierProvider<ScanQrController, void>(ScanQrController.new);
