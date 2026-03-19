import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/storage/local_storage_service.dart';
import 'package:patroli/core/storage/secure_storage_service.dart';
import 'package:patroli/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:patroli/features/auth/data/dtos/request/login_request.dart';
import 'package:patroli/features/auth/data/models/user_model.dart';
import 'package:patroli/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:patroli/features/auth/domain/entities/user_entity.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockLocalStorageService extends Mock implements LocalStorageService {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockLocalStorageService mockLocalStorageService;
  late MockSecureStorageService mockSecureStorageService;
  late AuthRepositoryImpl repository;

  const request = LoginRequest(username: '12345', password: 'secret');
  const userModel = UserModel(
    id: 1,
    ssoId: 99,
    name: 'Test User',
    username: '12345',
    role: 1,
    shouldChangePassword: false,
  );

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalStorageService = MockLocalStorageService();
    mockSecureStorageService = MockSecureStorageService();

    repository = AuthRepositoryImpl(
      mockRemoteDataSource,
      mockLocalStorageService,
      mockSecureStorageService,
    );

    when(
      () => mockLocalStorageService.setObject(any(), any()),
    ).thenAnswer((_) async => true);
  });

  group('AuthRepositoryImpl.login', () {
    test(
      'returns UserEntity and persists local user data on success',
      () async {
        when(
          () => mockRemoteDataSource.login(request),
        ).thenAnswer((_) async => userModel);

        final result = await repository.login(request);

        expect(result, isA<Right<Failure, UserEntity>>());
        result.fold(
          (_) => fail('Should have returned Right'),
          (user) => expect(user.name, userModel.name),
        );
        verify(
          () => mockLocalStorageService.setObject(any(), userModel.toJson()),
        ).called(1);
      },
    );

    test(
      'returns AuthFailure when remote data source throws UnauthorizedException',
      () async {
        when(() => mockRemoteDataSource.login(request)).thenThrow(
          UnauthorizedException(
            message: 'Unauthorized - Silakan login kembali',
          ),
        );

        final result = await repository.login(request);

        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold((failure) {
          expect(failure, isA<AuthFailure>());
          expect(failure.message, 'Unauthorized - Silakan login kembali');
        }, (_) => fail('Should have returned Left'));
      },
    );

    test(
      'returns NetworkFailure when remote data source throws NetworkException',
      () async {
        when(
          () => mockRemoteDataSource.login(request),
        ).thenThrow(NetworkException(message: 'Tidak ada koneksi internet'));

        final result = await repository.login(request);

        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold((failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, 'No internet connection');
        }, (_) => fail('Should have returned Left'));
      },
    );

    test(
      'returns TimeoutFailure when remote data source throws TimeoutException',
      () async {
        when(
          () => mockRemoteDataSource.login(request),
        ).thenThrow(TimeoutException(message: 'Waktu koneksi habis'));

        final result = await repository.login(request);

        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold((failure) {
          expect(failure, isA<TimeoutFailure>());
          expect(failure.message, 'Waktu koneksi habis');
        }, (_) => fail('Should have returned Left'));
      },
    );

    test(
      'returns ValidationFailure when remote data source throws BadRequestException',
      () async {
        when(
          () => mockRemoteDataSource.login(request),
        ).thenThrow(BadRequestException(message: 'Validasi gagal'));

        final result = await repository.login(request);

        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold((failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, 'Validasi gagal');
        }, (_) => fail('Should have returned Left'));
      },
    );
  });
}
