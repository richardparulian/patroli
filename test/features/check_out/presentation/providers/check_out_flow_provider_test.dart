import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_out/application/services/check_out_submission_service.dart';
import 'package:patroli/features/check_out/presentation/providers/check_out_flow_provider.dart';
import 'package:patroli/features/pre_sign/application/services/pre_sign_upload_service.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';

class MockPreSignUploadService extends Mock implements PreSignUploadService {}

class MockCheckOutSubmissionService extends Mock
    implements CheckOutSubmissionService {}

void main() {
  late MockPreSignUploadService mockPreSignUploadService;
  late MockCheckOutSubmissionService mockCheckOutSubmissionService;
  late ProviderContainer container;

  final image = XFile('selfie.jpg');

  const presign = PreSignCreateEntity(
    url: 'https://upload-url',
    fileUrl: 'https://cdn/file.jpg',
  );

  setUp(() {
    mockPreSignUploadService = MockPreSignUploadService();
    mockCheckOutSubmissionService = MockCheckOutSubmissionService();

    container = ProviderContainer(
      overrides: [
        preSignUploadServiceProvider.overrideWithValue(
          mockPreSignUploadService,
        ),
        checkOutSubmissionServiceProvider.overrideWithValue(
          mockCheckOutSubmissionService,
        ),
      ],
    );

    addTearDown(
      container.listen(checkOutFlowProvider, (previous, next) {}).close,
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

      await container.read(checkOutFlowProvider.notifier).captureSelfie(image);

      final state = container.read(checkOutFlowProvider);
      expect(state.selfieImage?.path, image.path);
      expect(state.uploadState, isA<Success<PreSignCreateEntity?>>());
      expect(state.uploadedImageUrl, presign.fileUrl);
    },
  );

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
        () => mockCheckOutSubmissionService.submit(
          branchId: 7,
          reportId: 8,
          imageUrl: presign.fileUrl!,
        ),
      ).thenAnswer((_) async => const Success(null));

      await container.read(checkOutFlowProvider.notifier).captureSelfie(image);
      await container
          .read(checkOutFlowProvider.notifier)
          .submit(branchId: 7, reportId: 8);

      final state = container.read(checkOutFlowProvider);
      expect(state.submissionState, isA<Success<void>>());
      verify(
        () => mockCheckOutSubmissionService.submit(
          branchId: 7,
          reportId: 8,
          imageUrl: presign.fileUrl!,
        ),
      ).called(1);
    },
  );
}
