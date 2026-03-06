import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_entity.dart';
import 'package:pos/features/pre_sign/domain/usecases/get_pre_signs_use_case.dart';
import 'package:pos/features/pre_sign/domain/usecases/get_pre_sign_by_id_use_case.dart';
import 'package:pos/features/pre_sign/presentation/providers/pre_sign_di_provider.dart';

class PreSignController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  // :: Fetch all pre_signs
  Future<Either<String, List<PreSignEntity>>> fetchPreSigns() async {
    final useCase = ref.read(getPreSignsUseCaseProvider);

    final result = await useCase(NoParams());

    return result.fold(
      (failure) => Left(failure.message),
      (entities) => Right(entities),
    );
  }

  // :: Fetch pre_sign by ID
  Future<Either<String, PreSignEntity>> fetchPreSignById(int id) async {
    final useCase = ref.read(getPreSignByIdUseCaseProvider);

    final result = await useCase(GetPreSignByIdParams(id: id));

    return result.fold(
      (failure) => Left(failure.message),
      (entity) => Right(entity),
    );
  }
}

final preSignControllerProvider =
    AsyncNotifierProvider<PreSignController, void>(
        PreSignController.new);
