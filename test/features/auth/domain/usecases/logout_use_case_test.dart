import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/auth/domain/repositories/auth_repository.dart';
import 'package:pos/features/auth/domain/usecases/logout_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LogoutUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LogoutUseCase(mockAuthRepository);
  });

  test('should return Right(null) when logout is successful', () async {
    // Arrange
    when(() => mockAuthRepository.logout())
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, const Right(null));
    verify(() => mockAuthRepository.logout()).called(1);
  });

  test('should return ServerFailure when logout fails', () async {
    // Arrange
    const tFailure = ServerFailure(message: 'Logout failed');
    when(() => mockAuthRepository.logout())
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.logout()).called(1);
  });

  test('should return CacheFailure when cache clearing fails', () async {
    // Arrange
    const tFailure = CacheFailure(message: 'Failed to clear cache');
    when(() => mockAuthRepository.logout())
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, const Left(tFailure));
    verify(() => mockAuthRepository.logout()).called(1);
  });
}
