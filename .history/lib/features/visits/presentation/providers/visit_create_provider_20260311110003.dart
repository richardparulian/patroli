import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/domain/usecases/visit_use_case.dart';
import 'package:pos/features/visits/presentation/providers/visit_di_provider.dart';

class VisitCreateNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> runVisitCreate({required VisitRequest request, required int reportId}) async {
    final visitUseCase = ref.read(visitUseCaseProvider);

    final result = await visitUseCase(CreateVisitParams(
      request: request,
      reportId: reportId,
    ));

    return result.fold(
      (failure) => state = Error(failure.message),
      (_) => state = const Success(null),
    );
  }
}

final visitCreateProvider = NotifierProvider<VisitCreateNotifier, ResultState<void>>(VisitCreateNotifier.new);