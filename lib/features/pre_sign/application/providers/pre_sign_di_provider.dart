import 'package:patroli/features/pre_sign/application/providers/pre_sign_data_providers.dart';
import 'package:patroli/features/pre_sign/domain/usecases/pre_sign_create_use_case.dart';
import 'package:patroli/features/pre_sign/domain/usecases/pre_sign_update_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pre_sign_di_provider.g.dart';

@riverpod
PreSignCreateUseCase preSignCreateUseCase(Ref ref) {
  return PreSignCreateUseCase(ref.watch(preSignRepositoryProvider));
}

@riverpod
PreSignUpdateUseCase preSignUpdateUseCase(Ref ref) {
  return PreSignUpdateUseCase(ref.watch(preSignRepositoryProvider));
}
