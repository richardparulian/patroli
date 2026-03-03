import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/check_in/data/repositories/check_in_repository_impl.dart';
import 'package:pos/features/check_in/domain/usecases/get_check_ins_use_case.dart';
import 'package:pos/features/check_in/domain/usecases/get_check_in_by_id_use_case.dart';

final getCheckInsUseCaseProvider = Provider<GetCheckInsUseCase>((ref) {
  return GetCheckInsUseCase(ref.watch(checkInRepositoryProvider));
});

final getCheckInByIdUseCaseProvider = Provider<GetCheckInByIdUseCase>((ref) {
  return GetCheckInByIdUseCase(ref.watch(checkInRepositoryProvider));
});
