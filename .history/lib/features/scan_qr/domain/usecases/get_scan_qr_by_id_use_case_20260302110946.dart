import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/repositories/scan_qr_repository.dart';

// :: Parameters for get scan_qr by id use case
class GetScanQrByIdParams extends Equatable {
  final int id;

  const GetScanQrByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetScanQrByIdUseCase implements UseCase<ScanQrEntity, GetScanQrByIdParams> {
  final ScanQrRepository _repository;

  GetScanQrByIdUseCase(this._repository);

  @override
  Future<Either<Failure, ScanQrEntity>> call(GetScanQrByIdParams params) {
    return _repository.getScanQr(params.id);
  }
}
