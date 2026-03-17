import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';

abstract class ScanQrRepository {
  Future<Either<Failure, ScanQrEntity>> createScanQr(ScanQrRequest request);
}
