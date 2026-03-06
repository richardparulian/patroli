import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/repositories/pre_sign_repository.dart';

// :: Parameters for get pre_sign by id use case
class GetPreSignByIdParams extends Equatable {
  final int id;

  const GetPreSignByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetPreSignByIdUseCase implements UseCase<PreSignEntity, GetPreSignByIdParams> {
  final PreSignRepository _repository;

  GetPreSignByIdUseCase(this._repository);

  @override
  Future<Either<Failure, PreSignEntity>> call(GetPreSignByIdParams params) {
    return _repository.getPreSign(params.id);
  }
}
