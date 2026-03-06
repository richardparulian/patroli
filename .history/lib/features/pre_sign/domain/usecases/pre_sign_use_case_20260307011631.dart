import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/repositories/scan_qr_repository.dart';

// :: Parameters for get scan_qr by id use case
class PreSignParams extends Equatable {
  final PreSignRequest request;

  const PreSignParams({required this.request});

  @override
  List<Object?> get props => [request];
}

class PreSignUseCase implements UseCase<PreSignEntity, PreSignParams> {
  final ScanQrRepository _repository;

  ScanQrUseCase(this._repository);

  @override
  Future<Either<Failure, ScanQrEntity>> call(ScanQrParams params) {
    // :: Validate QR Code
    if (params.request.qrcode.isEmpty) {
      return Future.value(
        const Left(InputFailure(message: 'QR Code tidak boleh kosong')),
      );
    }

    // :: Create scan_qr
    return _repository.createScanQr(params.request);
  }

  bool isValidQrCode(String qrCode) {
    if (qrCode.isEmpty || qrCode.length < 3) return false;
    
    final validPattern = RegExp(r'^[A-Z]{3}\d{3}-\d+$');
    return validPattern.hasMatch(qrCode);
  }
}
