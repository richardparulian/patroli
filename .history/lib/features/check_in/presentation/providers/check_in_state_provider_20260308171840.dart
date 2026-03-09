import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/presentation/controllers/check_in_controller.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_create_controller.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_update_controller.dart';

// enum CheckInLoadingStep {
//   idle,
//   takingPhoto,
//   creatingPresignedUrl,
//   uploadingImage,
//   checkingIn,
// }

enum CheckInLoadingStep {
  processing,
}

class CheckInState {
  // final CheckInLoadingStep currentStep;
  // final String? errorMessage;
  
  // const CheckInState({
  //   this.currentStep = CheckInLoadingStep.idle,
  //   this.errorMessage,
  // });

  // CheckInState copyWith({CheckInLoadingStep? currentStep, String? errorMessage}) {
  //   return CheckInState(
  //     currentStep: currentStep ?? this.currentStep,
  //     errorMessage: errorMessage ?? this.errorMessage,
  //   );
  // }

  // bool get isLoading => currentStep != CheckInLoadingStep.idle;
  
  // String get loadingMessage {
  //   switch (currentStep) {
  //     case CheckInLoadingStep.takingPhoto:
  //       return 'Mengambil foto...';
  //     case CheckInLoadingStep.creatingPresignedUrl:
  //       return 'Mempersiapkan upload...';
  //     case CheckInLoadingStep.uploadingImage:
  //       return 'Mengupload foto selfie...';
  //     case CheckInLoadingStep.checkingIn:
  //       return 'Memproses check-in...';
  //     case CheckInLoadingStep.idle:
  //       return '';
  //   }
  // }

  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const CheckInState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
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

  // void setStep(CheckInLoadingStep step) {
  //   state = state.copyWith(currentStep: step);
  // }

  // void setError(String errorMessage) {
  //   state = state.copyWith(
  //     currentStep: CheckInLoadingStep.idle,
  //     errorMessage: errorMessage,
  //   );
  // }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void markSuccess() {  // ← Method baru
    state = const CheckInState(isSuccess: true);
  }

  void clear() {
    state = const CheckInState();
  }

  // Future<void> runCheckIn({required XFile image, required String filename, required int branchId}) async {
  //   try {
  //     state = state.copyWith(currentStep: CheckInLoadingStep.creatingPresignedUrl);
  //     await Future.microtask(() {});

  //     final preSignCreate = ref.read(preSignCreateProvider.notifier);

  //     await preSignCreate.createPreSign(
  //       request: PreSignCreateRequest(filename: filename),
  //     );

  //     final preSignState = ref.read(preSignCreateProvider);

  //     if (preSignState.hasError) {
  //       throw Exception(preSignState.error);
  //     }

  //     final preSign = preSignState.value;
  //     if (preSign == null) {
  //       throw Exception('Presigned URL tidak ditemukan');
  //     }

  //     state = state.copyWith(currentStep: CheckInLoadingStep.uploadingImage);
  //     await Future.microtask(() {});

  //     final preSignUpdate = ref.read(preSignUpdateProvider.notifier);

  //     await preSignUpdate.updatePreSign(
  //       url: preSign.url,
  //       image: image,
  //     );

  //     final uploadState = ref.read(preSignUpdateProvider);

  //     if (uploadState.hasError) {
  //       throw Exception(uploadState.error);
  //     }

  //     state = state.copyWith(currentStep: CheckInLoadingStep.checkingIn);
  //     await Future.microtask(() {});

  //     final checkInController = ref.read(checkInProvider.notifier);

  //     await checkInController.checkIn(
  //       request: CheckInRequest(
  //         branchId: branchId,
  //         selfieCheckIn: preSign.fileUrl,
  //       ),
  //     );

  //     state = const CheckInState();
  //   } catch (e) {
  //     state = state.copyWith(
  //       currentStep: CheckInLoadingStep.idle,
  //       errorMessage: e.toString(),
  //     );
  //   }
  // }
  Future<void> runCheckIn({required XFile image, required String filename, required int branchId}) async {
    try {
      await Future.microtask(() {});

      final preSignCreate = ref.read(preSignCreateProvider.notifier);

      await preSignCreate.createPreSign(
        request: PreSignCreateRequest(filename: filename),
      );

      final preSignState = ref.read(preSignCreateProvider);

      if (preSignState.hasError) {
        throw Exception(preSignState.error);
      }

      final preSign = preSignState.value;

      if (preSign == null) {
        throw Exception('Presigned URL tidak ditemukan');
      }

      final preSignUpdate = ref.read(preSignUpdateProvider.notifier);

      await preSignUpdate.updatePreSign(
        url: preSign.url,
        image: image,
      );

      final uploadState = ref.read(preSignUpdateProvider);

      if (uploadState.hasError) {
        throw Exception(uploadState.error);
      }

      final checkInController = ref.read(checkInProvider.notifier);

      await checkInController.checkIn(
        request: CheckInRequest(
          branchId: branchId,
          selfieCheckIn: preSign.fileUrl,
        ),
      );

      state = const CheckInState(isSuccess: true);
    } catch (e) {
      state = CheckInState(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}

final checkInStateProvider = NotifierProvider<CheckInNotifier, CheckInState>(CheckInNotifier.new);