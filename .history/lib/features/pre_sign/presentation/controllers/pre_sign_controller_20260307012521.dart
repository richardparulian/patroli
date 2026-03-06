import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/usecases/pre_sign_create_use_case.dart';
import 'package:pos/features/pre_sign/presentation/providers/pre_sign_di_provider.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/domain/usecases/scan_qr_use_case.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_di_provider.dart';

class PreSignController extends AsyncNotifier<PreSignEntity?> { 
  @override
  Future<PreSignEntity?> build() async => null;

  Future<void> createPreSign({required PreSignRequest request}) async {
    state = const AsyncLoading();

    final preSignCreateUseCase = ref.read(preSignCreateUseCaseProvider);
    final result = await preSignCreateUseCase(PreSignCreateParams(request: request));

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (entity) => AsyncData(entity),
    );
  }
}

final preSignProvider = AsyncNotifierProvider<PreSignController, PreSignEntity?>(PreSignController.new);
