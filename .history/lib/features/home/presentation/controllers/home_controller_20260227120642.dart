import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/core/usecases/usecase.dart';
import 'package:pos/features/auth/presentation/providers/auth_di_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends AsyncNotifier<int> {
  @override
  Future<int> build() async {
    // initial fetch count dari Report feature
    return 0;
  }
  
  Future<Either<Failure, void>> logout() async {
    final logoutUseCase = ref.read(logoutUseCaseProvider);
    final result = await logoutUseCase(NoParams());
    return result;
  }
}
