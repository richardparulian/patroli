import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/domain/usecases/visit_use_case.dart';
import 'package:pos/features/visits/presentation/providers/visit_di_provider.dart';
import 'package:pos/features/visits/presentation/providers/visit_form_provider.dart';

class VisitCreateNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  Future<void> runVisitCreate({required VisitRequest request, required int reportId}) async {
    final visitUseCase = ref.read(visitUseCaseProvider);

    // final result = await visitUseCase(CreateVisitParams(
    //   request: request,
    //   reportId: reportId,
    // ));

    debugPrint('request: $request');

    // if (!ref.mounted) return;
    // return result.fold(
    //   (failure) {
    //     if (failure is InputFailure && failure.errors != null) {
    //       ref.read(visitFormProvider.notifier).setErrors(failure.errors!);
    //     }

    //     state = Error(failure.message);
    //   },
    //   (_) => state = const Success(null),
    // );
  }
}

final visitCreateProvider = NotifierProvider<VisitCreateNotifier, ResultState<void>>(VisitCreateNotifier.new);