import 'package:patroli/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:patroli/features/auth/domain/usecases/login_use_case.dart';
import 'package:patroli/features/auth/domain/usecases/logout_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_di_provider.g.dart';

@riverpod
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
LogoutUseCase logoutUseCase(Ref ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
}
