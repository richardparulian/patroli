import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_in/application/services/check_in_submission_service.dart';
import 'package:patroli/features/check_in/domain/entities/check_in_entity.dart';
import 'package:patroli/features/check_in/presentation/providers/check_in_flow_provider.dart';
import 'package:patroli/features/pre_sign/application/services/pre_sign_upload_service.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';

class MockPreSignUploadService extends Mock implements PreSignUploadService {}

class MockCheckInSubmissionService extends Mock
    implements CheckInSubmissionService {}

void main() {
  late MockPreSignUploadService mockPreSignUploadService;
  late MockCheckInSubmissionService mockCheckInSubmissionService;
  late ProviderContainer container;

  final image = XFile('selfie.jpg');

  const presign = PreSignCreateEntity(
    url: 'https://upload-url',
    fileUrl: 'https://cdn/file.jpg',
  );

  const entity = CheckInEntity(id: 10);

  setUp(() {
    mockPreSignUploadService = MockPreSignUploadService();
    mockCheckInSubmissionService = MockCheckInSubmissionService();

    container = ProviderContainer(
      overrides: [
        preSignUploadServiceProvider.overrideWithValue(
          mockPreSignUploadService,
        ),
        checkInSubmissionServiceProvider.overrideWithValue(
          mockCheckInSubmissionService,
        ),
      ],
    );

    addTearDown(
      container.listen(checkInFlowProvider, (previous, next) {}).close,
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'captureSelfie uploads image and stores selfie plus upload result',
    () async {
      when(
        () => mockPreSignUploadService.createAndUpload(
          filename: any(named: 'filename'),
          image: image,
        ),
      ).thenAnswer((_) async => const Success(presign));

      await container.read(checkInFlowProvider.notifier).captureSelfie(image);

      final state = container.read(checkInFlowProvider);
      expect(state.selfieImage?.path, image.path);
      expect(state.uploadState, isA<Success<PreSignCreateEntity?>>());
      expect(state.uploadedImageUrl, presign.fileUrl);
    },
  );

  test('retryUpload reuses selfie image after upload failure', () async {
    var callCount = 0;
    when(
      () => mockPreSignUploadService.createAndUpload(
        filename: any(named: 'filename'),
        image: image,
      ),
    ).thenAnswer((_) async {
      callCount++;
      if (callCount == 1) {
        return const Error('Upload gagal');
      }
      return const Success(presign);
    });

    await container.read(checkInFlowProvider.notifier).captureSelfie(image);
    await container.read(checkInFlowProvider.notifier).retryUpload();

    final state = container.read(checkInFlowProvider);
    expect(state.selfieImage?.path, image.path);
    expect(state.isReadyToSubmit, isTrue);
    verify(
      () => mockPreSignUploadService.createAndUpload(
        filename: any(named: 'filename'),
        image: image,
      ),
    ).called(2);
  });

  test(
    'submit uses uploaded image url and stores submission success',
    () async {
      when(
        () => mockPreSignUploadService.createAndUpload(
          filename: any(named: 'filename'),
          image: image,
        ),
      ).thenAnswer((_) async => const Success(presign));
      when(
        () => mockCheckInSubmissionService.submit(
          branchId: 7,
          imageUrl: presign.fileUrl!,
        ),
      ).thenAnswer((_) async => const Success(entity));

      await container.read(checkInFlowProvider.notifier).captureSelfie(image);
      await container.read(checkInFlowProvider.notifier).submit(branchId: 7);

      final state = container.read(checkInFlowProvider);
      expect(state.submissionState, isA<Success<CheckInEntity>>());
      verify(
        () => mockCheckInSubmissionService.submit(
          branchId: 7,
          imageUrl: presign.fileUrl!,
        ),
      ).called(1);
    },
  );
}
