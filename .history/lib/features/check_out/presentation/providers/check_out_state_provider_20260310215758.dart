import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/presentation/controllers/check_in_controller.dart';
import 'package:pos/features/pre_sign/data/dtos/request/pre_sign_create_request.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_create_controller.dart';
import 'package:pos/features/pre_sign/presentation/controllers/pre_sign_update_controller.dart';

enum CheckOutLoadingStep {
  processing,
}

class CheckOutState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final bool isInitialized;
  final String? errorMessage;
  
  const CheckOutState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.isInitialized = false,
    this.errorMessage,
  });

  CheckOutState copyWith({bool? isLoading, bool? isSuccess, bool? isError, bool? isInitialized, String? errorMessage}) {
    return CheckOutState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      isInitialized: isInitialized ?? this.isInitialized,
      errorMessage: errorMessage,
    );
  }
}