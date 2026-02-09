import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';
import 'package:pos/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> execute({required String username, required String password}) {
    // Add any validation logic here if needed
    if (username.isEmpty || password.isEmpty) {
      return Future.value(
        const Left(InputFailure(message: 'Nomor Induk Karyawan (NIK) dan kata sandi tidak boleh kosong')),
      );
    }

    return _repository.login(username: username, password: password);
  }
}
