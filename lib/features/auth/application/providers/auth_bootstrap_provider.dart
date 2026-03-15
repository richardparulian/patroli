import 'package:pos/features/auth/application/providers/auth_session_provider.dart';
import 'package:pos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_bootstrap_provider.g.dart';

@Riverpod(keepAlive: true)
Future<bool> authBootstrap(Ref ref) async {
  final repository = ref.watch(authRepositoryProvider);
  final sessionNotifier = ref.read(authSessionProvider.notifier);

  final isAuthenticatedResult = await repository.isAuthenticated();

  return await isAuthenticatedResult.fold(
    (_) async {
      sessionNotifier.clear();
      return false;
    },
    (isAuthenticated) async {
      if (!isAuthenticated) {
        sessionNotifier.clear();
        return false;
      }

      final currentUserResult = await repository.getCurrentUser();

      return currentUserResult.fold(
        (_) {
          sessionNotifier.clear();
          return false;
        },
        (user) {
          sessionNotifier.setUser(user);
          return true;
        },
      );
    },
  );
}
