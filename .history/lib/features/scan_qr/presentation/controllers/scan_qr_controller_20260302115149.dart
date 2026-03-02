import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/usecases/scan_qr_use_case.dart';

class ScanQrController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  // :: Fetch all scan_qrs
  Future<Either<String, ScanQrEntity>> scanQr(String qrcode) async {
    final useCase = ref.read(scanQrUseCaseProvider(ScanQrParams(qrcode: qrcode)));

    final result = await useCase(ScanQrParams(qrcode: qrcode));

    return result.fold(
      (failure) => Left(failure.message),
      (entity) => Right(entity),
    );
  }
}

final scanQrControllerProvider =
    AsyncNotifierProvider<ScanQrController, void>(
        ScanQrController.new);
