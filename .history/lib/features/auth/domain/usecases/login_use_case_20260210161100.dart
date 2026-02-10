// import 'package:equatable/equatable.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:pos/core/error/failures.dart';
// import 'package:pos/core/usecases/usecase.dart';
// import 'package:pos/features/auth/domain/entities/user_entity.dart';
// import 'package:pos/features/auth/domain/repositories/auth_repository.dart';

// /// Parameters for login use case
// class LoginParams extends Equatable {
//   final String username;
//   final String password;

//   const LoginParams({
//     required this.username,
//     required this.password,
//   });

//   @override
//   List<Object?> get props => [username, password];
// }

// class LoginUseCase implements UseCase<UserEntity, LoginParams> {
//   final AuthRepository _repository;

//   LoginUseCase(this._repository);

//   @override
//   Future<Either<Failure, UserEntity>> call(LoginParams params) {
//     // Add any validation logic here if needed
//     if (params.username.isEmpty || params.password.isEmpty) {
//       return Future.value(
//         const Left(InputFailure(
//           message: 'Nomor Induk Karyawan (NIK) dan kata sandi tidak boleh kosong',
//         )),
//       );
//     }

//     return _repository.login(
//       username: params.username,
//       password: params.password,
//     );
//   }
// }
