import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:pos/features/pre_sign/domain/usecases/pre_sign_create_use_case.dart';
import 'package:pos/features/pre_sign/presentation/providers/pre_sign_di_provider.dart';

class PreSignCreateNotifier extends AsyncNotifier<PreSignCreateEntity?> { 
  @override
  Future<PreSignCreateEntity?> build() async => null;

  Future<void> createPreSign({required PreSignCreateRequest request}) async {
    state = const AsyncLoading();

    final preSignCreateUseCase = ref.read(preSignCreateUseCaseProvider);
    final result = await preSignCreateUseCase(PreSignCreateParams(request: request));

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (entity) => AsyncData(entity),
    );
  }
}

final preSignCreateProvider = AsyncNotifierProvider.autoDispose<PreSignCreateNotifier, PreSignCreateEntity?>(PreSignCreateNotifier.new);
