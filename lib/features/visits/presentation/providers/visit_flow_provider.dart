import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/visits/application/services/visit_create_service.dart';
import 'package:patroli/features/visits/data/dtos/request/visit_request.dart';
import 'package:patroli/features/visits/domain/entities/visit_entity.dart';
import 'package:patroli/features/visits/presentation/providers/visit_form_provider.dart';

class VisitFlowState {
  const VisitFlowState({this.submissionState = const Idle<VisitEntity?>()});

  final ResultState<VisitEntity?> submissionState;

  VisitFlowState copyWith({ResultState<VisitEntity?>? submissionState}) {
    return VisitFlowState(
      submissionState: submissionState ?? this.submissionState,
    );
  }

  bool get isSubmitting => submissionState.isLoading;
}

class VisitFlowNotifier extends Notifier<VisitFlowState> {
  @override
  VisitFlowState build() => const VisitFlowState();

  Future<bool> submit({required int reportId, required String notes}) async {
    final formNotifier = ref.read(visitFormProvider.notifier);
    final isValid = formNotifier.validate();

    if (!isValid) return false;

    final form = ref.read(visitFormProvider);
    state = state.copyWith(submissionState: const Loading());

    final result = await ref
        .read(visitCreateServiceProvider)
        .submit(
          request: VisitRequest(
            lightsStatus: form.lampuBanner ?? '',
            bannerStatus: form.bannerUtama ?? '',
            rollingDoorStatus: form.rollingDoor ?? '',
            conditionRight: form.conditionRight ?? '',
            conditionLeft: form.conditionLeft ?? '',
            conditionBack: form.conditionBack ?? '',
            conditionAround: form.conditionAround ?? '',
            notes: notes,
          ),
          reportId: reportId,
        );

    if (!ref.mounted) return true;

    state = state.copyWith(submissionState: result);
    return true;
  }

  void resetSubmission() {
    state = state.copyWith(submissionState: const Idle());
  }
}

final visitFlowProvider =
    NotifierProvider.autoDispose<VisitFlowNotifier, VisitFlowState>(
      VisitFlowNotifier.new,
    );
