import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_update_entity.dart';
import 'package:patroli/features/pre_sign/domain/repositories/pre_sign_repository.dart';

class PreSignUpdateParams extends Equatable {
  final String url;
  final XFile image;

  const PreSignUpdateParams({required this.url, required this.image});

  @override
  List<Object?> get props => [url, image];  
}

class PreSignUpdateUseCase implements UseCase<PreSignUpdateEntity, PreSignUpdateParams> { 
  final PreSignRepository _repository;

  PreSignUpdateUseCase(this._repository);

  @override
  Future<Either<Failure, PreSignUpdateEntity>> call(PreSignUpdateParams params) {
    if (params.url.isEmpty) {
      return Future.value(
        const Left(InputFailure(message: 'URL tidak boleh kosong')),
      );
    }

    return _repository.putPreSign(params.url, params.image);
  }
}
