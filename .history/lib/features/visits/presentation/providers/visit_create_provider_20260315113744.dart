import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/visits/application/services/visit_create_service.dart';
import 'package:pos/features/visits/data/dtos/request/visit_request.dart';
import 'package:pos/features/visits/domain/entities/visit_entity.dart';

class VisitCreateNotifier extends Notifier<ResultState<VisitEntity>> {
  @override
  ResultState<VisitEntity> build() {
    return const Idle();
  }

  Future<void> runVisitCreate({required VisitRequest request, required int reportId}) async {
    state = const Loading();
    state = await ref.read(visitCreateServiceProvider).submit(
      request: request,
      reportId: reportId,
    );
  }
}

final visitCreateProvider = NotifierProvider<VisitCreateNotifier, ResultState<VisitEntity>>(VisitCreateNotifier.new);