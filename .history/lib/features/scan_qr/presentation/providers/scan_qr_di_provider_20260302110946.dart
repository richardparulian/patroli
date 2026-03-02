import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/scan_qr/data/repositories/scan_qr_repository_impl.dart';
import 'package:pos/features/scan_qr/domain/usecases/get_scan_qrs_use_case.dart';
import 'package:pos/features/scan_qr/domain/usecases/get_scan_qr_by_id_use_case.dart';

final getScanQrsUseCaseProvider = Provider<GetScanQrsUseCase>((ref) {
  return GetScanQrsUseCase(ref.watch(scanQrRepositoryProvider));
});

final getScanQrByIdUseCaseProvider = Provider<GetScanQrByIdUseCase>((ref) {
  return GetScanQrByIdUseCase(ref.watch(scanQrRepositoryProvider));
});
