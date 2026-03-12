// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
// import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
// import 'package:pos/features/check_in/domain/usecases/check_in_use_case.dart';
// import 'package:pos/features/check_in/presentation/providers/check_in_di_provider.dart';

// class CheckInController extends AsyncNotifier<CheckInEntity?> { 
//   @override
//   Future<CheckInEntity?> build() async => null;

//   // Future<void> checkIn({required CheckInRequest request}) async {
//   //   state = const AsyncLoading();

//   //   final checkInUseCase = ref.read(checkInUseCaseProvider);
//   //   final result = await checkInUseCase(CreateCheckInParams(request: request));

//   //   state = result.fold(
//   //     (failure) => AsyncError(failure.message, StackTrace.current),
//   //     (checkIn) => AsyncData(checkIn),
//   //   );
//   // }
// //   Future<CheckInEntity> checkIn({required CheckInRequest request}) async {
// //     state = const AsyncLoading();

// //     final checkInUseCase = ref.read(checkInUseCaseProvider);
// //     final result = await checkInUseCase(CreateCheckInParams(request: request));

// //     return result.fold(
// //       (failure) {
// //         state = AsyncError(failure.message, StackTrace.current);
// //         throw Exception(failure.message);
// //       },
// //       (checkIn) {
// //         debugPrint('checkIn: $checkIn');
// //         state = AsyncData(checkIn);
// //         return checkIn;
// //       },
// //     );
// //   }
// // }

// // final checkInProvider = AsyncNotifierProvider<CheckInController, CheckInEntity?>(CheckInController.new);
