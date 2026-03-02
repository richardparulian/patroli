import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import '../entities/scan_qr_entity.dart';

abstract class ScanQrRepository {
  Future<Either<Failure, List<ScanQrEntity>>> getScanQrs();
  Future<Either<Failure, ScanQrEntity>> getScanQr(int id);
}
