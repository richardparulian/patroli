import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_in/domain/repositories/check_in_repository.dart';

// :: Parameters for create check_in use case
class CreateCheckInParams extends Equatable {
  final CheckInRequest request;

  const CreateCheckInParams({required this.request});

  @override
  List<Object?> get props => [request];
}

class CreateCheckInUseCase implements UseCase<CheckInEntity, CreateCheckInParams> {
  final CheckInRepository _repository;

  CreateCheckInUseCase(this._repository);

  @override
  Future<Either<Failure, CheckInEntity>> call(CreateCheckInParams params) {
    // :: Validate QR Code
    if (params.request.branchId == 0) {
      return Future.value(
        Left(InputFailure(message: 'Cabang tidak valid')),
      );
    }

    // :: Create scan_qr
    return _repository.createCheckIn(params.request);
  }
}

