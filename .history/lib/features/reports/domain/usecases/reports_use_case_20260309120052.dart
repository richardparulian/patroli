import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';
import 'package:pos/features/reports/domain/repositories/reports_repository.dart';

// :: Parameters for login use case
class ReportsParams extends Equatable {
  final int page;
  final int limit;
  final int status;

  const ReportsParams({
    required this.page,
    required this.limit,
    required this.status,
  });

  @override
  List<Object?> get props => [page, limit, status];
}

class ReportsUseCase implements UseCase<UserEntity, ReportsParams> {
  final ReportsRepository _repository;

  ReportsUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(ReportsParams params) {
    // :: Validate username and password
    if (params.username.isEmpty || params.password.isEmpty) {
      return Future.value(
        const Left(InputFailure(
          message: 'Nomor Induk Karyawan (NIK) dan kata sandi tidak boleh kosong',
        )),
      );
    }

    // :: Login user
    return _repository.getReports(
      page: params.page,
      limit: params.limit,
    );
  }
}
