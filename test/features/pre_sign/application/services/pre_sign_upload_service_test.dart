import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/pre_sign/application/providers/pre_sign_di_provider.dart';
import 'package:patroli/features/pre_sign/application/services/pre_sign_upload_service.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_update_entity.dart';
import 'package:patroli/features/pre_sign/domain/usecases/pre_sign_create_use_case.dart';
import 'package:patroli/features/pre_sign/domain/usecases/pre_sign_update_use_case.dart';

class MockPreSignCreateUseCase extends Mock implements PreSignCreateUseCase {}

class MockPreSignUpdateUseCase extends Mock implements PreSignUpdateUseCase {}

class FakePreSignCreateParams extends Fake implements PreSignCreateParams {}

class FakePreSignUpdateParams extends Fake implements PreSignUpdateParams {}

void main() {
  late MockPreSignCreateUseCase mockPreSignCreateUseCase;
  late MockPreSignUpdateUseCase mockPreSignUpdateUseCase;
  late ProviderContainer container;
  final image = XFile('selfie.jpg');

  const presign = PreSignCreateEntity(
    url: 'https://upload-url',
    fileUrl: 'https://cdn/file.jpg',
  );
  final updateEntity = PreSignUpdateEntity.empty();

  setUpAll(() {
    registerFallbackValue(FakePreSignCreateParams());
    registerFallbackValue(FakePreSignUpdateParams());
  });

  setUp(() {
    mockPreSignCreateUseCase = MockPreSignCreateUseCase();
    mockPreSignUpdateUseCase = MockPreSignUpdateUseCase();
    container = ProviderContainer(
      overrides: [
        preSignCreateUseCaseProvider.overrideWithValue(mockPreSignCreateUseCase),
        preSignUpdateUseCaseProvider.overrideWithValue(mockPreSignUpdateUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('createAndUpload returns success when create and upload succeed', () async {
    when(() => mockPreSignCreateUseCase(any()))
        .thenAnswer((_) async => const Right(presign));
    when(() => mockPreSignUpdateUseCase(any()))
        .thenAnswer((_) async => Right(updateEntity));

    final result = await container.read(preSignUploadServiceProvider).createAndUpload(
          filename: 'file.jpg',
          image: image,
        );

    expect(result, isA<Success<PreSignCreateEntity>>());
    expect((result as Success<PreSignCreateEntity>).data, presign);
    verify(() => mockPreSignCreateUseCase(any())).called(1);
    verify(() => mockPreSignUpdateUseCase(any())).called(1);
  });

  test('createAndUpload returns error when create use case fails', () async {
    const failure = InputFailure(message: 'Filename is required');
    when(() => mockPreSignCreateUseCase(any()))
        .thenAnswer((_) async => const Left(failure));

    final result = await container.read(preSignUploadServiceProvider).createAndUpload(
          filename: '',
          image: image,
        );

    expect(result, isA<Error<PreSignCreateEntity>>());
    expect((result as Error<PreSignCreateEntity>).message, failure.message);
    verify(() => mockPreSignCreateUseCase(any())).called(1);
    verifyNever(() => mockPreSignUpdateUseCase(any()));
  });

  test('createAndUpload returns error when presign url is missing', () async {
    when(() => mockPreSignCreateUseCase(any()))
        .thenAnswer((_) async => const Right(PreSignCreateEntity(fileUrl: 'https://cdn/file.jpg')));

    final result = await container.read(preSignUploadServiceProvider).createAndUpload(
          filename: 'file.jpg',
          image: image,
        );

    expect(result, isA<Error<PreSignCreateEntity>>());
    expect((result as Error<PreSignCreateEntity>).message, 'Presigned URL not found');
    verify(() => mockPreSignCreateUseCase(any())).called(1);
    verifyNever(() => mockPreSignUpdateUseCase(any()));
  });

  test('createAndUpload returns error when upload use case fails', () async {
    const failure = ServerFailure(message: 'Upload gagal');
    when(() => mockPreSignCreateUseCase(any()))
        .thenAnswer((_) async => const Right(presign));
    when(() => mockPreSignUpdateUseCase(any()))
        .thenAnswer((_) async => const Left(failure));

    final result = await container.read(preSignUploadServiceProvider).createAndUpload(
          filename: 'file.jpg',
          image: image,
        );

    expect(result, isA<Error<PreSignCreateEntity>>());
    expect((result as Error<PreSignCreateEntity>).message, failure.message);
    verify(() => mockPreSignUpdateUseCase(any())).called(1);
  });
}
