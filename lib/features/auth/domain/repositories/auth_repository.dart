import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/auth/data/dtos/request/login_request.dart';
import 'package:patroli/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  // :: Login a user with email and password
  Future<Either<Failure, UserEntity>> login(LoginRequest request);

  // :: Logout the current user
  Future<Either<Failure, void>> logout();

  // :: Check if a user is authenticated
  Future<Either<Failure, bool>> isAuthenticated();

  // :: Get the current authenticated user
  Future<Either<Failure, UserEntity>> getCurrentUser();
}
