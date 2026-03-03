import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_in/domain/repositories/check_in_repository.dart';

// :: Parameters for get check_in by id use case
class GetCheckInByIdParams extends Equatable {
  final int id;

  const GetCheckInByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetCheckInByIdUseCase implements UseCase<CheckInEntity, GetCheckInByIdParams> {
  final CheckInRepository _repository;

  GetCheckInByIdUseCase(this._repository);

  @override
  Future<Either<Failure, CheckInEntity>> call(GetCheckInByIdParams params) {
    return _repository.getCheckIn(params.id);
  }
}
