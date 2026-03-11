import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/reports/domain/entities/reports_entity.dart';
import 'package:pos/features/reports/domain/usecases/reports_use_case.dart';
import 'package:pos/features/reports/presentation/providers/reports_di_provider.dart';
import 'package:pos/features/scan_qr/data/dtos/request/scan_qr_request.dart';
import 'package:pos/features/scan_qr/domain/entities/scan_qr_entity.dart';
import 'package:pos/features/scan_qr/presentation/controllers/scan_qr_controller.dart';
import 'package:pos/features/scan_qr/presentation/providers/scan_qr_di_provider.dart';

class ScanQrState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int countPending;
  final String? errorMessage;

  const ScanQrState({
    this.isError = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.countPending = 0,
    this.errorMessage,
  });

  ScanQrState copyWith({
    bool? isError,
    bool? isLoading, 
    bool? isSuccess, 
    int? countPending,
    String? errorMessage, 
  }) {
    return ScanQrState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      countPending: countPending ?? this.countPending,
      errorMessage: errorMessage,
    );
  }
}

class ScanQrNotifier extends Notifier<ScanQrState> {
  @override
  ScanQrState build() {
    return const ScanQrState();
  }

  void setError(bool isError) {
    state = state.copyWith(isError: isError);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setErrorMessage(String message) {
    state = state.copyWith(
      isError: true,
      isLoading: false,
      errorMessage: message,
    );
  }

  void onSuccess(List<ReportsEntity> reports) {
    final count = reports.where((r) => r.statusValue == 1).length;

    state = state.copyWith(
      isLoading: false,
      isError: false,
      isSuccess: true,
      countPending: count,
    );
  }

  void clear() {
    state = const ScanQrState();
  }

  Future<void> getReports({required int page, required int limit}) async {
    setLoading(true);
    
    try {
      final reportsUseCase = ref.read(reportsUseCaseProvider);
      final result = await reportsUseCase(
        ReportsParams(page: page, limit: limit),
      );

      if (result.hasError) {
        setErrorMessage(result.error?.toString() ?? 'Gagal mengambil laporan');
        return;
      }
      await Future.delayed(const Duration(milliseconds: 500));
      onSuccess(result.value ?? []);
    } catch (e) {
      setErrorMessage(e.toString());
      return;
    }
  }
}

final scanQrStateProvider = NotifierProvider<ScanQrNotifier, ScanQrState>(ScanQrNotifier.new);
