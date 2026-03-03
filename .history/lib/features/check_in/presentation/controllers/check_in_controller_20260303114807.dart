import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_in/domain/usecases/get_check_ins_use_case.dart';
import 'package:pos/features/check_in/domain/usecases/get_check_in_by_id_use_case.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_di_provider.dart';

class CheckInController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  // :: Fetch all check_ins
  Future<Either<String, List<CheckInEntity>>> fetchCheckIns() async {
    final useCase = ref.read(getCheckInsUseCaseProvider);

    final result = await useCase(NoParams());

    return result.fold(
      (failure) => Left(failure.message),
      (entities) => Right(entities),
    );
  }

  // :: Fetch check_in by ID
  Future<Either<String, CheckInEntity>> fetchCheckInById(int id) async {
    final useCase = ref.read(getCheckInByIdUseCaseProvider);

    final result = await useCase(GetCheckInByIdParams(id: id));

    return result.fold(
      (failure) => Left(failure.message),
      (entity) => Right(entity),
    );
  }
}

final checkInControllerProvider =
    AsyncNotifierProvider<CheckInController, void>(
        CheckInController.new);
