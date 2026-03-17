import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/scan_qr/application/providers/scan_qr_di_provider.dart';
import 'package:patroli/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:patroli/features/scan_qr/domain/usecases/scan_qr_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_qr_submission_service.g.dart';

class ScanQrSubmissionService {
  ScanQrSubmissionService(this.ref);

  final Ref ref;

  Future<ResultState<ScanQrEntity>> submit(String qrCode) async {
    try {
      final useCase = ref.read(scanQrUseCaseProvider);

      final isValid = useCase.isValidQrCode(qrCode);
      if (!isValid) {
        return const Error('Kode QR tidak valid');
      }

      final result = await useCase(
        ScanQrParams(
          request: ScanQrRequest(qrcode: qrCode),
        ),
      );

      return result.fold(
        (failure) => Error(failure.message),
        (entity) => Success(entity),
      );
    } catch (e) {
      return Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

@riverpod
ScanQrSubmissionService scanQrSubmissionService(Ref ref) {
  return ScanQrSubmissionService(ref);
}
