import 'package:patroli/features/check_in/data/repositories/check_in_repository_impl.dart';
import 'package:patroli/features/check_in/domain/usecases/check_in_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_in_di_provider.g.dart';

@riverpod
CreateCheckInUseCase checkInUseCase(Ref ref) {
  return CreateCheckInUseCase(ref.watch(checkInRepositoryProvider));
}
