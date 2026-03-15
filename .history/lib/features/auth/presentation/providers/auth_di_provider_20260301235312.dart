import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pos/features/auth/domain/usecases/login_use_case.dart';
import 'package:pos/features/auth/domain/usecases/logout_use_case.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});
