import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_out/presentation/extensions/pre_sign_extension.dart';
import 'package:patroli/features/check_out/presentation/providers/upload_file_provider.dart';
import 'package:patroli/features/pre_sign/application/services/pre_sign_upload_service.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';

class MockPreSignUploadService extends Mock implements PreSignUploadService {}

void main() {
  late MockPreSignUploadService mockPreSignUploadService;
  late ProviderContainer container;
  final image = XFile('selfie.jpg');

  const presign = PreSignCreateEntity(
    url: 'https://upload-url',
    fileUrl: 'https://cdn/file.jpg',
  );

  setUp(() {
    mockPreSignUploadService = MockPreSignUploadService();
    container = ProviderContainer(
      overrides: [
        preSignUploadServiceProvider.overrideWithValue(
          mockPreSignUploadService,
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'uploadSelfie stores upload success state with presign fileUrl',
    () async {
      when(
        () => mockPreSignUploadService.createAndUpload(
          filename: 'file.jpg',
          image: image,
        ),
      ).thenAnswer((_) async => const Success(presign));

      await container
          .read(checkOutSelfieUploadProvider.notifier)
          .uploadSelfie(image: image, filename: 'file.jpg');

      final state = container.read(checkOutSelfieUploadProvider);
      expect(state, isA<Success<PreSignCreateEntity?>>());
      expect(state.isSuccess, isTrue);
      expect(state.presign?.fileUrl, presign.fileUrl);
    },
  );

  test('reset clears previous upload state back to idle', () async {
    when(
      () => mockPreSignUploadService.createAndUpload(
        filename: 'file.jpg',
        image: image,
      ),
    ).thenAnswer((_) async => const Success(presign));

    await container
        .read(checkOutSelfieUploadProvider.notifier)
        .uploadSelfie(image: image, filename: 'file.jpg');

    container.read(checkOutSelfieUploadProvider.notifier).reset();

    final state = container.read(checkOutSelfieUploadProvider);
    expect(state, isA<Idle<PreSignCreateEntity?>>());
    expect(state.presign, isNull);
  });

  test(
    'uploadSelfie can retry after an upload failure and then succeed',
    () async {
      var callCount = 0;
      when(
        () => mockPreSignUploadService.createAndUpload(
          filename: 'file.jpg',
          image: image,
        ),
      ).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          return const Error('Upload gagal');
        }

        return const Success(presign);
      });

      await container
          .read(checkOutSelfieUploadProvider.notifier)
          .uploadSelfie(image: image, filename: 'file.jpg');

      final failedState = container.read(checkOutSelfieUploadProvider);
      expect(failedState, isA<Error<PreSignCreateEntity?>>());
      expect(failedState.isError, isTrue);
      expect(failedState.errorMessage, 'Upload gagal');

      await container
          .read(checkOutSelfieUploadProvider.notifier)
          .uploadSelfie(image: image, filename: 'file.jpg');

      final retriedState = container.read(checkOutSelfieUploadProvider);
      expect(retriedState, isA<Success<PreSignCreateEntity?>>());
      expect(retriedState.isSuccess, isTrue);
      expect(retriedState.presign?.fileUrl, presign.fileUrl);
      verify(
        () => mockPreSignUploadService.createAndUpload(
          filename: 'file.jpg',
          image: image,
        ),
      ).called(2);
    },
  );
}
