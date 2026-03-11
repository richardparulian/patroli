import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:pos/features/check_out/domain/usecases/check_out_use_case.dart';
import 'package:pos/features/check_out/presentation/providers/check_out_di_provider.dart';
// import 'package:pos/features/check_out/presentation/providers/check_out_state_provider.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_create_controller.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_update_controller.dart';

// class CheckOutNotifier extends Notifier<CheckOutState> {
//   @override
//   CheckOutState build() {
//     return const CheckOutState();
//   }

//   void setLoading(bool isLoading) {
//     state = state.copyWith(isLoading: isLoading);
//   }

//   void setInitialized(bool isInitialized) {
//     state = state.copyWith(isInitialized: isInitialized);
//   }

//   void setError(bool isError) {
//     state = state.copyWith(isError: isError);
//   }

//   void setErrorMessage(String errorMessage) {
//     state = state.copyWith(
//       isLoading: false,
//       isError: true,
//       errorMessage: errorMessage,
//     );
//   }

//   void onCheckOutSuccess() {  
//     state = state.copyWith(
//       isLoading: false,
//       isError: false,
//       isSuccess: true,
//     );
//   }

//   void clear() {
//     state = const CheckOutState();
//   }

//   Future<void> runCheckOut({required XFile image, required String filename, required int branchId}) async {
//     try {
//       setLoading(true);

//       // :: Create Presign
//       final presign = await _createPresign(filename);

//       // :: Upload Image
//       await _uploadImage(presign.url, image);

//       // :: Call Checkout API
//       await _callCheckOut(
//         branchId: branchId,
//         imageUrl: presign.fileUrl ?? '',
//       );
//     } catch (e) {
//       setErrorMessage(e.toString());
//     } finally {
//       setLoading(false);
//     }
//   }

//   // :: CREATE PRESIGNED URL
//   Future<PreSignCreateEntity> _createPresign(String filename) async {

//     final notifier = ref.read(preSignCreateProvider.notifier);

//     await notifier.createPreSign(
//       request: PreSignCreateRequest(filename: filename),
//     );

//     final state = ref.read(preSignCreateProvider);

//     if (state.hasError) {
//       throw Exception(state.error?.toString() ?? 'Terjadi kesalahan saat membuat presigned URL');
//     }

//     final preSign = state.value;

//     if (preSign == null) {
//       throw Exception('Presigned URL tidak ditemukan');
//     }

//     return preSign;
//   }

//   // :: UPLOAD IMAGE
//   Future<void> _uploadImage(String? url, XFile image) async {

//     if (url == null) {
//       throw Exception('Presigned URL tidak ditemukan');
//     }

//     final notifier = ref.read(preSignUpdateProvider.notifier);

//     await notifier.updatePreSign(
//       url: url,
//       image: image,
//     );

//     final state = ref.read(preSignUpdateProvider);

//     if (state.hasError) {
//       throw Exception(state.error?.toString() ?? 'Terjadi kesalahan saat upload foto');
//     }
//   }

//   // :: CALL CHECKOUT API
//   Future<void> _callCheckOut({required int branchId, required String imageUrl}) async {
//     final checkOutUseCase = ref.read(checkOutUseCaseProvider);

//     final result = await checkOutUseCase(
//       CreateCheckOutParams(
//         request: CheckOutRequest(
//           branchId: branchId,
//           selfieCheckOut: imageUrl,
//         ),
//       ),
//     );

//     result.fold(
//       (failure) => setErrorMessage(failure.message),
//       (response) => onCheckOutSuccess(),
//     );
//   }
// }

// final checkOutNotifierProvider = NotifierProvider<CheckOutNotifier, CheckOutState>(CheckOutNotifier.new);

class CheckOutNotifier extends Notifier<ResultState<void>> {
  @override
  ResultState<void> build() {
    return const Idle();
  }

  void setLoading() {
    state = const Loading();
  }

  Future<void> runCheckOut({required XFile image, required String filename, required int branchId}) async {
    try {
      final presign = (await _createPresign(filename)).dataOrThrow;

      (await _uploadImage(presign.url, image)).dataOrThrow;
      (await _callCheckOut(branchId: branchId, imageUrl: presign.fileUrl ?? '')).dataOrThrow;

      state = const Success(null);
    } catch (e) {
      state = Error(e.toString().replaceFirst('Exception: ', ''));

    }
  }

  Future<ResultState<PreSignCreateEntity>> _createPresign(String filename) async {
    final notifier = ref.read(preSignCreateProvider.notifier);

    await notifier.createPreSign(
      request: PreSignCreateRequest(filename: filename),
    );

    final state = ref.read(preSignCreateProvider);

    if (state.hasError) {
      return const Error('Terjadi kesalahan saat membuat presigned URL');
    }

    final presign = state.value;

    if (presign == null) {
      return const Error('Presigned URL tidak ditemukan');
    }

    return Success(presign);
  }

  Future<ResultState<void>> _uploadImage(String? url, XFile image) async {
    if (url == null) {
      return const Error('Presigned URL tidak ditemukan');
    }

    final notifier = ref.read(preSignUpdateProvider.notifier);

    await notifier.updatePreSign(
      url: url,
      image: image,
    );

    final state = ref.read(preSignUpdateProvider);

    if (state.hasError) {
      return const Error('Terjadi kesalahan saat upload foto');
    }

    return const Success(null);
  }

  Future<ResultState<void>> _callCheckOut({required int branchId, required String imageUrl}) async {
    final checkOutUseCase = ref.read(checkOutUseCaseProvider);

    final result = await checkOutUseCase(
      CreateCheckOutParams(
        request: CheckOutRequest(
          branchId: branchId,
          selfieCheckOut: imageUrl,
        ),
      ),
    );

    return result.fold(
      (failure) => Error(failure.message),
      (_) => const Success(null),
    );
  }
}

final checkOutProvider = NotifierProvider<CheckOutNotifier, ResultState<void>>(CheckOutNotifier.new);