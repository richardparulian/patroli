import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/repositories/scan_qr_repository.dart';

// :: Parameters for get scan_qr by id use case
class ScanQrParams extends Equatable {
  final ScanQrRequest request;

  const ScanQrParams({required this.request});

  @override
  List<Object?> get props => [request];
}

class ScanQrUseCase implements UseCase<ScanQrEntity, ScanQrParams> {
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
    return _repository.createScanQr(
      params.request,
    );
  }
}
