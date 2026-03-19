import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/scan_qr/application/services/scan_qr_submission_service.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:patroli/features/scan_qr/presentation/providers/scan_qr_flow_provider.dart';

class MockScanQrSubmissionService extends Mock
    implements ScanQrSubmissionService {}

void main() {
  late MockScanQrSubmissionService mockScanQrSubmissionService;
  late ProviderContainer container;

  const entity = ScanQrEntity(id: 1, qrcode: 'ABC123-1');

  setUp(() {
    mockScanQrSubmissionService = MockScanQrSubmissionService();
    container = ProviderContainer(
      overrides: [
        scanQrSubmissionServiceProvider.overrideWithValue(
          mockScanQrSubmissionService,
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('handleScannedCode updates state with service result', () async {
    when(
      () => mockScanQrSubmissionService.submit('ABC123-1'),
    ).thenAnswer((_) async => const Success(entity));

    await container
        .read(scanQrFlowProvider.notifier)
        .handleScannedCode('ABC123-1');

    final state = container.read(scanQrFlowProvider);
    expect(state.isProcessing, isFalse);
    expect(state.scanState, isA<Success<ScanQrEntity>>());
    expect(state.scannedEntity, entity);
    verify(() => mockScanQrSubmissionService.submit('ABC123-1')).called(1);
  });

  test('setGalleryNotFoundError updates provider state', () {
    container
        .read(scanQrFlowProvider.notifier)
        .setGalleryNotFoundError('QR not found');

    final state = container.read(scanQrFlowProvider);
    expect(state.scanState, isA<Error<ScanQrEntity>>());
    expect(state.errorMessage, 'QR not found');
  });

  test('resetScanState clears error and processing state', () {
    container
        .read(scanQrFlowProvider.notifier)
        .setGalleryNotFoundError('QR not found');

    container.read(scanQrFlowProvider.notifier).resetScanState();

    final state = container.read(scanQrFlowProvider);
    expect(state.scanState, isA<Idle<ScanQrEntity>>());
    expect(state.errorMessage, isNull);
    expect(state.isProcessing, isFalse);
  });
}
