import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:patroli/features/pre_sign/domain/repositories/pre_sign_repository.dart';

class PreSignCreateParams extends Equatable {
  final PreSignCreateRequest request;

  const PreSignCreateParams({required this.request});

  @override
  List<Object?> get props => [request];
}

class PreSignCreateUseCase implements UseCase<PreSignCreateEntity, PreSignCreateParams> { 
  final PreSignRepository _repository;

  PreSignCreateUseCase(this._repository);

  @override
  Future<Either<Failure, PreSignCreateEntity>> call(PreSignCreateParams params) {
    if (params.request.filename.isEmpty) {
      return Future.value(
        const Left(InputFailure(message: 'Filename tidak boleh kosong')),
      );
    }

    return _repository.postPreSign(params.request);
  }
}
