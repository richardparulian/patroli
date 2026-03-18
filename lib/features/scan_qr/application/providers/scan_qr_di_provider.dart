import 'package:patroli/features/scan_qr/application/providers/scan_qr_data_providers.dart';
import 'package:patroli/features/scan_qr/domain/usecases/scan_qr_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_qr_di_provider.g.dart';

@riverpod
ScanQrUseCase scanQrUseCase(Ref ref) {
  return ScanQrUseCase(ref.watch(scanQrRepositoryProvider));
}
