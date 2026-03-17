import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_out/application/providers/check_out_di_provider.dart';
import 'package:patroli/features/check_out/application/services/check_out_submission_service.dart';
import 'package:patroli/features/check_out/domain/entities/check_out_entity.dart';
import 'package:patroli/features/check_out/domain/usecases/check_out_use_case.dart';
import 'package:patroli/features/pre_sign/application/services/pre_sign_upload_service.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';

class MockCreateCheckOutUseCase extends Mock implements CreateCheckOutUseCase {}

class MockPreSignUploadService extends Mock implements PreSignUploadService {}

class FakeCreateCheckOutParams extends Fake implements CreateCheckOutParams {}

void main() {
  late MockCreateCheckOutUseCase mockCreateCheckOutUseCase;
  late MockPreSignUploadService mockPreSignUploadService;
  late ProviderContainer container;
  final image = XFile('selfie.jpg');

  const presign = PreSignCreateEntity(
    url: 'https://upload-url',
    fileUrl: 'https://cdn/file.jpg',
  );
  final checkOutEntity = CheckOutEntity.empty();

  setUpAll(() {
    registerFallbackValue(FakeCreateCheckOutParams());
  });

  setUp(() {
    mockCreateCheckOutUseCase = MockCreateCheckOutUseCase();
    mockPreSignUploadService = MockPreSignUploadService();
    container = ProviderContainer(
      overrides: [
        checkOutUseCaseProvider.overrideWithValue(mockCreateCheckOutUseCase),
        preSignUploadServiceProvider.overrideWithValue(mockPreSignUploadService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('submit returns success when upload and use case succeed', () async {
    when(() => mockPreSignUploadService.createAndUpload(filename: 'file.jpg', image: image))
        .thenAnswer((_) async => const Success(presign));
    when(() => mockCreateCheckOutUseCase(any()))
        .thenAnswer((_) async => Right(checkOutEntity));

    final result = await container.read(checkOutSubmissionServiceProvider).submit(
          image: image,
          filename: 'file.jpg',
          branchId: 10,
          reportId: 20,
        );

    expect(result, isA<Success<void>>());
    verify(() => mockPreSignUploadService.createAndUpload(filename: 'file.jpg', image: image)).called(1);
    verify(() => mockCreateCheckOutUseCase(any())).called(1);
  });

  test('submit returns error when upload fails', () async {
    when(() => mockPreSignUploadService.createAndUpload(filename: 'file.jpg', image: image))
        .thenAnswer((_) async => const Error('Upload gagal'));

    final result = await container.read(checkOutSubmissionServiceProvider).submit(
          image: image,
          filename: 'file.jpg',
          branchId: 10,
          reportId: 20,
        );

    expect(result, isA<Error<void>>());
    expect((result as Error<void>).message, 'Upload gagal');
    verify(() => mockPreSignUploadService.createAndUpload(filename: 'file.jpg', image: image)).called(1);
    verifyNever(() => mockCreateCheckOutUseCase(any()));
  });

  test('submit returns error when use case fails', () async {
    const failure = ServerFailure(message: 'Check out gagal');
    when(() => mockPreSignUploadService.createAndUpload(filename: 'file.jpg', image: image))
        .thenAnswer((_) async => const Success(presign));
    when(() => mockCreateCheckOutUseCase(any()))
        .thenAnswer((_) async => const Left(failure));

    final result = await container.read(checkOutSubmissionServiceProvider).submit(
          image: image,
          filename: 'file.jpg',
          branchId: 10,
          reportId: 20,
        );

    expect(result, isA<Error<void>>());
    expect((result as Error<void>).message, failure.message);
    verify(() => mockCreateCheckOutUseCase(any())).called(1);
  });
}
