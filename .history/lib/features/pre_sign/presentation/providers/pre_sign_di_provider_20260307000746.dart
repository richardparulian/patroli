import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/pre_sign/data/repositories/pre_sign_repository_impl.dart';
import 'package:pos/features/pre_sign/domain/usecases/get_pre_signs_use_case.dart';
import 'package:pos/features/pre_sign/domain/usecases/get_pre_sign_by_id_use_case.dart';

final getPreSignsUseCaseProvider = Provider<GetPreSignsUseCase>((ref) {
  return GetPreSignsUseCase(ref.watch(preSignRepositoryProvider));
});

final getPreSignByIdUseCaseProvider = Provider<GetPreSignByIdUseCase>((ref) {
  return GetPreSignByIdUseCase(ref.watch(preSignRepositoryProvider));
});
