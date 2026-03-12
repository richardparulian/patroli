import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:pos/features/check_out/domain/entities/check_out_entity.dart';
import 'package:pos/features/check_out/domain/repositories/check_out_repository.dart';

// :: Parameters for create check_in use case
class CreateCheckOutParams extends Equatable {
  final CheckOutRequest request;
  final int reportId;

  const CreateCheckOutParams({required this.request, required this.reportId});

  @override
  List<Object?> get props => [request];
}

class CreateCheckOutUseCase implements UseCase<CheckOutEntity, CreateCheckOutParams> {
  final CheckOutRepository _repository;

  CreateCheckOutUseCase(this._repository);

  @override
  Future<Either<Failure, CheckOutEntity>> call(CreateCheckOutParams params) {
    // :: Validate QR Code
    if (params.request.branchId == 0 && params.request.selfieCheckOut.isEmpty) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, cabang dan foto selfie tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }

    if (params.request.branchId == 0) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, cabang tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }

    if (params.request.selfieCheckOut.isEmpty) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, foto selfie tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }

    // :: Create scan_qr
    return _repository.createCheckOut(params.request, params.reportId);
  }
}

