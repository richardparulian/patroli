import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/presentation/controllers/check_in_controller.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_create_controller.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_update_controller.dart';

enum CheckInLoadingStep {
  processing,
}

class CheckInState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  
  const CheckInState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  CheckInState copyWith({bool? isLoading, String? errorMessage, bool? isSuccess}) {
    return CheckInState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class CheckInNotifier extends Notifier<CheckInState> {
  @override
  CheckInState build() {
    return const CheckInState();
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setError(String errorMessage) {
    state = CheckInState(
      isLoading: false,
      errorMessage: errorMessage,
    );
  }

  void onCheckInSuccess() {  
    state = const CheckInState(isSuccess: true);
  }

  void clear() {
    state = const CheckInState();
  }

  Future<void> runCheckIn({required XFile image, required String filename, required int branchId}) async {
    try {
      // await Future.microtask(() {});

      final preSignCreate = ref.read(preSignCreateProvider.notifier);

      await preSignCreate.createPreSign(
        request: PreSignCreateRequest(filename: filename),
      );

      final preSignState = ref.read(preSignCreateProvider);

      if (preSignState.hasError) {
          setError(preSignState.error?.toString() ?? 'Terjadi kesalahan saat membuat presigned URL');
          return;
      }

      final preSign = preSignState.value;

      if (preSign == null) {
        setError('Presigned URL tidak ditemukan');
        return;
      }

      final preSignUpdate = ref.read(preSignUpdateProvider.notifier);

      await preSignUpdate.updatePreSign(
        url: preSign.url,
        image: image,
      );

      final uploadState = ref.read(preSignUpdateProvider);

      if (uploadState.hasError) {
        setError(uploadState.error?.toString() ?? 'Terjadi kesalahan saat mengupload foto selfie');
        return;
      }

      final checkInController = ref.read(checkInProvider.notifier);

      await checkInController.checkIn(
        request: CheckInRequest(
          branchId: branchId,
          selfieCheckIn: preSign.fileUrl,
        ),
      );

      final checkInState = ref.read(checkInProvider);

      if (checkInState.hasError) {
        setError(checkInState.error?.toString() ?? 'Terjadi kesalahan saat melakukan check-in');
        return;
      }

      await Future.delayed(const Duration(milliseconds: 500));

      onCheckInSuccess();
    } catch (e) {
      setError(e.toString());
      return;
    }
  }
}

final checkInStateProvider = NotifierProvider<CheckInNotifier, CheckInState>(CheckInNotifier.new);