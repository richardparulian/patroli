import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/features/check_out/presentation/providers/check_out_state_provider.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_create_controller.dart';

class CheckOutNotifier extends Notifier<CheckOutState> {
  @override
  CheckOutState build() {
    return const CheckOutState();
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

  void onCheckOutSuccess() {  
    state = state.copyWith(
      isLoading: false,
      isError: false,
      isSuccess: true,
    );
  }

  void clear() {
    state = const CheckOutState();
  }

  // Future<void> runCheckOut({required XFile image, required String filename, required int branchId}) async {
  //   try {
  //     final preSignCreate = ref.read(preSignCreateProvider.notifier);

  //     await preSignCreate.createPreSign(
  //       request: PreSignCreateRequest(filename: filename),
  //     );

  //     final preSignState = ref.read(preSignCreateProvider);

  //     if (preSignState.hasError) {
  //         setErrorMessage(preSignState.error?.toString() ?? 'Terjadi kesalahan saat membuat presigned URL');
  //         return;
  //     }

  //     final preSign = preSignState.value;

  //     if (preSign == null) {
  //       setErrorMessage('Presigned URL tidak ditemukan');
  //       return;
  //     }

  //     final preSignUpdate = ref.read(preSignUpdateProvider.notifier);

  //     await preSignUpdate.updatePreSign(
  //       url: preSign.url,
  //       image: image,
  //     );

  //     final uploadState = ref.read(preSignUpdateProvider);

  //     if (uploadState.hasError) {
  //       setErrorMessage(uploadState.error?.toString() ?? 'Terjadi kesalahan saat mengupload foto selfie');
  //       return;
  //     }

  //     final checkInController = ref.read(checkInProvider.notifier);

  //     await checkInController.checkIn(
  //       request: CheckInRequest(
  //         branchId: branchId,
  //         selfieCheckIn: preSign.fileUrl,
  //       ),
  //     );

  //     final checkInState = ref.read(checkInProvider);

  //     if (checkInState.hasError) {
  //       setErrorMessage(checkInState.error?.toString() ?? 'Terjadi kesalahan saat melakukan check-in');
  //       return;
  //     }

  //     await Future.delayed(const Duration(milliseconds: 500));

  //     onCheckInSuccess();
  //   } catch (e) {
  //     setErrorMessage(e.toString());
      
  //     return;
  //   }
  // }

  Future<void> runCheckOut({required XFile image, required String filename, required int branchId}) async {
    try {
      setLoading(true);

      // :: Create Presign
      final presign = await _createPresign(filename);

      // :: Upload Image
      await _uploadImage(presign.url, image);

      // :: Call Checkout API
      await _callCheckOut(
        branchId: branchId,
        imageUrl: presign.fileUrl,
      );

      onCheckOutSuccess();

    } catch (e) {
      setErrorMessage(e.toString());
    }
  }

  /// CREATE PRESIGNED URL
  Future<PreSignCreateEntity> _createPresign(String filename) async {

    final notifier = ref.read(preSignCreateProvider.notifier);

    await notifier.createPreSign(
      request: PreSignCreateRequest(filename: filename),
    );

    final state = ref.read(preSignCreateProvider);

    if (state.hasError) {
      setErrorMessage(state.error?.toString() ?? 'Terjadi kesalahan saat membuat presigned URL');
    }

    final preSign = state.value;

    if (preSign == null) {
      setErrorMessage('Presigned URL tidak ditemukan');
    }

    return preSign ?? PreSignCreateEntity.empty();
  }

  /// UPLOAD IMAGE
  Future<void> _uploadImage(String url, XFile image) async {

    final notifier = ref.read(preSignUpdateProvider.notifier);

    await notifier.updatePreSign(
      url: url,
      image: image,
    );

    final state = ref.read(preSignUpdateProvider);

    if (state.hasError) {
      throw Exception(
        state.error?.toString() ??
        'Terjadi kesalahan saat upload foto'
      );
    }
  }

  /// CALL CHECKOUT API
  Future<void> _callCheckOut({
    required int branchId,
    required String imageUrl,
  }) async {

    final controller = ref.read(checkOutProvider.notifier);

    await controller.checkOut(
      request: CheckOutRequest(
        branchId: branchId,
        selfieCheckOut: imageUrl,
      ),
    );

    final state = ref.read(checkOutProvider);

    if (state.hasError) {
      throw Exception(
        state.error?.toString() ??
        'Terjadi kesalahan saat checkout'
      );
    }
  }
}

final checkOutStateProvider = NotifierProvider<CheckOutNotifier, CheckOutState>(CheckOutNotifier.new);