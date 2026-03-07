import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/usecases/pre_sign_create_use_case.dart';
import 'package:pos/features/pre_sign/domain/usecases/pre_sign_update_use_case.dart';
import 'package:pos/features/pre_sign/presentation/providers/pre_sign_di_provider.dart';

class PreSignController extends AsyncNotifier<PreSignEntity?> { 
  @override
  Future<PreSignEntity?> build() async => null;

  Future<void> createPreSign({required PreSignRequest request}) async {
    state = const AsyncLoading();

    final preSignCreateUseCase = ref.read(preSignCreateUseCaseProvider);
    final result = await preSignCreateUseCase(PreSignCreateParams(request: request));

    debugPrint('result: $result');

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (entity) => AsyncData(entity),
    );
  }

  Future<void> updatePreSign({required String url}) async {
    state = const AsyncLoading();

    final preSignUpdateUseCase = ref.read(preSignUpdateUseCaseProvider);
    final result = await preSignUpdateUseCase(PreSignUpdateParams(url: url));

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (entity) => AsyncData(entity),
    );
  }
}

final preSignProvider = AsyncNotifierProvider<PreSignController, PreSignEntity?>(PreSignController.new);
