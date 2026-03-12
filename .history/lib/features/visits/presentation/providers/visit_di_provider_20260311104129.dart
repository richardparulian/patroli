import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/check_out/data/repositories/check_out_repository_impl.dart';
import 'package:pos/features/check_out/domain/usecases/check_out_use_case.dart';

final checkOutUseCaseProvider = Provider<CreateCheckOutUseCase>((ref) {
  return CreateCheckOutUseCase(ref.watch(checkOutRepositoryProvider));
});
