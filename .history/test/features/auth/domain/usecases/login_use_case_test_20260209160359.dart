import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/auth/domain/entities/user_entity.dart';
import 'package:pos/features/auth/domain/repositories/auth_repository.dart';
import 'package:pos/features/auth/domain/usecases/login_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  const tUsername = '12345'; // NIK (Nomor Induk Karyawan)
  const tPassword = 'password123';
  const tUser = UserEntity(
    id: 1,
    ssoId: 1,
    username: tUsername,
    name: 'Test User',
    role: 1,
    shouldChangePassword: false,
  );

  test('should return UserEntity when login is successful', () async {
    // Arrange
    when(
      () => mockAuthRepository.login(username: tUsername, password: tPassword),
    ).thenAnswer((_) async => const Right(tUser));

    // Act
    final result = await useCase(
      LoginParams(username: tUsername, password: tPassword),
    );

    // Assert
    expect(result, const Right(tUser));
    verify(
      () => mockAuthRepository.login(username: tUsername, password: tPassword),
    ).called(1);
  });

  test('should return ServerFailure when login fails', () async {
    // Arrange
    const tFailure = ServerFailure(message: 'Login failed');
    when(
      () => mockAuthRepository.login(username: tUsername, password: tPassword),
    ).thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(
      LoginParams(username: tUsername, password: tPassword),
    );

    // Assert
    expect(result, const Left(tFailure));
    verify(
      () => mockAuthRepository.login(username: tUsername, password: tPassword),
    ).called(1);
  });

  test('should return InputFailure when username is empty', () async {
    // Act
    final result = await useCase(
      LoginParams(username: '', password: tPassword),
    );

    // Assert
    result.fold(
      (failure) => expect(failure, isA<InputFailure>()),
      (_) => fail('Should have returned failure'),
    );

    verifyZeroInteractions(mockAuthRepository);
  });

  test('should return InputFailure when password is empty', () async {
    // Act
    final result = await useCase(
      LoginParams(username: tUsername, password: ''),
    );

    // Assert
    result.fold(
      (failure) => expect(failure, isA<InputFailure>()),
      (_) => fail('Should have returned failure'),
    );

    verifyZeroInteractions(mockAuthRepository);
  });
}
