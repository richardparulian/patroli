import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/usecases/get_scan_qrs_use_case.dart';
import 'package:pos/features/scan_qr/domain/usecases/get_scan_qr_by_id_use_case.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_di_provider.dart';

class ScanQrController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  // :: Fetch all scan_qrs
  Future<Either<String, List<ScanQrEntity>>> fetchScanQrs() async {
    final useCase = ref.read(getScanQrsUseCaseProvider);

    final result = await useCase(NoParams());

    return result.fold(
      (failure) => Left(failure.message),
      (entities) => Right(entities),
    );
  }

  // :: Fetch scan_qr by ID
  Future<Either<String, ScanQrEntity>> fetchScanQrById(int id) async {
    final useCase = ref.read(getScanQrByIdUseCaseProvider);

    final result = await useCase(GetScanQrByIdParams(id: id));

    return result.fold(
      (failure) => Left(failure.message),
      (entity) => Right(entity),
    );
  }
}

final scanQrControllerProvider =
    AsyncNotifierProvider<ScanQrController, void>(
        ScanQrController.new);
