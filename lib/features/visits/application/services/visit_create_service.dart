import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/visits/application/providers/visit_di_provider.dart';
import 'package:patroli/features/visits/data/dtos/request/visit_request.dart';
import 'package:patroli/features/visits/domain/entities/visit_entity.dart';
import 'package:patroli/features/visits/domain/usecases/visit_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'visit_create_service.g.dart';

class VisitCreateService {
  VisitCreateService(this.ref);

  final Ref ref;

  Future<ResultState<VisitEntity>> submit({
    required VisitRequest request,
    required int reportId,
  }) async {
    try {
      final visitUseCase = ref.read(visitUseCaseProvider);
      final result = await visitUseCase(
        CreateVisitParams(
          request: request,
          reportId: reportId,
        ),
      );

      return result.fold(
        (failure) => Error(failure.message),
        (value) => Success(value),
      );
    } catch (e) {
      return Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

@riverpod
VisitCreateService visitCreateService(Ref ref) {
  return VisitCreateService(ref);
}
