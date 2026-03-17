import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/scan_qr/application/providers/scan_qr_di_provider.dart';
import 'package:patroli/features/scan_qr/application/services/scan_qr_submission_service.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:patroli/features/scan_qr/domain/usecases/scan_qr_use_case.dart';

class MockScanQrUseCase extends Mock implements ScanQrUseCase {}

class FakeScanQrParams extends Fake implements ScanQrParams {}

void main() {
  late MockScanQrUseCase mockScanQrUseCase;
  late ProviderContainer container;

  const entity = ScanQrEntity(id: 1, qrcode: 'ABC123-1');

  setUpAll(() {
    registerFallbackValue(
      FakeScanQrParams(),
    );
  });

  setUp(() {
    mockScanQrUseCase = MockScanQrUseCase();
    container = ProviderContainer(
      overrides: [
        scanQrUseCaseProvider.overrideWithValue(mockScanQrUseCase),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('submit returns error when qr code is invalid', () async {
    when(() => mockScanQrUseCase.isValidQrCode('x')).thenReturn(false);

    final result = await container.read(scanQrSubmissionServiceProvider).submit('x');

    expect(result, isA<Error<ScanQrEntity>>());
    expect((result as Error<ScanQrEntity>).message, 'Kode QR tidak valid');
    verify(() => mockScanQrUseCase.isValidQrCode('x')).called(1);
    verifyNever(() => mockScanQrUseCase(any()));
  });

  test('submit returns success when use case succeeds', () async {
    when(() => mockScanQrUseCase.isValidQrCode('ABC123-1')).thenReturn(true);
    when(() => mockScanQrUseCase(any())).thenAnswer((_) async => const Right(entity));

    final result = await container.read(scanQrSubmissionServiceProvider).submit('ABC123-1');

    expect(result, isA<Success<ScanQrEntity>>());
    expect((result as Success<ScanQrEntity>).data, entity);
    verify(() => mockScanQrUseCase.isValidQrCode('ABC123-1')).called(1);
    verify(() => mockScanQrUseCase(any())).called(1);
  });

  test('submit returns error when use case fails', () async {
    const failure = ServerFailure(message: 'Submit failed');
    when(() => mockScanQrUseCase.isValidQrCode('ABC123-1')).thenReturn(true);
    when(() => mockScanQrUseCase(any())).thenAnswer((_) async => const Left(failure));

    final result = await container.read(scanQrSubmissionServiceProvider).submit('ABC123-1');

    expect(result, isA<Error<ScanQrEntity>>());
    expect((result as Error<ScanQrEntity>).message, 'Submit failed');
    verify(() => mockScanQrUseCase.isValidQrCode('ABC123-1')).called(1);
    verify(() => mockScanQrUseCase(any())).called(1);
  });
}
