import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/core/services/permission_service.dart';
import 'package:patroli/features/scan_qr/application/services/scan_qr_submission_service.dart';
import 'package:patroli/features/scan_qr/domain/entities/scan_qr_entity.dart';

class ScanQrFlowState {
  const ScanQrFlowState({
    this.isTorchOn = false,
    this.isProcessing = false,
    this.isCameraPermissionGranted,
    this.scanState = const Idle<ScanQrEntity>(),
  });

  final bool isTorchOn;
  final bool isProcessing;
  final bool? isCameraPermissionGranted;
  final ResultState<ScanQrEntity> scanState;

  ScanQrFlowState copyWith({
    bool? isTorchOn,
    bool? isProcessing,
    Object? isCameraPermissionGranted = _unset,
    ResultState<ScanQrEntity>? scanState,
  }) {
    return ScanQrFlowState(
      isTorchOn: isTorchOn ?? this.isTorchOn,
      isProcessing: isProcessing ?? this.isProcessing,
      isCameraPermissionGranted: identical(isCameraPermissionGranted, _unset)
          ? this.isCameraPermissionGranted
          : isCameraPermissionGranted as bool?,
      scanState: scanState ?? this.scanState,
    );
  }

  static const _unset = Object();

  bool get isLoading => scanState.isLoading;
  bool get isError => scanState.isError;
  String? get errorMessage => scanState.errorMessage;
  ScanQrEntity? get scannedEntity => scanState.dataOrNull;
}

class ScanQrFlowNotifier extends Notifier<ScanQrFlowState> {
  @override
  ScanQrFlowState build() => const ScanQrFlowState();

  Future<bool> checkCameraPermission() async {
    final hasPermission =
        await PermissionService.checkAndRequestCameraPermission();

    if (!ref.mounted) return false;

    state = state.copyWith(isCameraPermissionGranted: hasPermission);
    return hasPermission;
  }

  Future<void> toggleTorch(MobileScannerController controller) async {
    await controller.toggleTorch();

    if (!ref.mounted) return;

    state = state.copyWith(isTorchOn: !state.isTorchOn);
  }

  void resetProcessing() {
    state = state.copyWith(isProcessing: false);
  }

  void resetScanState() {
    state = state.copyWith(
      isProcessing: false,
      scanState: const Idle<ScanQrEntity>(),
    );
  }

  void setGalleryNotFoundError(String message) {
    state = state.copyWith(
      isProcessing: false,
      scanState: Error<ScanQrEntity>(message),
    );
  }

  Future<void> handleScannedCode(String qrCode) async {
    if (state.isLoading || state.isProcessing) return;

    state = state.copyWith(
      isProcessing: true,
      scanState: const Loading<ScanQrEntity>(),
    );

    final result = await ref
        .read(scanQrSubmissionServiceProvider)
        .submit(qrCode);

    if (!ref.mounted) return;

    state = state.copyWith(isProcessing: false, scanState: result);
  }
}

final scanQrFlowProvider =
    NotifierProvider.autoDispose<ScanQrFlowNotifier, ScanQrFlowState>(
      ScanQrFlowNotifier.new,
    );
