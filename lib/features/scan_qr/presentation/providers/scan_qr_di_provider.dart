import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/scan_qr/data/repositories/scan_qr_repository_impl.dart';
import 'package:pos/features/scan_qr/domain/usecases/scan_qr_use_case.dart';

final scanQrUseCaseProvider = Provider<ScanQrUseCase>((ref) {
  return ScanQrUseCase(ref.watch(scanQrRepositoryProvider));
});
