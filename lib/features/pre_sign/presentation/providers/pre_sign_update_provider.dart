import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_update_entity.dart';
import 'package:pos/features/pre_sign/domain/usecases/pre_sign_update_use_case.dart';
import 'package:pos/features/pre_sign/presentation/providers/pre_sign_di_provider.dart';

class PreSignUpdateNotifier extends AsyncNotifier<PreSignUpdateEntity?> { 
  @override
  Future<PreSignUpdateEntity?> build() async => null;

  Future<void> updatePreSign({required String url, required XFile image}) async {
    state = const AsyncLoading();

    final preSignUpdateUseCase = ref.read(preSignUpdateUseCaseProvider);
    final result = await preSignUpdateUseCase(PreSignUpdateParams(url: url, image: image));

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (response) => AsyncData(response),
    );
  }
}

final preSignUpdateProvider = AsyncNotifierProvider<PreSignUpdateNotifier, PreSignUpdateEntity?>(PreSignUpdateNotifier.new);
