import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:pos/features/pre_sign/domain/usecases/pre_sign_create_use_case.dart';
import 'package:pos/features/pre_sign/presentation/providers/pre_sign_di_provider.dart';

class PreSignCreateController extends AsyncNotifier<PreSignCreateEntity?> { 
  @override
  Future<PreSignCreateEntity?> build() async => null;

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

final preSignCreateProvider = AsyncNotifierProvider<PreSignCreateController, PreSignCreateEntity?>(PreSignCreateController.new);
