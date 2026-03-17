import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/scan_qr/application/services/scan_qr_submission_service.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:patroli/features/visits/presentation/providers/visit_attention_provider.dart';

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

  test('runVisitAttention updates state with service result', () async {
    when(() => mockScanQrSubmissionService.submit('ABC123-1'))
        .thenAnswer((_) async => const Success(entity));

    await container.read(visitAttentionProvider.notifier).runVisitAttention('ABC123-1');

    expect(container.read(visitAttentionProvider), const Success<ScanQrEntity>(entity));
    verify(() => mockScanQrSubmissionService.submit('ABC123-1')).called(1);
  });
}
