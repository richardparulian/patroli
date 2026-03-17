import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/scan_qr/application/services/scan_qr_submission_service.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_provider.dart';

class MockScanQrSubmissionService extends Mock implements ScanQrSubmissionService {}

void main() {
  late MockScanQrSubmissionService mockScanQrSubmissionService;
  late ProviderContainer container;

  const entity = ScanQrEntity(id: 1, qrcode: 'ABC123-1');

  setUp(() {
    mockScanQrSubmissionService = MockScanQrSubmissionService();
    container = ProviderContainer(
      overrides: [
        scanQrSubmissionServiceProvider.overrideWithValue(mockScanQrSubmissionService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('runScanQr updates state with service result', () async {
    when(() => mockScanQrSubmissionService.submit('ABC123-1'))
        .thenAnswer((_) async => const Success(entity));

    await container.read(scanQrProvider.notifier).runScanQr('ABC123-1');

    final state = container.read(scanQrProvider);
    expect(state, isA<Success<ScanQrEntity>>());
    expect((state as Success<ScanQrEntity>).data, entity);
    verify(() => mockScanQrSubmissionService.submit('ABC123-1')).called(1);
  });

  test('setError updates provider state', () {
    container.read(scanQrProvider.notifier).setError(message: 'Manual error');

    final state = container.read(scanQrProvider);
    expect(state, isA<Error<ScanQrEntity>>());
    expect((state as Error<ScanQrEntity>).message, 'Manual error');
  });
}
