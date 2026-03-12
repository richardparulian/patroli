import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/domain/entities/visit_entity.dart';
import 'package:pos/features/visits/domain/usecases/visit_use_case.dart';
import 'package:pos/features/visits/presentation/providers/visit_di_provider.dart';

class VisitCreateNotifier extends Notifier<ResultState<VisitEntity>> {
  @override
  ResultState<VisitEntity> build() {
    return const Idle();
  }

  Future<void> runVisitCreate({required VisitRequest request, required int reportId}) async {
    state = const Loading();
    
    try {
      final visitUseCase = ref.read(visitUseCaseProvider);

      debugPrint('request: $request');

      // final result = await visitUseCase(CreateVisitParams(
      //   request: request,
      //   reportId: reportId,
      // ));

      // result.fold(
      //   (failure) => state = Error(failure.message),
      //   (value) => state = Success(value),
      // );
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

final visitCreateProvider = NotifierProvider<VisitCreateNotifier, ResultState<VisitEntity>>(VisitCreateNotifier.new);