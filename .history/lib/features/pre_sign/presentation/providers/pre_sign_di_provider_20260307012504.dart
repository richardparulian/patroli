import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/pre_sign/data/repositories/pre_sign_repository_impl.dart';
import 'package:pos/features/pre_sign/domain/usecases/pre_sign_create_use_case.dart';

final preSignCreateUseCaseProvider = Provider<PreSignCreateUseCase>((ref) {
  return PreSignCreateUseCase(ref.watch(preSignRepositoryProvider));
});
