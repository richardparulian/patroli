import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
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
  final bool isError;
  final bool isInitialized;
  final String? errorMessage;
  final CheckInEntity? checkInData;
  
  const CheckInState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.isInitialized = false,
    this.errorMessage,
    this.checkInData,
  });

  CheckInState copyWith({bool? isLoading, bool? isSuccess, bool? isError, bool? isInitialized, String? errorMessage, CheckInEntity? checkInData}) {
    return CheckInState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      isInitialized: isInitialized ?? this.isInitialized,
      errorMessage: errorMessage,
      checkInData: checkInData ?? this.checkInData,
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

  void setInitialized(bool isInitialized) {
    state = state.copyWith(isInitialized: isInitialized);
  }

  void setError(bool isError) {
    state = state.copyWith(isError: isError);
  }

  void setErrorMessage(String errorMessage) {
    state = state.copyWith(
      isLoading: false,
      isError: true,
      errorMessage: errorMessage,
    );
  }

  void onCheckInSuccess({CheckInEntity? checkInData}) {  
    state = state.copyWith(
      isLoading: false,
      isError: false,
      isSuccess: true,
      checkInData: checkInData,
    );
  }

  void clear() {
    state = const CheckInState();
  }

  Future<void> runCheckIn({required XFile image, required String filename, required int branchId}) async {
    try {
      final preSignCreate = ref.read(preSignCreateProvider.notifier);

      await preSignCreate.createPreSign(
        request: PreSignCreateRequest(filename: filename),
      );

      final preSignState = ref.read(preSignCreateProvider);

      if (preSignState.hasError) {
          setErrorMessage(preSignState.error?.toString() ?? 'Terjadi kesalahan saat membuat presigned URL');
          return;
      }

      final preSign = preSignState.value;

      if (preSign == null) {
        setErrorMessage('Presigned URL tidak ditemukan');
        return;
      }

      final preSignUpdate = ref.read(preSignUpdateProvider.notifier);

      await preSignUpdate.updatePreSign(
        url: preSign.url ?? '',
        image: image,
      );

      final uploadState = ref.read(preSignUpdateProvider);

      if (uploadState.hasError) {
        setErrorMessage(uploadState.error?.toString() ?? 'Terjadi kesalahan saat mengupload foto selfie');
        return;
      }

      final checkInController = ref.read(checkInProvider.notifier);

      // await checkInController.checkIn(
      //   request: CheckInRequest(
      //     branchId: branchId,
      //     selfieCheckIn: preSign.fileUrl ?? '',
      //   ),
      // );

      final result = await checkInController.checkIn(
        request: CheckInRequest(
          branchId: branchId,
          selfieCheckIn: preSign.fileUrl ?? '',
        ),
      );

      final checkInState = ref.read(checkInProvider);

      if (checkInState.hasError) {
        setErrorMessage(checkInState.error?.toString() ?? 'Terjadi kesalahan saat melakukan check-in');
        return;
      }

      await Future.delayed(const Duration(milliseconds: 500));

      onCheckInSuccess(
        checkInData: checkInState.value ?? CheckInEntity.empty(),
      );
    } catch (e) {
      setErrorMessage(e.toString());
      
      return;
    }
  }
}

final checkInStateProvider = NotifierProvider<CheckInNotifier, CheckInState>(CheckInNotifier.new);