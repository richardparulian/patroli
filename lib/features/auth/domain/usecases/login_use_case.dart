import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/auth/data/dtos/request/login_request.dart';
import 'package:patroli/features/auth/domain/entities/user_entity.dart';
import 'package:patroli/features/auth/domain/repositories/auth_repository.dart';

// :: Parameters for login use case
class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    // :: Validate username and password
    if (params.username.isEmpty || params.password.isEmpty) {
      return Future.value(
        const Left(InputFailure(
          message: 'Nomor Induk Karyawan (NIK) dan kata sandi tidak boleh kosong',
        )),
      );
    }

    // :: Login user
    return _repository.login(
      LoginRequest(
        username: params.username,
        password: params.password,
      ),
    );
  }
}
