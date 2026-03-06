import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/repositories/pre_sign_repository.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/repositories/scan_qr_repository.dart';

// :: Parameters for get scan_qr by id use case
class PreSignParams extends Equatable {
  final PreSignRequest request;

  const PreSignParams({required this.request});

  @override
  List<Object?> get props => [request];
}

class PreSignUseCase implements UseCase<PreSignEntity, PreSignParams> { 
  final PreSignRepository _repository;

  PreSignUseCase(this._repository);

  @override
  Future<Either<Failure, PreSignEntity>> call(PreSignParams params) {
    if (params.request.filename.isEmpty) {
      return Future.value(
        const Left(InputFailure(message: 'Filename tidak boleh kosong')),
      );
    }

    return _repository.postPreSign(params.request);
  }
}
