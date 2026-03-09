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

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void onCheckInSuccess() {  
    state = const CheckInState(isSuccess: true);
  }

  void clear() {
    state = const CheckInState();
  }

  Future<void> runCheckIn({required XFile image, required String filename, required int branchId}) async {
    try {
      await Future.microtask(() {});

      final preSignCreate = ref.read(preSignCreateProvider.notifier);

      await preSignCreate.createPreSign(
        request: PreSignCreateRequest(filename: filename),
      );

      final preSignState = ref.read(preSignCreateProvider);

      if (preSignState.hasError) {
        state = CheckInState(
          isLoading: false,
          errorMessage: preSignState.error?.toString(),
        );
        return;
      }

      final preSign = preSignState.value;

      if (preSign == null) {
        state = CheckInState(
          isLoading: false,
          errorMessage: 'Presigned URL tidak ditemukan',
        );
        return;
      }

      final preSignUpdate = ref.read(preSignUpdateProvider.notifier);

      await preSignUpdate.updatePreSign(
        url: preSign.url,
        image: image,
      );

      final uploadState = ref.read(preSignUpdateProvider);

      if (uploadState.hasError) {
        state = CheckInState(
          isLoading: false,
          errorMessage: uploadState.error?.toString(),
        );
        return;
      }

      final checkInController = ref.read(checkInProvider.notifier);

      await checkInController.checkIn(
        request: CheckInRequest(
          branchId: 10,
          selfieCheckIn: preSign.fileUrl,
        ),
      );

      final checkInState = ref.read(checkInProvider);

      if (checkInState.hasError) {
        state = CheckInState(
          isLoading: false,
          errorMessage: checkInState.error?.toString(),
        );
        return;
      }

      await Future.delayed(const Duration(milliseconds: 500));

      onCheckInSuccess();
    } catch (e) {
      state = CheckInState(
        isLoading: false,
        errorMessage: e.toString(),
      );

      return;
    }
  }
}

final checkInStateProvider = NotifierProvider<CheckInNotifier, CheckInState>(CheckInNotifier.new);