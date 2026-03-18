import 'package:patroli/features/check_out/application/providers/check_out_data_providers.dart';
import 'package:patroli/features/check_out/domain/usecases/check_out_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_out_di_provider.g.dart';

@riverpod
CreateCheckOutUseCase checkOutUseCase(Ref ref) {
  return CreateCheckOutUseCase(ref.watch(checkOutRepositoryProvider));
}
