import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/check_in/data/repositories/check_in_repository_impl.dart';
import 'package:pos/features/check_in/domain/usecases/check_in_use_case.dart';

final checkInUseCaseProvider = Provider<CreateCheckInUseCase>((ref) {
  return CreateCheckInUseCase(ref.watch(checkInRepositoryProvider));
});
