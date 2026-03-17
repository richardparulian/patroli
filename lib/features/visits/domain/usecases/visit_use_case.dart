import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/visits/data/dtos/request/visit_request.dart';
import 'package:patroli/features/visits/domain/entities/visit_entity.dart';
import 'package:patroli/features/visits/domain/repositories/visit_repository.dart';

// :: Parameters for create check_in use case
class CreateVisitParams extends Equatable {
  final VisitRequest request;
  final int reportId;

  const CreateVisitParams({required this.request, required this.reportId});

  @override
  List<Object?> get props => [request];
}

class CreateVisitUseCase implements UseCase<VisitEntity, CreateVisitParams> {
  final VisitRepository _repository;

  CreateVisitUseCase(this._repository);

  @override
  Future<Either<Failure, VisitEntity>> call(CreateVisitParams params) {
    // :: Validate request
    final errors = <String, String>{};

    if (params.request.lightsStatus.isEmpty) {
      errors['lightsStatus'] = 'Status lampu wajib diisi!';
    }

    if (params.request.bannerStatus.isEmpty) {
      errors['bannerStatus'] = 'Status banner wajib diisi!';
    }

    if (params.request.rollingDoorStatus.isEmpty) {
      errors['rollingDoorStatus'] = 'Status rolling door wajib diisi!';
    }

    if (params.request.conditionRight.isEmpty) {
      errors['conditionRight'] = 'Kondisi kanan wajib diisi!';
    }

    if (params.request.conditionLeft.isEmpty) {
      errors['conditionLeft'] = 'Kondisi kiri wajib diisi!';
    }

    if (params.request.conditionBack.isEmpty) {
      errors['conditionBack'] = 'Kondisi belakang wajib diisi!';
    }

    if (params.request.conditionAround.isEmpty) {
      errors['conditionAround'] = 'Kondisi sekitar wajib diisi!';
    }
    

    if (errors.isNotEmpty) {
      return Future.value(
        Left(
          InputFailure(
            message: 'Validation error!',
            errors: errors,
          ),
        ),
      );
    }
    
    // :: Create scan_qr
    return _repository.createVisit(params.request, params.reportId);
  }
}

