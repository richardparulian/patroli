import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pos/core/error/failures.dart';
import 'package:pos/features/auth/domain/usecases/logout_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class HomeController extends AsyncNotifier<int> {
  final LogoutUseCase logoutUseCase;

  HomeController({required this.logoutUseCase});
  
  @override
  Future<int> build() async {
    // initial fetch count dari Report feature
    return 0;
  }
  
  Future<Either<Failure, void>> logout() async {
    final result = await logoutUseCase();
    return result;
  }

}
