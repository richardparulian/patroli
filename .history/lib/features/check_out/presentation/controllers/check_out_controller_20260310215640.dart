import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/check_in/data/dtos/request/check_in_request.dart';
import 'package:pos/features/check_in/domain/entities/check_in_entity.dart';
import 'package:pos/features/check_in/domain/usecases/check_in_use_case.dart';
import 'package:pos/features/check_in/presentation/providers/check_in_di_provider.dart';
import 'package:pos/features/check_out/data/dtos/request/check_out_request.dart';
import 'package:pos/features/check_out/domain/entities/check_out_entity.dart';
import 'package:pos/features/check_out/domain/usecases/check_out_use_case.dart';
import 'package:pos/features/check_out/presentation/providers/check_out_di_provider.dart';

class CheckOutController extends AsyncNotifier<CheckOutEntity?> { 
  @override
  Future<CheckOutEntity?> build() async => null;

  Future<void> checkOut({required CheckOutRequest request}) async {
    state = const AsyncLoading();

    final checkOutUseCase = ref.read(checkOutUseCaseProvider);
    final result = await checkOutUseCase(CreateCheckOutParams(request: request));

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (checkIn) => AsyncData(checkIn),
    );
  }
}

final checkOutProvider = AsyncNotifierProvider<CheckOutController, CheckOutEntity?>(CheckOutController.new);
