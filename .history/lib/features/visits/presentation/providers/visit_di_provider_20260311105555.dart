import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/check_out/data/repositories/check_out_repository_impl.dart';
import 'package:pos/features/check_out/domain/usecases/check_out_use_case.dart';
import 'package:pos/features/visits/data/repositories/visit_repository_impl.dart';

final visitUseCaseProvider = Provider<CreateVisitUseCase>((ref) {
  return CreateVisitUseCase(ref.watch(visitRepositoryProvider));
});
