import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/usecases/scan_qr_use_case.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_di_provider.dart';

class ScanQrController extends AsyncNotifier<ScanQrEntity?> { 
  @override
  Future<ScanQrEntity?> build() async => null;

  Future<void> scanQr({required ScanQrRequest request}) async {
    state = const AsyncLoading();

    final scanQrUseCase = ref.read(scanQrUseCaseProvider);
    final result = await scanQrUseCase(ScanQrParams(request: request));

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (entity) => AsyncData(entity),
    );
  }
}

final scanQrProvider = AsyncNotifierProvider<ScanQrController, ScanQrEntity?>(ScanQrController.new);
