import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/repositories/pre_sign_repository.dart';

class PreSignUpdateParams extends Equatable {
  final String url;

  const PreSignUpdateParams({required this.request});

  @override
  List<Object?> get props => [url];  
}

class PreSignUpdateUseCase implements UseCase<PreSignEntity, PreSignUpdateParams> { 
  final PreSignRepository _repository;

  PreSignUpdateUseCase(this._repository);

  @override
  Future<Either<Failure, PreSignEntity>> call(PreSignUpdateParams params) {
    if (params.url.isEmpty) {
      return Future.value(
        const Left(InputFailure(message: 'URL tidak boleh kosong')),
      );
    }

    return _repository.putPreSign(params.url);
  }
}
