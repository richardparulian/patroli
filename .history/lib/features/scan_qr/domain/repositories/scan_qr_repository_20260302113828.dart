import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import '../entities/scan_qr_entity.dart';

abstract class ScanQrRepository {
  Future<Either<Failure, ScanQrEntity>> createScanQr(ScanQrRequest request);
}
