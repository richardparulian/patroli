import 'package:patroli/features/visits/data/repositories/visit_repository_impl.dart';
import 'package:patroli/features/visits/domain/usecases/visit_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'visit_di_provider.g.dart';

@riverpod
CreateVisitUseCase visitUseCase(Ref ref) {
  return CreateVisitUseCase(ref.watch(visitRepositoryProvider));
}
