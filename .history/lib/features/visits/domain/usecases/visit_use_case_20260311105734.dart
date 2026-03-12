import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/domain/entities/visit_entity.dart';
import 'package:pos/features/visits/domain/repositories/visit_repository.dart';

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
    // :: Validate QR Code
    if (params.request.lightsStatus.isEmpty) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, status lampu tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }

    if (params.request.bannerStatus.isEmpty) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, status banner tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }

    if (params.request.rollingDoorStatus.isEmpty) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, status pintu rollin tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }
    
    if (params.request.conditionRight.isEmpty) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, kondisi kanan tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }
    
    if (params.request.conditionLeft.isEmpty) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, kondisi kiri tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }
    
    if (params.request.conditionBack.isEmpty) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, kondisi belakang tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }
    
    if (params.request.conditionAround.isEmpty) {
      return Future.value(
        Left(InputFailure(message: 'Maaf, kondisi sekitar tidak ditemukan, silahkan coba lagi atau hubungi admin untuk bantuan')),
      );
    }
    
    // :: Create scan_qr
    return _repository.createVisit(params.request, params.reportId);
  }
}

