import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/visits/data/repositories/visit_repository_impl.dart';
import 'package:pos/features/visits/domain/usecases/visit_use_case.dart';

final visitUseCaseProvider = Provider<CreateVisitUseCase>((ref) {
  return CreateVisitUseCase(ref.watch(visitRepositoryProvider));
});
