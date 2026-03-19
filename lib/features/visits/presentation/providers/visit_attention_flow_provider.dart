import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/scan_qr/application/services/scan_qr_submission_service.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';

class VisitAttentionFlowState {
  const VisitAttentionFlowState({
    this.attentionState = const Idle<ScanQrEntity>(),
  });

  final ResultState<ScanQrEntity> attentionState;

  VisitAttentionFlowState copyWith({
    ResultState<ScanQrEntity>? attentionState,
  }) {
    return VisitAttentionFlowState(
      attentionState: attentionState ?? this.attentionState,
    );
  }

  bool get isLoading => attentionState.isLoading;
  bool get isError => attentionState.isError;
  ScanQrEntity? get data => attentionState.dataOrNull;
  String? get errorMessage => attentionState.errorMessage;
}

class VisitAttentionFlowNotifier extends Notifier<VisitAttentionFlowState> {
  @override
  VisitAttentionFlowState build() => const VisitAttentionFlowState();

  Future<void> fetchAttention(String qrCode) async {
    state = state.copyWith(attentionState: const Loading<ScanQrEntity>());

    final result = await ref
        .read(scanQrSubmissionServiceProvider)
        .submit(qrCode);

    if (!ref.mounted) return;

    state = state.copyWith(attentionState: result);
  }
}

final visitAttentionFlowProvider =
    NotifierProvider.autoDispose<
      VisitAttentionFlowNotifier,
      VisitAttentionFlowState
    >(VisitAttentionFlowNotifier.new);
